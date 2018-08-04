SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [mdm].[vw_CompanyLastNames]

AS

SELECT dc.DimCustomerId, cust.name_first, cust.name_last
FROM ods.TM_Cust cust
	JOIN dbo.DimCustomer dc (NOLOCK) ON CONCAT(acct_id,':',cust_name_id) = dc.SSID
WHERE NULLIF(cust.name_first,'') IS NULL
	  AND cust.name_last LIKE '% %'
	  AND ISNULL(name_last,'') <> 'NO LAST NAME'


GO
