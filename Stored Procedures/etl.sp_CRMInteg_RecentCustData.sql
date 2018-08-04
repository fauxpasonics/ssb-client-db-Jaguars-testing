SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [etl].[sp_CRMInteg_RecentCustData]
AS

TRUNCATE TABLE etl.CRMProcess_RecentCustData

DECLARE @Client VARCHAR(50)
SET @Client = 'Jaguars'

SELECT x.dimcustomerid, MAX(x.maxtransdate) maxtransdate, x.team
INTO #tmpTicketSales
	FROM (
		SELECT ft.DimCustomerID, MAX(dd.calDate) MaxTransDate , @Client Team
		--Select * 
		FROM dbo.FactTicketSales ft WITH(NOLOCK)
		INNER JOIN dbo.DimDate dd on ft.dimdateID = dd.DimdateID	
		WHERE dd.calDate >= DATEADD(YEAR, -3, GETDATE())
		GROUP BY ft.[DimCustomerId]	

		) x
		GROUP BY x.dimcustomerid, x.team


INSERT INTO etl.CRMProcess_RecentCustData (SSID, MaxTransDate, Team)
SELECT SSID, [MaxTransDate], Team FROM [#tmpTicketSales] a 
INNER JOIN dbo.[vwDimCustomer_ModAcctId] b ON [b].[DimCustomerId] = [a].[DimCustomerId]



GO
