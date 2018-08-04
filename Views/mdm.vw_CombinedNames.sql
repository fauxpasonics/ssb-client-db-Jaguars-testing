SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [mdm].[vw_CombinedNames]

AS

SELECT dc.DimCustomerId
FROM ods.TM_Cust cust
	JOIN dbo.DimCustomer dc (NOLOCK) ON CONCAT(acct_id,':',cust_name_id) = dc.SSID
WHERE (name_first LIKE '%&%' OR name_first LIKE '% AND %')
	  AND dc.SourceSystem = 'TM'
GO
