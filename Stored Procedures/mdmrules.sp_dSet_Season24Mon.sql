SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [mdmrules].[sp_dSet_Season24Mon]
AS

DECLARE @Criteria table (CriteriaID int, Criteria varchar(50))
Insert into @Criteria
Select 1, 'Suite >=24mon'
UNION ALL
Select 2, 'Premium >= 24mon'
UNION ALL
Select 3, 'Club >= 24mon'
UNION ALL
Select 4, 'GA >= 24mon'
UNION ALL
Select 5, 'Partial >= 24mon'
UNION ALL
Select 6, 'Group >= 24mon'
UNION ALL
Select 7, 'Non-STH >= 24mon';



--TM Base
with cteTM as (
SELECT DISTINCT
        fts.SSID_acct_id, 
CASE WHEN dst.DimSeatTypeId=4  THEN 'Suite'
	 WHEN dst.DimSeatTypeId=3 THEN 'Premium'
	 WHEN dst.DimSeatTypeId=2 then 'Club'
	 WHEN dst.DimSeatTypeId=1 then 'GA'
	 WHEN dtt.DimTicketTypeId = 4 then 'Partial'
	 WHEN dtt.DimTicketTypeId IN (6,7,8) then 'Group'
	 WHEN dtt.DimTicketTypeId NOT IN (1,2,3) then 'Non-STH'
	 ELSE 'other'
	 END as Season,
MAX(dd.CalDate) MaxSaleDate
FROM    dbo.FactTicketSales fts
        JOIN dbo.DimSeason ds ON ds.DimSeasonId = fts.DimSeasonId
        JOIN dbo.DimTicketType dtt ON dtt.DimTicketTypeId = fts.DimTicketTypeId
        JOIN dbo.DimPlanType dpt ON dpt.DimPlanTypeId = fts.DimPlanTypeId
        JOIN dbo.DimSeatType dst ON dst.DimSeatTypeId = fts.DimSeatTypeId
        JOIN dbo.DimDate dd ON dd.DimDateId = fts.DimDateId
WHERE   dd.CalDate >= CAST(DATEADD(YEAR, -2, GETDATE()) AS DATE)
Group by fts.SSID_acct_id,
CASE WHEN dst.DimSeatTypeId=4  THEN 'Suite'
	 WHEN dst.DimSeatTypeId=3 THEN 'Premium'
	 WHEN dst.DimSeatTypeId=2 then 'Club'
	 WHEN dst.DimSeatTypeId=1 then 'GA'
	 WHEN dtt.DimTicketTypeId = 4 then 'Partial'
	 WHEN dtt.DimTicketTypeId IN (6,7,8) then 'Group'
	 WHEN dtt.DimTicketTypeId NOT IN (1,2,3) then 'Non-STH'
	 ELSE 'other'
	 END
)


--Final Select
SELECT SSID_acct_id, CriteriaID, CAST(MaxSaleDate AS VARCHAR(50)) CriteriaValue
FROM 
	(
		Select SSID_acct_id,b.CriteriaID, MaxSaleDate 
		from cteTM a
		Join @Criteria b
			ON b.Criteria = 'Suite >=24mon'
		Where a.Season = 'Suite' 
		UNION ALL
		Select SSID_acct_id,b.CriteriaID, MaxSaleDate 
		from cteTM a
		Join @Criteria b
			ON b.Criteria = 'Premium >= 24mon'
		Where a.Season = 'Premium' 
		UNION ALL
		Select SSID_acct_id,b.CriteriaID, MaxSaleDate 
		from cteTM a
		Join @Criteria b
			ON b.Criteria = 'Club >= 24mon'
		Where a.Season = 'Club' 
		UNION ALL
		Select SSID_acct_id,b.CriteriaID, MaxSaleDate 
		from cteTM a
		Join @Criteria b
			ON b.Criteria = 'GA >= 24mon'
		Where a.Season = 'GA' 
		UNION ALL
		Select SSID_acct_id,b.CriteriaID, MaxSaleDate 
		from cteTM a
		Join @Criteria b
			ON b.Criteria = 'Partial >= 24mon'
		Where a.Season = 'Partial' 
		UNION ALL
		Select SSID_acct_id,b.CriteriaID, MaxSaleDate 
		from cteTM a
		Join @Criteria b
			ON b.Criteria = 'Group >= 24mon'
		Where a.Season = 'Group' 
		UNION ALL
		Select SSID_acct_id,b.CriteriaID, MaxSaleDate 
		from cteTM a
		Join @Criteria b
			ON b.Criteria = 'Non-STH >= 24mon'
		Where a.Season = 'Non-STH'
		)x
		

GO
