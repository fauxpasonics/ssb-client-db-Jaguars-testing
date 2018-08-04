SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









CREATE PROCEDURE [etl].[sp_EloquaOutbound_DynamicsAccount]
AS

DECLARE @RunDate DATE = GETDATE()
DECLARE @RunTime DATETIME = GETDATE()
DECLARE @ProcName VARCHAR(200) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID)
DECLARE @LoadCount INT
DECLARE @ErrorMessage NVARCHAR(4000) 
DECLARE @ErrorSeverity INT			 
DECLARE @ErrorState INT

DECLARE @RecordsPerArray INT = 500

--========================================================================================================================
BEGIN TRY
--========================================================================================================================

	--=========================================================================================================
	--PRODUCTION
	--=========================================================================================================

	SELECT M_MSCRMAccountID				AS MSCRMAccountID2
		  ,Address1						AS address
		  ,Address2						AS address2
		  ,Address3						AS address3
		  ,M_Annual_Revenue1			AS annualRevenue
		  ,BusinessPhone				AS businessPhone
		  ,City							AS city
		  --,M_elqCompanyCategory			AS companyCategory
		  ,M_CompanyName				AS CompanyName
		  ,M_Corporate_Account1			AS corporateAccount
		  ,Country						AS country
		  ,M_Fax1						AS fax
		  ,M_Industry1					AS industry
		  ,M_Season_Ticket_Member_1		AS seasonTicketMember
		  ,M_State_Prov					AS stateOrProvince
		  --,M_Wesbsite1					AS wesbsite
		  ,M_Zip_Postal					AS ZIPorPostalCode

		  ,HASHBYTES('sha2_256', ISNULL(RTRIM(Address1						),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(Address2						),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(Address3						),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(M_Annual_Revenue1				),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(BusinessPhone					),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(City							),'DBNULL_TEXT')
	  						   --+ ISNULL(RTRIM(M_elqCompanyCategory			),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(M_CompanyName					),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(M_Corporate_Account1			),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(Country						),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(M_Fax1						),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(M_Industry1					),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(M_Season_Ticket_Member_1		),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(M_State_Prov					),'DBNULL_TEXT')
	  						   --+ ISNULL(RTRIM(M_Wesbsite1					),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(M_Zip_Postal					),'DBNULL_TEXT'))		[ValueHash]	  	
	INTO #PROD
	FROM ods.Eloqua_Account

	CREATE NONCLUSTERED INDEX IX_ID ON #PROD (MSCRMAccountID2)
	CREATE NONCLUSTERED INDEX IX_ValueHash ON #PROD (ValueHash)

	--=========================================================================================================
	--STAGING
	--=========================================================================================================

	SELECT MSCRMAccountID2
		  ,address
		  ,address2
		  ,address3
		  ,annualRevenue
		  ,businessPhone
		  ,city
		  --,companyCategory
		  ,CompanyName
		  ,corporateAccount
		  ,country
		  ,fax
		  ,industry
		  ,seasonTicketMember
		  ,stateOrProvince
		  --,wesbsite
		  ,ZIPorPostalCode
		  ,HASHBYTES('sha2_256', ISNULL(RTRIM(address				),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(address2				),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(address3				),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(annualRevenue			),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(businessPhone			),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(city					),'DBNULL_TEXT')
	  						   --+ ISNULL(RTRIM(companyCategory		),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(CompanyName			),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(corporateAccount		),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(country				),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(fax					),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(industry				),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(seasonTicketMember	),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(stateOrProvince		),'DBNULL_TEXT')
	  						   --+ ISNULL(RTRIM(wesbsite				),'DBNULL_TEXT')
	  						   + ISNULL(RTRIM(ZIPorPostalCode		),'DBNULL_TEXT')
																					)		[ValueHash]	  	
	INTO #STG
	FROM [etl].[vw_EloquaOutbound_DynamicsAccount]

	CREATE NONCLUSTERED INDEX IX_ID			ON #STG (MSCRMAccountID2)
	CREATE NONCLUSTERED INDEX IX_ValueHash	ON #STG (ValueHash)



	--=========================================================================================================
	--OUTPUT TEMP
	--=========================================================================================================

	CREATE TABLE #Temp(
	[RowNumber]					INT IDENTITY(1,1)
	,[MSCRMAccountID2]          VARCHAR(100)      
	,[address]                  NVARCHAR(250)       
	,[address2]                 NVARCHAR(250)       
	,[address3]                 NVARCHAR(250)       
	,[annualRevenue]            MONEY       
	,[businessPhone]            NVARCHAR(50)       
	,[city]                     NVARCHAR(80)       
	--,[companyCategory]          NVARCHAR(500)       
	,[CompanyName]              NVARCHAR(160)       
	,[corporateAccount]         BIT       
	,[country]                  NVARCHAR(80)       
	,[fax]                      NVARCHAR(50)       
	,[industry]                 NVARCHAR(100)       
	,[seasonTicketMember]       BIT       
	,[stateOrProvince]          NVARCHAR(50)       
	--,[wesbsite]                 NVARCHAR(200)       
	,[ZIPorPostalCode]          NVARCHAR(20)       
	)

	INSERT INTO #Temp

	SELECT  stg.[MSCRMAccountID2]    
		   ,stg.[address]            
		   ,stg.[address2]           
		   ,stg.[address3]           
		   ,stg.[annualRevenue]      
		   ,stg.[businessPhone]      
		   ,stg.[city]               
		   --,stg.[companyCategory]    
		   ,stg.[CompanyName]        
		   ,stg.[corporateAccount]   
		   ,stg.[country]            
		   ,stg.[fax]                
		   ,stg.[industry]           
		   ,stg.[seasonTicketMember] 
		   ,stg.[stateOrProvince]    
		   --,stg.[wesbsite]           
		   ,stg.[ZIPorPostalCode]    
	FROM #STG stg
		JOIN #PROD prod ON stg.[MSCRMAccountID2] = prod.[MSCRMAccountID2]
	WHERE stg.ValueHash <> prod.ValueHash

	SET @LoadCount = @@ROWCOUNT

	--=========================================================================================================
	--Load [ods].[API_OutboundQueue]
	--=========================================================================================================

	DECLARE @Step INT = 0

	IF @LoadCount > 0
	BEGIN

		WHILE @Step * @RecordsPerArray < @LoadCount
		BEGIN
			INSERT INTO [ods].[API_OutboundQueue] ([APIName] ,[APIEntity] ,[EndpointName],[Json_Payload],[httpAction],[Description], [Queue_CreatedOn], [Queue_UpdatedOn])

			SELECT 'API'																						AS [APIName] 
				   ,'accounts'																					AS [APIEntity] 
				   ,'accounts/imports/56/data'																					AS [EndpointName]
				   ,(SELECT [MSCRMAccountID2]    
						   ,[address]            
						   ,[address2]           
						   ,[address3]           
						   ,[annualRevenue]      
						   ,[businessPhone]      
						   ,[city]               
						   --,[companyCategory]    
						   ,[companyName]        
						   ,[corporateAccount]   
						   ,[country]            
						   ,[fax]                
						   ,[industry]           
						   ,[seasonTicketMember] 
						   ,[stateOrProvince]    
						   --,[wesbsite]           
						   ,[ZIPorPostalCode]    						
					 FROM #temp
					 WHERE RowNumber > @Step*@RecordsPerArray
						   AND RowNumber <= (@Step + 1)*@RecordsPerArray
					 FOR JSON PATH)																				AS [Json_Payload]
				  ,'POST'																							AS [httpAction]
				  ,'Eloqua Account to be updated'																AS [Description] 
				  ,GETDATE()																					AS [Queue_CreatedOn]
				  ,GETDATE()																					AS [Queue_UpdatedOn]
			
			SET @Step += 1
		END

	END

	

	/*====================================================================================================
												LOG RESULTS
	====================================================================================================*/

	INSERT INTO etl.EloquaOutbound_log (
	RunDate			--DATE				
	,ProcName		--VARCHAR(100)
	,StartTime		--DATETIME
	,EndTime		--DATETIME
	,Completed		--BIT
	,LoadCount		--INT
	,ErrorMessage	--NVARCHAR(4000)
	,ErrorSeverity  --INT
	,ErrorState	    --INT
	)


	VALUES(
	@RunDate
	,@ProcName
	,@RunTime
	,GETDATE()
	,1
	,@LoadCount
	,NULL
	,NULL
	,NULL
	)

--========================================================================================================================
END TRY
--========================================================================================================================


--========================================================================================================================
BEGIN CATCH
--========================================================================================================================



	/*====================================================================================================
												LOG ERRORS
	====================================================================================================*/

	SET @ErrorMessage  = ERROR_MESSAGE()	
	SET @ErrorSeverity = ERROR_SEVERITY()	
	SET @ErrorState	   = ERROR_STATE()	


	INSERT INTO etl.EloquaOutbound_log (
	RunDate			--DATE
	,ProcName		--VARCHAR(100)
	,StartTime		--DATETIME
	,EndTime		--DATETIME
	,Completed		--BIT
	,LoadCount		--INT
	,ErrorMessage	--NVARCHAR(4000)
	,ErrorSeverity  --INT
	,ErrorState	    --INT
	)

	VALUES(
	@RunDate
	,@ProcName
	,@RunTime
	,GETDATE()
	,0
	,NULL
	,@ErrorMessage 
	,@ErrorSeverity
	,@ErrorState	  
	)

--========================================================================================================================
END CATCH
--========================================================================================================================

DROP TABLE #PROD
DROP TABLE #STG
DROP TABLE #Temp



GO
