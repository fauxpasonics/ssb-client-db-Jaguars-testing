SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [etl].[vw_EloquaOutbound_Ticketing_bkp]

AS

SELECT ROW_NUMBER() OVER(ORDER BY fts.factticketsalesid)											AS RowNumber
	  ,Contact.[Name]																				AS [Email Address]  
	  ,( CAST(dimdate.CalDate AS DATETIME) + CAST(dimTime.Time24 AS DATETIME) )				 		AS [Sale Date]  
	  ,dimEvent.EventName 																			AS [Event Name]  
	  ,dimEvent.EventDate 																			AS [Event Date]  
	  ,dimEvent.MajorCategoryTM 																	AS [Major Category]  
	  ,dimEvent.MinorCategoryTM 																	AS [Minor Category]  
	  ,DimSeat.SectionName 																			AS [Section]  
	  ,DimSeat.RowName 																				AS [Row]  
	  ,DimSeat.Seat 																				AS [Seat]  
	  ,DimTicketType.TicketTypeName 																AS [Ticket Type]  
	  ,dimPromo.PromoName 																			AS [Promo]  
	  ,fts.IsPremium 																				AS [Is Premium]  
	  ,fts.IsSingleEvent 																			AS [Is Single Event]  
	  ,fts.IsPlan 																					AS [Is Plan]  
	  ,fts.IsPartial 																				AS [Is Partial]  
	  ,fts.IsGroup 																					AS [Is Group]  
	  ,fts.IsRenewal 																				AS [Is Renewal]  
	  ,fi.IsAttended 																				AS [Is Attended]  
	  ,( fts.PaidAmount / CAST(fts.QtySeat AS DECIMAL(18,6)) )										AS [Paid Amount]		
FROM dbo.FactInventory fi (NOLOCK)
	JOIN dbo.FactTicketSales fts (NOLOCK) ON fts.FactTicketSalesId = fi.FactTicketSalesId
	JOIN dbo.DimDate dimdate (NOLOCK) ON dimdate.DimDateId = fi.SoldDimDateId
	JOIN dbo.DimTime dimTime (NOLOCK) ON dimTime.DimTimeId = fi.SoldDimTimeId
	JOIN dbo.DimEvent dimevent (NOLOCK) ON dimevent.DimEventId = fi.DimEventId
	JOIN dbo.DimPromo dimPromo (NOLOCK) ON dimPromo.DimPromoId = fi.SoldDimPromoId
	JOIN dbo.DimSeat dimseat (NOLOCK) ON dimseat.DimSeatId = fi.DimSeatId
	JOIN dbo.DimTicketType dimTicketType (NOLOCK) ON dimTicketType.DimTicketTypeId = fts.DimTicketTypeId
	JOIN dbo.dimcustomerssbid tm (NOLOCK) ON tm.DimCustomerId = fi.SoldDimCustomerId
	JOIN dimcustomerssbid eloqua (NOLOCK) ON eloqua.SSB_CRMSYSTEM_CONTACT_ID = tm.SSB_CRMSYSTEM_CONTACT_ID
	JOIN ods.Eloqua_Contact contact (NOLOCK) ON contact.ContactIDExt = eloqua.SSID
WHERE IsSold = 1
	  AND tm.SourceSystem = 'tm'
	  AND eloqua.SourceSystem = 'eloqua'
	  AND fts.updatedDate > DATEADD(DAY,-3,GETDATE())


  
  
              

















GO
