SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [etl].[vw_FactTicketSeat_History] AS (

SELECT 
    
	dd.CalDate SaleDate, dt.Time24 SaleTime, ( CAST(dd.CalDate AS DATETIME) + CAST(dt.Time24 AS DATETIME) ) SaleDateTime
    , dc.AccountId
	
	, da.ArenaCode, da.ArenaName
	, dsh.SeasonCode SeasonHeaderCode, dsh.SeasonName SeasonHeaderName, dsh.SeasonDesc SeasonHeaderDesc, dsh.SeasonClass SeasonHeaderClass, dsh.SeasonYear SeasonHeaderYear, dsh.Active SeasonHeaderIsActive
	, ds.SeasonName, ds.SeasonYear, ds.SeasonClass, ds.Active SeasonIsActive
	, deh.EventName EventHeaderName, deh.EventDesc EventHeaderDesc, deh.EventDate EventHeaderDate, deh.EventTime EventHeaderTime, deh.EventDateTime EventHeaderDateTime, deh.EventOpenTime EventHeaderOpenTime, deh.EventFinishTime EventHeaderFinishTime, deh.EventSeasonNumber EventSeasonNumber, deh.HomeGameNumber EventHeaderHomeNumber, deh.GameNumber EventHeaderGameNumber, deh.EventHierarchyL1, deh.EventHierarchyL2, deh.EventHierarchyL3, deh.EventHierarchyL4, deh.EventHierarchyL5
    , de.EventCode, de.EventName, de.EventDate, de.EventTime, de.EventDateTime, de.EventClass, de.MajorCategoryTM, de.MinorCategoryTM
	, di.ItemCode, di.ItemName, di.ItemClass ItemPlanOrEvent
	, dpl.PlanCode, dpl.PlanName, dpl.PlanDesc, dpl.PlanClass, dpl.PlanFse, dpl.PlanType, dpl.PlanEventCnt
	, dpc.PriceCode, dpc.PC1, dpc.PC2, dpc.pc3, dpc.PC4, dpc.PriceCodeDesc, dpc.PriceCodeGroup
	, dst.SectionName, dst.RowName, dst.Seat, dst.Config_Location SeatLocationMapping
	, dtc.TicketClassCode, dtc.TicketClassName
	, tt.TicketTypeCode, tt.TicketTypeName
	, pt.PlanTypeCode, pt.PlanTypeName
	, dstp.SeatTypeCode, dstp.SeatTypeName
	, dctm.ClassName, dctm.DistStatus
	, dsc.SalesCode, dsc.SalesCodeName
	, dpm.PromoCode, dpm.PromoName
	
	, dpc_Manifest.PriceCode ManifestedPriceCode
	, dctm_Manifest.ClassName ManifestedClassName
	, fi.ManifestSeatValue ManifestedSeatValue

	, dpc_Posted.PriceCode PostedPriceCode
	, dctm_Posted.ClassName PostedClassName
	, fi.PostedSeatValue

	, dpc_Held.PriceCode HeldPriceCode
	, dctm_Held.ClassName HeldClassName
	, fi.HeldSeatValue

	, fi.IsSaleable
	, fi.IsAvailable
	, fi.IsHeld
	, fi.IsReserved
	
	, fi.IsSold
	, fi.IsHost
	, fi.IsComp

	, fts.CompCode, fts.CompName
	
	, fts.IsPremium
	, fts.IsSingleEvent
	, fts.IsPlan
	, fts.IsPartial
    , fts.IsGroup
	, fts.IsRenewal

	, fi.TotalRevenue, fi.PcTicketValue, fi.Surcharge, fi.PcTicket, fi.PcTax, fi.PcLicenseFee, fi.PcOther1, fi.PcOther2

	, fi.IsAttended
	, fi.ScanDateTime
	, fi.ScanGate

	, ( fts.QtySeatFSE / CAST(fts.QtySeat AS DECIMAL(18,6)) ) QtySeatFSE
	, ( fts.PaidAmount / CAST(fts.QtySeat AS DECIMAL(18,6)) ) PaidAmount
	, ( fts.OwedAmount / CAST(fts.QtySeat AS DECIMAL(18,6)) ) OwedAmount

	, fts.OrderNum OrderNum
	, fts.OrderLineItem OrderLineItem
	, fts.RetailTicketType, fts.RetailQualifiers

	, fi.IsResold
	, ( CAST(dd_resold.CalDate AS DATETIME) + CAST(dt_resold.Time24 AS DATETIME) ) ResoldDateTime
	, fi.ResoldPurchasePrice
	, fi.ResoldFees
	, fi.ResoldTotalAmount

	, ds.Config_SeasonOrg Org

	, fi.FactInventoryId, fi.FactTicketSalesId, fi.DimSeasonId, fi.DimEventId, fi.DimSeatId, fi.SoldDimPriceCodeId, fi.SoldDimItemId, fi.SoldDimPlanId, fi.SoldDimCustomerId
	, fi.SoldDimDateId, fi.SoldDimTimeId, fi.SoldDimClassTMId, fi.SoldDimSalesCodeId, fi.SoldDimPromoId, fts.DimPlanTypeId, fts.DimTicketTypeId, fts.DimSeatTypeId
	, fi.ResoldDimCustomerId
	, dsh.DimSeasonHeaderId, dsh.PrevSeasonHeaderId
	, deh.DimEventHeaderId, ds.PrevSeasonId
	, de.SSID_event_id
	, dst.SSID_section_id
	, dst.SSID_row_id
	, dst.SSID_seat

--18820

--SELECT COUNT(*)



--FROM (SELECT * FROM rpt.vw_FactInventory WHERE DimEventId = 341) fi
FROM dbo.FactInventoryHistory (NOLOCK) fi

INNER JOIN rpt.vw_DimSeason ds ON fi.DimSeasonId = ds.DimSeasonId
INNER JOIN rpt.vw_DimArena da ON ds.DimArenaId = da.DimArenaId
INNER JOIN rpt.vw_DimEvent de ON fi.DimEventId = de.DimEventId
INNER JOIN rpt.vw_DimEventHeader deh ON de.DimEventHeaderId = deh.DimEventHeaderId
INNER JOIN rpt.vw_DimSeasonHeader dsh ON deh.DimSeasonHeaderId = dsh.DimSeasonHeaderId
INNER JOIN rpt.vw_DimSeat dst ON fi.DimSeatId = dst.DimSeatId

INNER JOIN rpt.vw_DimPriceCode dpc_Manifest ON fi.ManifestDimPriceCodeId = dpc_Manifest.DimPriceCodeId
INNER JOIN rpt.vw_DimClassTM dctm_Manifest ON fi.ManifestDimClassTMId = dctm_Manifest.DimClassTMId

LEFT OUTER JOIN rpt.vw_DimPriceCode dpc_Posted ON fi.PostedDimPriceCodeId = dpc_Posted.DimPriceCodeId
LEFT OUTER JOIN rpt.vw_DimClassTM dctm_Posted ON fi.PostedDimClassTMId = dctm_Posted.DimClassTMId

LEFT OUTER JOIN rpt.vw_DimPriceCode dpc_Held ON fi.HeldDimPriceCodeId = dpc_Held.DimPriceCodeId
LEFT OUTER JOIN rpt.vw_DimClassTM dctm_Held ON fi.HeldDimClassTMId = dctm_Held.DimClassTMId



LEFT OUTER JOIN dbo.FactTicketSales (NOLOCK) fts ON fi.FactTicketSalesId = fts.FactTicketSalesId

    LEFT OUTER JOIN rpt.vw_DimPriceCode dpc ON fi.SoldDimPriceCodeId = dpc.DimPriceCodeId
    LEFT OUTER JOIN rpt.vw_DimItem di ON fi.SoldDimItemId = di.DimItemId
    LEFT OUTER JOIN rpt.vw_DimPlan dpl ON fi.SoldDimPlanId = dpl.DimPlanId 
    LEFT OUTER JOIN rpt.vw_DimCustomer dc ON fi.SoldDimCustomerId = dc.DimCustomerId
    
    LEFT OUTER JOIN rpt.vw_DimDate dd ON fi.SoldDimDateId = dd.DimDateId
    LEFT OUTER JOIN rpt.vw_DimTime dt ON fi.SoldDimTimeId = dt.DimTimeId

	LEFT OUTER JOIN rpt.vw_DimDate dd_resold ON fi.ResoldDimDateId = dd_resold.DimDateId
    LEFT OUTER JOIN rpt.vw_DimTime dt_resold ON fi.ResoldDimTimeId = dt_resold.DimTimeId

    LEFT OUTER JOIN rpt.vw_DimClassTM dctm ON fi.SoldDimClassTMId = dctm.DimClassTMId
    LEFT OUTER JOIN rpt.vw_DimSalesCode dsc ON fi.SoldDimSalesCodeId = dsc.DimSalesCodeId
	LEFT OUTER JOIN rpt.vw_DimPromo dpm ON fi.SoldDimPromoId = dpm.DimPromoID
    LEFT OUTER JOIN rpt.vw_DimPlanType pt ON fts.DimPlanTypeId = pt.DimPlanTypeId
    LEFT OUTER JOIN rpt.vw_DimTicketType tt ON fts.DimTicketTypeId = tt.DimTicketTypeId
    LEFT OUTER JOIN rpt.vw_DimSeatType dstp ON fts.DimSeatTypeId = dstp.DimSeatTypeId
	LEFT OUTER JOIN rpt.vw_DimTicketClass dtc ON fts.DimTicketClassId = dtc.DimTicketClassId


)





GO
