SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











CREATE PROCEDURE [etl].[sp_EloquaOutbound_Ticketing]

--WITH EXEC AS OWNER	--Allow the calling user to perform all operations inside the PROC as long as they have permission to execute the PROC (eg insert/deletes to tables)

AS

DECLARE @RunDate DATE = GETDATE()
DECLARE @RunTime DATETIME = GETDATE()
DECLARE @ProcName VARCHAR(200) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID)
DECLARE @LoadCount INT = (SELECT COUNT(*) FROM  [etl].[vw_EloquaOutbound_Ticketing])
DECLARE @ErrorMessage NVARCHAR(4000) 
DECLARE @ErrorSeverity INT			 
DECLARE @ErrorState INT		

DECLARE	@RecordsPerArray INT = 500
/*========================================================================================================================
													START TRY
========================================================================================================================*/

BEGIN TRY

	/*====================================================================================================
													LOAD STAGING
	====================================================================================================*/

	CREATE TABLE #stg (
	RowNumber INT IDENTITY(1,1)
	,id	int
	,email	nvarchar(255)
	,salesDate	datetime
	,eventName	nvarchar(200)
	,eventDate	date
	,majorCategory	nvarchar(255)
	,minorCategory	nvarchar(255)
	,section	nvarchar(50)
	,row	nvarchar(50)
	,seat	int
	,ticketType	nvarchar(255)
	,promo	nvarchar(255)
	,isPremium	bit
	,isSingleEvent	bit
	,isPlan	bit
	,isPartial	bit
	,isGroup	bit
	,isRenewal	bit
	,isAttended	bit
	,paidAmmount	decimal(38,20)
	)

	INSERT INTO #stg

	SELECT [id]
			,[email]  
			,[salesDate]  
			,[eventName]  
			,[eventDate]  
			,[majorCategory]  
			,[minorCategory]  
			,[section]  
			,[row]  
			,[seat]  
			,[ticketType]  
			,[promo]  
			,[isPremium]  
			,[isSingleEvent]  
			,[isPlan]  
			,[isPartial]  
			,[isGroup]  
			,[isRenewal]  
			,[isAttended]  
			,[paidAmmount]	
	FROM etl.vw_EloquaOutbound_Ticketing (NOLOCK)

	/*====================================================================================================
													LOAD API_OutboundQueue
	====================================================================================================*/

	DECLARE @Step INT = 0

	IF @LoadCount > 0
	BEGIN

		WHILE @Step * @RecordsPerArray < @LoadCount
		BEGIN
			INSERT INTO [ods].[API_OutboundQueue]  ([APIName] ,[APIEntity] ,[EndpointName],[Json_Payload],[httpAction],[Description], [Queue_CreatedOn], [Queue_UpdatedOn])

			SELECT 'API'																						AS [APIName] 
				   ,'ticketing'																					AS [APIEntity] 
				   ,'customObjects/70/imports/58/data'															AS [EndpointName]
				   ,(SELECT [id]	
						   ,[email]  
				   		   ,[salesDate]  
				   		   ,[eventName]  
				   		   ,[eventDate]  
				   		   ,[majorCategory]  
				   		   ,[minorCategory]  
				   		   ,[section]  
				   		   ,[row]  
				   		   ,[seat]  
				   		   ,[ticketType]  
				   		   ,[promo]  
				   		   ,[isPremium]  
				   		   ,[isSingleEvent]  
				   		   ,[isPlan]  
				   		   ,[isPartial]  
				   		   ,[isGroup]  
				   		   ,[isRenewal]  
				   		   ,[isAttended]  
				   		   ,[paidAmmount]	
				   	FROM #stg
					 WHERE RowNumber > @Step*@RecordsPerArray
						   AND RowNumber <= (@Step + 1)*@RecordsPerArray
					 FOR JSON PATH)																				AS [Json_Payload]
				  ,'POST'																						AS [httpAction]
				  ,'Eloqua Ticketing Object to be updated'														AS [Description] 
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

END TRY
/*========================================================================================================================
													START CATCH
========================================================================================================================*/

BEGIN CATCH

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

END CATCH



GO
