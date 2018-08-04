SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









CREATE PROCEDURE [etl].[sp_EloquaOutbound_DynamicsContact]
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

	SELECT EmailAddress								AS emailAddress
		  ,C_MSCRMContactID							AS MS_CRM_ContactId
		  ,BusinessPhone							AS businessPhone
		  ,City										AS city
		  ,FirstName								AS firstName
		  ,LastName									AS lastName
		  ,C_Jaguars_ID1							AS jaguarsId
		  ,C_MSCRMAccountID							AS MS_CRM_AccounttId
		  ,C_Company_Decision_Maker1				AS companyDecisionMaker
		  ,C_Lead_Score								AS leadScore
		  ,C_Lead_Source___Most_Recent1				AS leadSourceMostRecent
		  ,C_Lead_Source___Original1				AS leadSourceOriginal
		  ,C_Credit_Card_Exp_Month1					AS creditCardExpMonth
		  ,C_Credit_Card_Exp_Year1					AS creditCardExpYear
		  ,C_Distance_to_Client_Venue1				AS distanceToClientVenue
		  ,C_Discretionary_Income_Index1			AS discretionaryIncomeIndex
		  ,C_Favorite_Jaguars_Player1				AS favoriteJaguarsPlayer
		  ,C_Favorite_NFL_Opponent1					AS favoriteNFLOpponent
		  ,C_Propensity_Towards_Football1			AS propensityTowardsFootball
		  ,C_Gender1								AS gender
		  ,C_Job_Role1								AS jobTitle
		  ,C_Mini_Pack_Buyer_1						AS miniPackBuyer
		  ,C_Marital_Status_in_Household1			AS maritalStatus
		  ,C_Past_Season_Ticket_Member_1			AS pastSeasonTicketMember
		  ,C_Renewed_Current_Year_1					AS renewedCurrentYear
		  ,C_Rookie_Season_Ticket_Member_1			AS rookieSeasonTicketMember
		  ,C_Season_Ticket_Member_1					AS seasonTicketMember
		  ,C_Ticket_Type1							AS ticketType
		  ,C_Ticket_Price_Average1					AS ticketPriceAvg
		  ,C_Unsubscribed1							AS unsubscribed
		  ,C_Product_Solution_of_Interest1			AS productOfInterest                            		                                                
		  ,HASHBYTES('sha2_256', ISNULL(RTRIM(C_MSCRMContactID					),'DBNULL_TEXT')
							   + ISNULL(RTRIM(BusinessPhone						),'DBNULL_TEXT')          
							   + ISNULL(RTRIM(City								),'DBNULL_TEXT')                  
		  					   + ISNULL(RTRIM(FirstName							),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(LastName							),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Jaguars_ID1						),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_MSCRMAccountID					),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Company_Decision_Maker1			),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Lead_Score						),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Lead_Source___Most_Recent1		),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Lead_Source___Original1			),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Credit_Card_Exp_Month1			),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Credit_Card_Exp_Year1			),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Distance_to_Client_Venue1		),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Discretionary_Income_Index1		),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Favorite_Jaguars_Player1		),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Favorite_NFL_Opponent1			),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Propensity_Towards_Football1	),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Gender1							),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Job_Role1						),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Mini_Pack_Buyer_1				),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Marital_Status_in_Household1	),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Past_Season_Ticket_Member_1		),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Renewed_Current_Year_1			),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Rookie_Season_Ticket_Member_1	),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Season_Ticket_Member_1			),'DBNULL_TEXT')          
							   + ISNULL(RTRIM(C_Ticket_Type1					),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(C_Ticket_Price_Average1			),'DBNULL_TEXT')          
							   + ISNULL(RTRIM(C_Unsubscribed1					),'DBNULL_TEXT')		  
							   + ISNULL(RTRIM(C_Product_Solution_of_Interest1	),'DBNULL_TEXT')          
							   )		[ValueHash]	  	
	INTO #PROD
	FROM ods.Eloqua_Contact

	CREATE NONCLUSTERED INDEX IX_ID ON #PROD (emailAddress)
	CREATE NONCLUSTERED INDEX IX_ValueHash ON #PROD (ValueHash)

	--=========================================================================================================
	--STAGING
	--=========================================================================================================

	SELECT emailAddress
		  ,MS_CRM_ContactId
		  ,businessPhone
		  ,city
		  ,firstName
		  ,lastName
		  ,jaguarsId
		  ,MS_CRM_AccounttId
		  ,companyDecisionMaker
		  ,leadScore
		  ,leadSourceMostRecent
		  ,leadSourceOriginal
		  ,creditCardExpMonth
		  ,creditCardExpYear
		  ,distanceToClientVenue
		  ,discretionaryIncomeIndex
		  ,favoriteJaguarsPlayer
		  ,favoriteNFLOpponent
		  ,propensityTowardsFootball
		  ,gender
		  ,jobTitle
		  ,miniPackBuyer
		  ,maritalStatus
		  ,pastSeasonTicketMember
		  ,renewedCurrentYear
		  ,rookieSeasonTicketMember
		  ,seasonTicketMember
		  ,ticketType
		  ,ticketPriceAvg
		  ,unsubscribed
		  ,productOfInterest

		  ,HASHBYTES('sha2_256', ISNULL(RTRIM(MS_CRM_ContactId			   ),'DBNULL_TEXT')
							   + ISNULL(RTRIM(BusinessPhone				   ),'DBNULL_TEXT')       
							   + ISNULL(RTRIM(city                         ),'DBNULL_TEXT')            
							   + ISNULL(RTRIM(firstName                    ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(lastName                     ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(jaguarsId                    ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(MS_CRM_AccounttId            ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(companyDecisionMaker         ),'DBNULL_TEXT')          --UNCOMMENT AFTER ODS DEFINITION IS UPDATED
		  					   + ISNULL(RTRIM(leadScore                    ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(leadSourceMostRecent         ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(leadSourceOriginal           ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(creditCardExpMonth           ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(creditCardExpYear            ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(distanceToClientVenue        ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(discretionaryIncomeIndex     ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(favoriteJaguarsPlayer        ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(favoriteNFLOpponent          ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(propensityTowardsFootball    ),'DBNULL_TEXT')                 
		  					   + ISNULL(RTRIM(gender                       ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(jobTitle                     ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(miniPackBuyer                ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(maritalStatus                ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(pastSeasonTicketMember       ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(renewedCurrentYear           ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(rookieSeasonTicketMember     ),'DBNULL_TEXT')          
		  					   + ISNULL(RTRIM(seasonTicketMember           ),'DBNULL_TEXT')             
		  					   + ISNULL(RTRIM(ticketType                   ),'DBNULL_TEXT')             
							   + ISNULL(RTRIM(ticketPriceAvg               ),'DBNULL_TEXT')          --UNCOMMENT AFTER ODS DEFINITION IS UPDATED
							   + ISNULL(RTRIM(unsubscribed                 ),'DBNULL_TEXT')          --UNCOMMENT AFTER ODS DEFINITION IS UPDATED
							   + ISNULL(RTRIM(productOfInterest            ),'DBNULL_TEXT')     ) [ValueHash]	  	
	INTO #STG
	FROM etl.vw_EloquaOutbound_DynamicsContact

	CREATE NONCLUSTERED INDEX IX_ID			ON #STG (emailAddress)
	CREATE NONCLUSTERED INDEX IX_ValueHash	ON #STG (ValueHash)


	--=========================================================================================================
	--OUTPUT TEMP
	--=========================================================================================================

	CREATE TABLE #Temp(
	 RowNumber						  INT IDENTITY(1,1)
	,[EmailAddress]					  NVARCHAR(2000)
	,[MS_CRM_ContactId]				  UNIQUEIDENTIFIER
	,[businessPhone]               	  NVARCHAR(50)
	,[city]                        	  NVARCHAR(80)
	,[companyDecisionMaker]        	  BIT
	,[creditCardExpMonth]          	  NVARCHAR(2)
	,[creditCardExpYear]           	  NVARCHAR(2)
	,[discretionaryIncomeIndex]    	  INT
	,[distanceToClientVenue]       	  INT
	,[favoriteJaguarsPlayer]       	  NVARCHAR(50)
	,[favoriteNFLOpponent]         	  NVARCHAR(50)
	,[firstName]                   	  NVARCHAR(50)
	,[gender]                      	  INT
	,[jaguarsId]                   	  NVARCHAR(100)
	,[jobTitle]                    	  NVARCHAR(100)
	,[lastName]                    	  NVARCHAR(50)
	,[leadScore]                   	  INT
	,[leadSourceMostRecent]        	  NVARCHAR(128)
	,[leadSourceOriginal]          	  NVARCHAR(128)
	,[maritalStatus]               	  INT
	,[miniPackBuyer]               	  BIT
	,[MS_CRM_AccounttId]           	  UNIQUEIDENTIFIER
	,[pastSeasonTicketMember]      	  BIT
	,[productOfInterest]           	  NVARCHAR(100)
	,[propensityTowardsFootball]   	  INT
	,[renewedCurrentYear]          	  BIT
	,[rookieSeasonTicketMember]    	  BIT
	,[seasonTicketMember]          	  BIT
	,[ticketPriceAvg]              	  MONEY
	,[ticketType]                  	  NVARCHAR(100)
	,[unsubscribed]                	  BIT

)

	INSERT INTO #Temp

	SELECT  stg.[emailAddress]
		   ,stg.[MS_CRM_ContactId]			
		   ,stg.[businessPhone]            
		   ,stg.[city]                     
		   ,stg.[companyDecisionMaker]     
		   ,stg.[creditCardExpMonth]       
		   ,stg.[creditCardExpYear]                 
		   ,stg.[discretionaryIncomeIndex] 
		   ,stg.[distanceToClientVenue]           
		   ,stg.[favoriteJaguarsPlayer]    
		   ,stg.[favoriteNFLOpponent]      
		   ,stg.[firstName]                
		   ,stg.[gender]                   
		   ,stg.[jaguarsId]                
		   ,stg.[jobTitle]                 
		   ,stg.[lastName]                 
		   ,stg.[leadScore]                
		   ,stg.[leadSourceMostRecent]     
		   ,stg.[leadSourceOriginal]       
		   ,stg.[maritalStatus]            
		   ,stg.[miniPackBuyer]            
		   ,stg.[MS_CRM_AccounttId]        
		   ,stg.[pastSeasonTicketMember]   
		   ,stg.[productOfInterest]        
		   ,stg.[propensityTowardsFootball]
		   ,stg.[renewedCurrentYear]       
		   ,stg.[rookieSeasonTicketMember] 
		   ,stg.[seasonTicketMember]       
		   ,stg.[ticketPriceAvg]           
		   ,stg.[ticketType]               
		   ,stg.[unsubscribed]             	   
	FROM #STG stg
		JOIN #PROD prod ON prod.emailAddress = stg.emailAddress
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
				   ,'contacts'																					AS [APIEntity] 
				   ,'contacts/imports/59/data'																	AS [EndpointName]
				   ,(SELECT  [emailAddress]
							,[MS_CRM_ContactId]			
				   			,[businessPhone]            
				   			,[city]                     
				   			,[companyDecisionMaker]     
				   			,[creditCardExpMonth]       
				   			,[creditCardExpYear]                   
				   			,[discretionaryIncomeIndex] 
				   			,[distanceToClientVenue]            
				   			,[favoriteJaguarsPlayer]    
				   			,[favoriteNFLOpponent]      
				   			,[firstName]                
				   			,[gender]                   
				   			,[jaguarsId]                
				   			,[jobTitle]                 
				   			,[lastName]                 
				   			,[leadScore]                
				   			,[leadSourceMostRecent]     
				   			,[leadSourceOriginal]       
				   			,[maritalStatus]            
				   			,[miniPackBuyer]            
				   			,[MS_CRM_AccounttId]        
				   			,[pastSeasonTicketMember]   
				   			,[productOfInterest]        
				   			,[propensityTowardsFootball]
				   			,[renewedCurrentYear]       
				   			,[rookieSeasonTicketMember] 
				   			,[seasonTicketMember]       
							,[ticketPriceAvg]           
							,[ticketType]               
							,[unsubscribed]             	
					 FROM #Temp
					 WHERE RowNumber > @Step*@RecordsPerArray
						   AND RowNumber <= (@Step + 1)*@RecordsPerArray
					 FOR JSON PATH)																				AS [Json_Payload]
				  ,'POST'																						AS [httpAction]
				  ,'Eloqua Contact to be updated'																AS [Description] 
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
