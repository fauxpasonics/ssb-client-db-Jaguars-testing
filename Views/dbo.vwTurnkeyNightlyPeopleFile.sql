SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [dbo].[vwTurnkeyNightlyPeopleFile] 

AS

--TM
SELECT  ts.TicketingSystemAccountID AS TicketingAccountID
	   ,CONVERT(VARCHAR(50), CONCAT(RTRIM(DC.SourceSystem),':',LTRIM(DC.SSID))) AS PersonID	--	updated 11/11/16 ameitin
	   ,DC.Firstname AS FirstName
	   ,DC.LastName AS LastName
	   ,DC.[AddressPrimaryStreet] AS Address1
	   ,NULL AS Address2
	   ,DC.[AddressPrimaryCity] AS City
	   ,DC.[AddressPrimaryState] AS [STATE]
	   ,DC.[AddressPrimaryZip] AS PostalCode
	   ,DC.[AddressPrimaryCountry] AS Country
	   ,COALESCE(DC.EmailOne,DC.EmailTwo) AS Email
	   ,DC.[PhoneHome] AS HomePhone
	   ,DC.[PhoneCell] AS MobilePhone
	   ,ts.SubmitDate
FROM [dbo].[vwDimCustomer_ModAcctId] DC
	JOIN dbo.TurnkeyQualifiedSubmissions ts ON dc.[AccountID] = ts.TicketingSystemAccountID 
											   AND ts.SourceSystem = dc.sourcesystem
WHERE dc.isbusiness = 0
	  AND ts.SubmitDate > DATEADD(DAY,-2,GETDATE())			--	un-comment after first run DCH 2017-04-14
	  AND ReceiveDate IS NULL
	  AND [DC].[CustomerType] = 'Primary'
	  AND ts.SourceSystem = 'tm'

UNION ALL

--CRM
SELECT  ts.TicketingSystemAccountID AS TicketingAccountID
	   ,CONVERT(VARCHAR(50), CONCAT(RTRIM(DC.SourceSystem),':',LTRIM(DC.SSID))) AS PersonID	--	updated 11/11/16 ameitin
	   ,DC.Firstname AS FirstName
	   ,DC.LastName AS LastName
	   ,DC.[AddressPrimaryStreet] AS Address1
	   ,NULL AS Address2
	   ,DC.[AddressPrimaryCity] AS City
	   ,DC.[AddressPrimaryState] AS [STATE]
	   ,DC.[AddressPrimaryZip] AS PostalCode
	   ,DC.[AddressPrimaryCountry] AS Country
	   ,COALESCE(DC.EmailOne,DC.EmailTwo) AS Email
	   ,DC.[PhoneHome] AS HomePhone
	   ,DC.[PhoneCell] AS MobilePhone
	   ,ts.SubmitDate
FROM [dbo].[vwDimCustomer_ModAcctId] DC
	JOIN dbo.TurnkeyQualifiedSubmissions ts ON dc.SSID = ts.ssid
											   AND ts.SourceSystem = dc.sourcesystem
WHERE dc.isbusiness = 0
	  AND ts.SubmitDate > DATEADD(DAY,-2,GETDATE())			--	un-comment after first run DCH 2017-04-14
	  AND ReceiveDate IS NULL
	  AND ts.SourceSystem = 'CRM_Contacts'


GO
