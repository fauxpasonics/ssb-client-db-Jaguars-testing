SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [mdm].[vw_CombinedNames_Turnkey]

AS

SELECT dc.DimCustomerId
FROM ods.Turnkey_Acxiom tk
	JOIN dbo.DimCustomer dc (NOLOCK) ON CONCAT(tk.AbilitecID,':',tk.ProspectID) = dc.SSID
WHERE (tk.FirstName LIKE '%&%' OR tk.FirstName LIKE '% AND %')
	  AND dc.SourceSystem = 'turnkey'




GO
