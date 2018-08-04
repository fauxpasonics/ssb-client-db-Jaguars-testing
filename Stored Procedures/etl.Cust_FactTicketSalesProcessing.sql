SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








	





CREATE PROCEDURE [etl].[Cust_FactTicketSalesProcessing]
(
	@BatchId INT = 0,
	@LoadDate DATETIME = NULL,
	@Options NVARCHAR(MAX) = NULL
)
AS


BEGIN



/*****************************************************************************************************************
													SEASONS
******************************************************************************************************************/

SELECT seasonyear,dimseasonid
INTO #seasons
FROM dbo.DimSeason 
WHERE seasonname IN (CONCAT(SeasonYear,' Jaguars Manifest'),CONCAT(SeasonYear,' Jaguars Season Tickets'))

/*****************************************************************************************************************
													PLAN TYPE
******************************************************************************************************************/

----NEW----

UPDATE fts
SET fts.DimPlanTypeId = 1
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE   PC2 = 'N'
		AND seasonyear > 2013

----MULTI YEAR----

UPDATE fts
SET fts.DimPlanTypeId = 2
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE   seasonyear > 2013
		AND (
			 (PC2 = 'R' AND PC3 IN ('O','C') AND PC4 IN ('5','6','7'))
			 OR PriceCode IN( 'SRU7','TRU6','TRU7')
			 )

----ONE YEAR----

UPDATE fts
SET fts.DimPlanTypeId = 3
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE   seasonyear > 2013
		AND (
			 PriceCode = '9RO5'
			 OR (PC2 = 'R' AND NOT (PC3 IN ('O','C') AND PC4 IN ('5','6','7')))
			)

----INTERNAL----

UPDATE fts
SET fts.DimPlanTypeId = 4
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE   seasonyear > 2013
		AND PC2 IN ('N','R')
		AND PC3 IN ('I','S','T')

----NO PLAN----


UPDATE fts
SET fts.DimPlanTypeId = 5
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE   seasonyear > 2013
		AND DimPlanTypeId = -1


/*****************************************************************************************************************
													TICKET TYPE
******************************************************************************************************************/

----FULL SEASON LOYALTY----

UPDATE fts
SET fts.DimTicketTypeId = 1
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE	seasonyear > 2013
		AND( 
			 (PC3 LIKE '[0-9]' AND PC4 LIKE '[0-9]')
			 OR PriceCode IN('ERS1','SRRQ','HRS1','ORO6', 'ORO7','VRO6'
							,'1NRQ','1RRQ','5RRQ','6NRQ','ANT1','ARU1','BNS1','BRI2','BRS1','BRT1','BRU1'
							,'BRU2','CNU1','CRT1','CRU1','CRU2','DNU1','DRS1','DRS2','DRT2','DRU1','DRU2'
							,'ERI2','ERS2','ERS4','ERT2','ERU1','ERU2','ERU3','FNU1','FNU2','FRS1','FRT1'
							,'FRU1','FRU2','GNS2','GNU2','GRS2','GRU2','HNS1','HNU1','HRI1','HRT1','HRU1'
							,'INU1','IRI1','IRS1','IRT1','IRU1','IRU2','JRS1','JRS2','JRU1','JRU2','JRU3'
							,'KNU3','KRS2','KRS3','KRT2','KRT3','KRU1','KRU2','KRU3','LRU1','SRU7','TRU6'
							,'NNRQ','TRU7','MRO6','MRO7','NRC6','NRRQ','NRSC','ONRQ','ORRQ','PNO6','PNRQ'
							,'NRC7','NRO6','PRRQ','NRO7','PRO6','QRRQ','RNO6','RNO7','RNRQ','PRO7','QRO6'
							,'RRRQ','SNO6','SNRQ','QRO7','RRO6','RRO7','TNO7','TNRQ','TNU7','SRO6','SRO7'
							,'TRRQ','TRO6','TRO7','UNO7','UNRQ','URO6','URO7','URRQ','VNRQ','VRO7','VRRQ'
							,'DRT1'	,'ENS1'	,'ERT1'	,'INS1'	,'MNO6')
			 )


----FULL SEASON NON-LOYALTY----

UPDATE fts
SET fts.DimTicketTypeId = 2
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE seasonyear > 2013
	  AND( 
		  (PC3 NOT IN('D','H','J','Y','R') AND PC4 = 'Q')
		  OR PriceCode IN ('MNRQ' ,'WNRQ','6RRQ' ,'8RRQ','MRRQ','WRRQ','0NO1','0NO2'	
						  ,'0NO4'	,'0RO1'	,'0RO2'	,'0RO3'	,'0RO4'	,'2NO2'	,'2RO1'	
						  ,'2RO2'	,'2RS1'	,'3NO2'	,'3RO1'	,'3RO2'	,'3RS2'	,'3RT1'	
						  ,'9NO1'	,'9NO2'	,'9NO3'	,'9NO4'	,'9RO1'	,'9RO2'	,'9RO3'	
						  ,'9RO4'	,'9RO5'	,'WNRS'	,'WRO6'	,'WRRS','9RS1'	,'DNT1'	
						  ,'GRT2'	,'HNT1'	,'KNT2')
		 )
		  


----FULL SEASON DISCOUNTED----

UPDATE fts
SET fts.DimTicketTypeId = 3
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE	seasonyear > 2013
		AND PC3 IN ('D','H','J','Y')

----PARTIAL PLANS----

UPDATE fts
SET fts.DimTicketTypeId = 4
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE	seasonyear > 2013
		AND (di.ItemCode IN ('16F5', '16F6', '16F7', '16F8')
			 OR PriceCode IN ('KGOH','DGOH'	,'EGOH'	,'FGOH'	,'GGOH'	,'HGOH','IGOH'
							  ,'JGOH','PGOH'	,'RGOH'	,'VGOH','BGOH'	,'BNP7'	
							  ,'CNP7'	,'DNP7'	,'DNP8'	,'DRP7'	,'ENP7'	,'ENP8'	,'FNP7'	
							  ,'FRP7'	,'GNP7'	,'GNP8'	,'GRP7'	,'HNP7'	,'HNUF'	,'HRUF'	
							  ,'INP7'	,'JNP7'	,'JRP7'	,'KNP7'	,'KNP8'	,'OGOH'	,'ONO7'	
							  ,'PNP7'	,'SGOH'	,'TNP7'	,'UGOH'	,'UNP7'	,'VNP7')
			 )

----MINI PACKS----

UPDATE fts
SET fts.DimTicketTypeId = 5
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE	seasonyear > 2013
		AND di.ItemCode = '16FLEX3'


----GROUPS----

UPDATE fts
SET fts.DimTicketTypeId = 6
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE	seasonyear > 2013
		AND (
			 (PC2 = 'G' AND NOT((PC3='O'AND PC4 = 'H')
								OR PriceCode LIKE '%GS%' AND PC1 IN ('4','5')))
			OR (PriceCode IN ('BZNB','DZNB'	,'FZNB'	,'FZSC'	,'GZNB'	,'HZNB'	,'JZMS'	,'JZNB'	,'KZNB','KZCD'
							  ,'AZFR','HZFR','KZFR','BZMS','DZMS','GZMS','KZMS','PZMS','UZMS','AZNB','DZNB'
							  ,'FZNB','GZNB','HZNB','KZNB','DZNV','GZNV','HZNV','JZNV','BZOO','CZOO','FZOO'
							  ,'GZOO','IZOO','JZOO','KZOO','UZOO','HZSD','IZSD','JZSD','KZSD'))
			OR (pc4 IS NOT NULL AND RIGHT(pricecode,3) IN ('D01','GLG','GO2','GOG','GON','GU1','GU2','GU3'
														  ,'GU5','GUG','GUN','U01','U02','U03','U05','U06'
														  ,'U08','ZJC','ZLW','ZNV','ZTC','ZTT','ZYD'))			
			)

----GROUPS (DISCOUNTED)----

UPDATE fts
SET fts.DimTicketTypeId = 7
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE	seasonyear > 2013
		AND (
			(PC2 = 'G' AND PC4 = 'N')
			OR(PriceCode IN ('HZFR'	,'IZNB'	,'JZSD'	,'KZFR'))
			)

----GROUPS (INTERNAL)----

UPDATE fts
SET fts.DimTicketTypeId = 8
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE	seasonyear > 2013
		AND PriceCode LIKE '%GS%' 
		AND PC1 IN ('4','5')

----SINGLES----

UPDATE fts
SET fts.DimTicketTypeId = 9
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE	seasonyear > 2013
		AND (
			 ((PC2 = 'X' OR ISHost = 1) AND PC3 not in ('J','P','V','I','S','T'))
			 OR PriceCode IN ('B','C','D','E','F','G','H','I','J','K','N','P','R'
							  ,'V','1','7','A','L','M','O','Q','S','T','Y','Z')
			 )

----SINGLES (DISCOUNTED)----

UPDATE fts
SET fts.DimTicketTypeId = 10
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE	seasonyear > 2013
		AND PC2 = 'X' 
		AND PC3 = 'O' 
		AND PC4 = 'K'

----SINGLES (INTERNAL)----

UPDATE fts
SET fts.DimTicketTypeId = 11
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE	seasonyear > 2013
		AND (PC2 = 'X' or ISHost = 1) 
		AND PC3 in ('I','S','T')

----VISITING----

UPDATE fts
SET fts.DimTicketTypeId = 12
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE	seasonyear > 2013
		AND PC3 = 'V'

----SINGLE (STAFF/PLAYER)----

UPDATE fts
SET fts.DimTicketTypeId = 13
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId	
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE	seasonyear > 2013
		AND PC2 = 'X' 
		AND PC3 IN ('J','P')


----MISC----

UPDATE fts
SET fts.DimTicketTypeId = 14
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
        JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
WHERE	seasonyear > 2013
		AND DimTicketTypeId = -1


/*****************************************************************************************************************
															SEAT TYPE
******************************************************************************************************************/

----GA----

UPDATE fts
SET fts.DimSeatTypeId = 1
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId
WHERE (seasonyear > 2015 AND pc1 LIKE '[A-L]')
	   OR (SeasonYear = 2015 AND (PC1 LIKE '[G-Q]' OR PC1 = 'U'))

----CLUB----

UPDATE fts
SET fts.DimSeatTypeId = 2
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId
WHERE (seasonyear > 2015 AND pc1 LIKE '[N-V]')
	   OR (SeasonYear = 2015 AND PC1 LIKE '[B-F]')
	   
----PREMIUM----

UPDATE fts
SET fts.DimSeatTypeId = 3
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId
WHERE (seasonyear > 2015 AND (pc1 LIKE '[0-9]' OR PC1 = 'M'))
	   OR (SeasonYear = 2015 AND (PC1 LIKE '[1-8]' OR PC1 = 'A'))
	   
----SUITE----

UPDATE fts
SET fts.DimSeatTypeId = 4
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
		JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
        JOIN dbo.DimDate DimDate ON DimDate.DimDateId = fts.DimDateId
WHERE (seasonyear > 2015 AND pc1='W')
	   OR (SeasonYear = 2015 AND PC1 IN ('R','F'))

/*****************************************************************************************************************
												2017 DESIGNATIONS
******************************************************************************************************************/

--The Jaguars don't really have hard and fast rules as far as what should be classified where. For this reason,
--I've simple created a lookup table to assign the ticket id's based on the mapping that the Jaguars have provided
--this will need updated as new price codes are coming in

UPDATE fts
SET fts.DimTicketTypeId = dsg.DimTicketTypeId
	,fts.DimplanTypeId	= dsg.DimplanTypeId	
	,fts.DimseatTypeId  = dsg.DimseatTypeId
FROM    #stgFactTicketSales fts
        JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN [etl].[Config_PriceCodeTicketTagMapping] dsg on dsg.PriceCode = pricecode.pricecode
															AND fts.dimseasonid = dsg.dimseasonid

/*****************************************************************************************************************
												   TICKET CLASS
******************************************************************************************************************/

UPDATE fts
SET fts.DimTicketClassId = CASE WHEN LEN(priceCode)=1 THEN 3 --single
								WHEN RIGHT(priceCode, 3) IN ( 'GFF', 'PLA') THEN 3 --single 
								WHEN LEFT(RIGHT(priceCode, 3), 2) IN ( 'XV', 'XO' ) THEN 3 --single
								WHEN RIGHT(priceCode, 3) IN ( 'GOH', 'ROH') THEN 2 --Mini Plan 
								WHEN PriceCode.PC2 IN ( 'N', 'R') THEN 1 --Season
								ELSE 4 --Group
						   END
FROM #stgfactticketsales fts
	JOIN #seasons season ON season.DimSeasonId = fts.DimSeasonId
	JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId

/*****************************************************************************************************************
													FACT TAGS
******************************************************************************************************************/


UPDATE f
SET f.IsComp = 1
FROM #stgFactTicketSales f
	JOIN dbo.DimPriceCode dpc
	ON dpc.DimPriceCodeId = f.DimPriceCodeId
WHERE f.compname <> 'Not Comp'
	  OR PriceCodeDesc = 'Comp'
	  OR f.TotalRevenue = 0


UPDATE f
SET f.IsComp = 0
FROM #stgFactTicketSales f
	JOIN dbo.DimPriceCode dpc
	ON dpc.DimPriceCodeId = f.DimPriceCodeId
WHERE NOT (f.compname <> 'Not Comp'
		   OR PriceCodeDesc = 'Comp'
		   OR f.TotalRevenue = 0)

UPDATE f
SET f.IsPlan = 1
, f.IsPartial = 0
, f.IsSingleEvent = 0
, f.IsGroup = 0
FROM #stgFactTicketSales f
WHERE DimTicketTypeId IN (1,2,3) 
/*Full Season Loyalty, Full Season Non-Loyalty, Full Season Discounted */


UPDATE f
SET f.IsPlan = 1
, f.IsPartial = 1
, f.IsSingleEvent = 0
, f.IsGroup = 0
FROM #stgFactTicketSales f
WHERE DimTicketTypeId IN (4,5) 
/*Partial Plans, Mini Packs */

UPDATE f
SET f.IsPlan = 0
, f.IsPartial = 0
, f.IsSingleEvent = 1
, f.IsGroup = 1
FROM #stgFactTicketSales f
WHERE DimTicketTypeId IN (6,7,8) 
/*Groups, Groups Discounted , Internal Group */


UPDATE f
SET f.IsPlan = 0
, f.IsPartial = 0
, f.IsSingleEvent = 1
, f.IsGroup = 0
FROM #stgFactTicketSales f
WHERE DimTicketTypeId IN (9,10,11,12,13) 
/*Singles, Singles Discounted, Internal Singles, Visiting Team, Single Staff/Player*/


UPDATE f
SET f.IsPremium = 1
FROM #stgFactTicketSales f
JOIN dbo.DimSeatType dst ON f.DimSeatTypeId = dst.DimSeatTypeId
WHERE dst.SeatTypeCode <> 'GA'


UPDATE f
SET f.IsPremium = 0
FROM #stgFactTicketSales f
JOIN dbo.DimSeatType dst ON f.DimSeatTypeId = dst.DimSeatTypeId
WHERE dst.SeatTypeCode = 'GA'


UPDATE f
SET f.IsRenewal = 1
FROM #stgFactTicketSales f
JOIN dbo.DimPlanType dpt ON f.DimPlanTypeId = dpt.DimPlanTypeId
WHERE dpt.PlanTypeCode IN ('MULTI','1YEAR','INTERNAL')


UPDATE f
SET f.IsRenewal = 0
FROM #stgFactTicketSales f
JOIN dbo.DimPlanType dpt ON f.DimPlanTypeId = dpt.DimPlanTypeId
WHERE dpt.PlanTypeCode NOT IN ('MULTI','1YEAR','INTERNAL')





END 












GO
