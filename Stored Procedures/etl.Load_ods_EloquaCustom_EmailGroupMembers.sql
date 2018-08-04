SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[Load_ods_EloquaCustom_EmailGroupMembers]
(
	@BatchId NVARCHAR(50) = null,
	@Options NVARCHAR(MAX) = null
)
AS 

BEGIN
/**************************************Comments***************************************
**************************************************************************************
Mod #:  1
Name:     SSBCLOUD\dhorstman
Date:     07/25/2016
Comments: Initial creation
*************************************************************************************/

SET @BatchId = ISNULL(@BatchId, CONVERT(NVARCHAR(50), NEWID()))

DECLARE @RunTime DATETIME = GETDATE()

DECLARE @ExecutionId uniqueidentifier = newid();
DECLARE @ProcedureName nvarchar(255) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
DECLARE @SrcRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM stg.EloquaCustom_EmailGroupMembers),'0');	
DECLARE @SrcDataSize NVARCHAR(255) = '0'

/*Load Options into a temp table*/
SELECT Col1 AS OptionKey, Col2 as OptionValue INTO #Options FROM [dbo].[SplitMultiColumn](@Options, '=', ';')

DECLARE @DisableDelete nvarchar(5) = ISNULL((SELECT OptionValue FROM #Options WHERE OptionKey = 'DisableDelete'),'true')

BEGIN TRY 

PRINT 'Execution Id: ' + CONVERT(NVARCHAR(100),@ExecutionId)

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Procedure Processing', 'Start', @ExecutionId
EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Src Row Count', @SrcRowCount, @ExecutionId
EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Src DataSize', @SrcDataSize, @ExecutionId

SELECT CAST(NULL AS BINARY(32)) ETL_DeltaHashKey
,  EmailGroup, ContactID, JaguarsID, FirstName, LastName, Salutation, HomePhone, BusinessPhone, PrimaryPhoneNumber, EmailAddress, Company, Address1, Address2, City, StateorProvince, ZiporPostalCode, Country, Salesperson, TicketType, SeasonTicketMember, RenewedCurrentYear, RookieSeasonTicketMember, PastSeasonTicketMember, MiniPackBuyer, SYS_OptIn, SYS_OptInDate
INTO #SrcData
FROM (
	SELECT  EmailGroup, ContactID, JaguarsID, FirstName, LastName, Salutation, HomePhone, BusinessPhone, PrimaryPhoneNumber, EmailAddress, Company, Address1, Address2, City, StateorProvince, ZiporPostalCode, Country, Salesperson, TicketType, SeasonTicketMember, RenewedCurrentYear, RookieSeasonTicketMember, PastSeasonTicketMember, MiniPackBuyer, SYS_OptIn, SYS_OptInDate
	, ROW_NUMBER() OVER(PARTITION BY ContactID, EmailGroup ORDER BY ETL_ID) RowRank
	FROM stg.EloquaCustom_EmailGroupMembers
) a
WHERE RowRank = 1

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Src Table Setup', 'Temp Table Loaded', @ExecutionId

UPDATE #SrcData
SET ETL_DeltaHashKey = HASHBYTES('sha2_256', ISNULL(RTRIM(Address1),'DBNULL_TEXT') + ISNULL(RTRIM(Address2),'DBNULL_TEXT') + ISNULL(RTRIM(BusinessPhone),'DBNULL_TEXT') + ISNULL(RTRIM(City),'DBNULL_TEXT') + ISNULL(RTRIM(Company),'DBNULL_TEXT') + ISNULL(RTRIM(ContactID),'DBNULL_TEXT') + ISNULL(RTRIM(Country),'DBNULL_TEXT') + ISNULL(RTRIM(EmailAddress),'DBNULL_TEXT') + ISNULL(RTRIM(EmailGroup),'DBNULL_TEXT') + ISNULL(RTRIM(FirstName),'DBNULL_TEXT') + ISNULL(RTRIM(HomePhone),'DBNULL_TEXT') + ISNULL(RTRIM(JaguarsID),'DBNULL_TEXT') + ISNULL(RTRIM(LastName),'DBNULL_TEXT') + ISNULL(RTRIM(MiniPackBuyer),'DBNULL_TEXT') + ISNULL(RTRIM(PastSeasonTicketMember),'DBNULL_TEXT') + ISNULL(RTRIM(PrimaryPhoneNumber),'DBNULL_TEXT') + ISNULL(RTRIM(RenewedCurrentYear),'DBNULL_TEXT') + ISNULL(RTRIM(RookieSeasonTicketMember),'DBNULL_TEXT') + ISNULL(RTRIM(Salesperson),'DBNULL_TEXT') + ISNULL(RTRIM(Salutation),'DBNULL_TEXT') + ISNULL(RTRIM(SeasonTicketMember),'DBNULL_TEXT') + ISNULL(RTRIM(StateorProvince),'DBNULL_TEXT') + ISNULL(RTRIM(SYS_OptIn),'DBNULL_TEXT') + ISNULL(RTRIM(SYS_OptInDate),'DBNULL_TEXT') + ISNULL(RTRIM(TicketType),'DBNULL_TEXT') + ISNULL(RTRIM(ZiporPostalCode),'DBNULL_TEXT'))

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Src Table Setup', 'ETL_Sync_DeltaHashKey Set', @ExecutionId

CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (ContactID, EmailGroup)
CREATE NONCLUSTERED INDEX IDX_ETL_Sync_DeltaHashKey ON #SrcData (ETL_DeltaHashKey)

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Src Table Setup', 'Temp Table Indexes Created', @ExecutionId

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Merge Statement Execution', 'Start', @ExecutionId

MERGE ods.EloquaCustom_EmailGroupMembers AS myTarget
USING #SrcData AS mySource
ON myTarget.ContactID = mySource.ContactID
AND myTarget.EmailGroup = mySource.EmailGroup

WHEN MATCHED AND (
     ISNULL(mySource.ETL_DeltaHashKey,-1) <> ISNULL(myTarget.ETL_DeltaHashKey, -1)
	 
)
THEN UPDATE SET
      myTarget.[ETL_UpdatedDate] = @RunTime
     ,myTarget.[ETL_IsDeleted] = 0
     ,myTarget.[ETL_DeletedDate] = NULL
     ,myTarget.[ETL_DeltaHashKey] = mySource.[ETL_DeltaHashKey]
     ,myTarget.[EmailGroup] = mySource.[EmailGroup]
     ,myTarget.[ContactID] = mySource.[ContactID]
     ,myTarget.[JaguarsID] = mySource.[JaguarsID]
     ,myTarget.[FirstName] = mySource.[FirstName]
     ,myTarget.[LastName] = mySource.[LastName]
     ,myTarget.[Salutation] = mySource.[Salutation]
     ,myTarget.[HomePhone] = mySource.[HomePhone]
     ,myTarget.[BusinessPhone] = mySource.[BusinessPhone]
     ,myTarget.[PrimaryPhoneNumber] = mySource.[PrimaryPhoneNumber]
     ,myTarget.[EmailAddress] = mySource.[EmailAddress]
     ,myTarget.[Company] = mySource.[Company]
     ,myTarget.[Address1] = mySource.[Address1]
     ,myTarget.[Address2] = mySource.[Address2]
     ,myTarget.[City] = mySource.[City]
     ,myTarget.[StateorProvince] = mySource.[StateorProvince]
     ,myTarget.[ZiporPostalCode] = mySource.[ZiporPostalCode]
     ,myTarget.[Country] = mySource.[Country]
     ,myTarget.[Salesperson] = mySource.[Salesperson]
     ,myTarget.[TicketType] = mySource.[TicketType]
     ,myTarget.[SeasonTicketMember] = mySource.[SeasonTicketMember]
     ,myTarget.[RenewedCurrentYear] = mySource.[RenewedCurrentYear]
     ,myTarget.[RookieSeasonTicketMember] = mySource.[RookieSeasonTicketMember]
     ,myTarget.[PastSeasonTicketMember] = mySource.[PastSeasonTicketMember]
     ,myTarget.[MiniPackBuyer] = mySource.[MiniPackBuyer]
     ,myTarget.[SYS_OptIn] = mySource.[SYS_OptIn]
     ,myTarget.[SYS_OptInDate] = mySource.[SYS_OptInDate]
     
--WHEN NOT MATCHED BY SOURCE THEN DELETE

WHEN NOT MATCHED BY Target
THEN INSERT
     ([ETL_CreatedDate]
     ,[ETL_UpdatedDate]
     ,[ETL_IsDeleted]
     ,[ETL_DeletedDate]
     ,[ETL_DeltaHashKey]
     ,[EmailGroup]
     ,[ContactID]
     ,[JaguarsID]
     ,[FirstName]
     ,[LastName]
     ,[Salutation]
     ,[HomePhone]
     ,[BusinessPhone]
     ,[PrimaryPhoneNumber]
     ,[EmailAddress]
     ,[Company]
     ,[Address1]
     ,[Address2]
     ,[City]
     ,[StateorProvince]
     ,[ZiporPostalCode]
     ,[Country]
     ,[Salesperson]
     ,[TicketType]
     ,[SeasonTicketMember]
     ,[RenewedCurrentYear]
     ,[RookieSeasonTicketMember]
     ,[PastSeasonTicketMember]
     ,[MiniPackBuyer]
     ,[SYS_OptIn]
     ,[SYS_OptInDate]
     )
VALUES
     (@RunTime
     ,@RunTime
     ,0
     ,NULL
     ,mySource.[ETL_DeltaHashKey]
     ,mySource.[EmailGroup]
     ,mySource.[ContactID]
     ,mySource.[JaguarsID]
     ,mySource.[FirstName]
     ,mySource.[LastName]
     ,mySource.[Salutation]
     ,mySource.[HomePhone]
     ,mySource.[BusinessPhone]
     ,mySource.[PrimaryPhoneNumber]
     ,mySource.[EmailAddress]
     ,mySource.[Company]
     ,mySource.[Address1]
     ,mySource.[Address2]
     ,mySource.[City]
     ,mySource.[StateorProvince]
     ,mySource.[ZiporPostalCode]
     ,mySource.[Country]
     ,mySource.[Salesperson]
     ,mySource.[TicketType]
     ,mySource.[SeasonTicketMember]
     ,mySource.[RenewedCurrentYear]
     ,mySource.[RookieSeasonTicketMember]
     ,mySource.[PastSeasonTicketMember]
     ,mySource.[MiniPackBuyer]
     ,mySource.[SYS_OptIn]
     ,mySource.[SYS_OptInDate]
     )
;

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Merge Statement Execution', 'Complete', @ExecutionId

END TRY 
BEGIN CATCH 

	DECLARE @ErrorMessage nvarchar(4000) = ERROR_MESSAGE();
	DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
	DECLARE @ErrorState INT = ERROR_STATE();
			
	PRINT @ErrorMessage
	EXEC etl.LogEventRecordDB @Batchid, 'Error', @ProcedureName, 'Merge Load', 'Merge Error', @ErrorMessage, @ExecutionId
	EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Procedure Processing', 'Complete', @ExecutionId

	RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

END CATCH

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Procedure Processing', 'Complete', @ExecutionId


END

GO
