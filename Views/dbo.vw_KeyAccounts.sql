SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[vw_KeyAccounts]
AS 

SELECT DISTINCT
        ssbid.DimCustomerId ,
        ssbid.SSB_CRMSYSTEM_CONTACT_ID SSBID,
        ssbid.SSID
FROM    dimcustomer dc WITH (NOLOCK)
        JOIN dbo.dimcustomerssbid ssbid WITH (NOLOCK) ON ssbid.DimCustomerid = dc.DimCustomerId
		WHERE dc.AccountRep IN ('Sponsorship', 'Jag Player', 'Broker', 'Tim Bishko', 'Jim Scott')

UNION

SELECT DISTINCT
        ssbid.DimCustomerId ,
        ssbid.SSB_CRMSYSTEM_CONTACT_ID SSBID,
        ssbid.SSID
FROM    dimcustomer dc
        JOIN dbo.dimcustomerssbid ssbid (NOLOCK) ON ssbid.DimCustomerid = dc.DimCustomerId
		WHERE dc.AddressPrimaryStreet LIKE  '%everbank field%'



GO
