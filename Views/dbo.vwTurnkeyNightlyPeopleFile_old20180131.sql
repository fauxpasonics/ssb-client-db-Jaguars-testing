SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[vwTurnkeyNightlyPeopleFile_old20180131] 

AS

--TM
SELECT  ts.TicketingSystemAccountID AS TicketingAccountID,
		CONVERT(VARCHAR(50), CONCAT(RTRIM(DC.SourceSystem),':',LTRIM(DC.SSID))) AS PersonID,	--	updated 11/11/16 ameitin
		DC.Firstname AS FirstName,
		DC.LastName AS LastName,
		COALESCE(DC.EmailOne, DC.EmailTwo) AS WorkEmailAddress,
		COALESCE(FullName,DC.FirstName + ' ' + DC.Lastname) Business_Name,
		DC.[AddressPrimaryStreet] AS BusinessAddress1,
		DC.[AddressPrimaryCity] AS BusinessCity,
		DC.[AddressPrimaryState] AS BusinessState,
		DC.[AddressPrimaryZip] AS BusinessPostalCode,
		DC.[AddressPrimaryCountry] AS BusinessCountry,
		DC.[PhoneBusiness] AS Phone
FROM [dbo].[vwDimCustomer_ModAcctId] DC
	JOIN dbo.TurnkeyQualifiedSubmissions ts ON dc.[AccountID] = ts.TicketingSystemAccountID 
											   AND ts.SourceSystem = dc.sourcesystem
WHERE dc.isbusiness = 0
	  --AND ts.SubmitDate > DATEADD(DAY,-2,GETDATE())			--	un-comment after first run DCH 2017-04-14
	  AND [DC].[CustomerType] = 'Primary'
	  AND ts.SourceSystem = 'tm'

UNION ALL

--CRM
SELECT  ts.TicketingSystemAccountID AS TicketingAccountID,
		CONVERT(VARCHAR(50), CONCAT(RTRIM(DC.SourceSystem),':',LTRIM(DC.SSID))) AS PersonID,	--	updated 11/11/16 ameitin
		DC.Firstname AS FirstName,
		DC.LastName AS LastName,
		COALESCE(DC.EmailOne, DC.EmailTwo) AS WorkEmailAddress,
		COALESCE(FullName,DC.FirstName + ' ' + DC.Lastname) Business_Name,
		DC.[AddressPrimaryStreet] AS BusinessAddress1,
		DC.[AddressPrimaryCity] AS BusinessCity,
		DC.[AddressPrimaryState] AS BusinessState,
		DC.[AddressPrimaryZip] AS BusinessPostalCode,
		DC.[AddressPrimaryCountry] AS BusinessCountry,
		DC.[PhoneBusiness] AS Phone
FROM [dbo].[vwDimCustomer_ModAcctId] DC
	JOIN dbo.TurnkeyQualifiedSubmissions ts ON dc.[AccountID] = ts.TicketingSystemAccountID 
											   AND ts.SourceSystem = dc.sourcesystem
WHERE dc.isbusiness = 0
	  --AND ts.SubmitDate > DATEADD(DAY,-2,GETDATE())			--	un-comment after first run DCH 2017-04-14
	  AND [DC].[CustomerType] = 'Primary'
	  AND ts.SourceSystem = 'CRM_Contacts'


GO
