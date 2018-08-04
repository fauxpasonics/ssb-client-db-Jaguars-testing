SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
















CREATE VIEW [etl].[vw_EloquaOutbound_Ticketing]

AS

SELECT fi.FactInventoryId																			AS [id]
	  ,Contact.EmailAddress																			AS [email]  
	  ,(CAST(dimdate.CalDate AS DATETIME) + CAST(dimTime.Time24 AS DATETIME))				 		AS [salesDate]  
	  ,dimEvent.EventName 																			AS [eventName]  
	  ,dimEvent.EventDate 																			AS [eventDate]  
	  ,dimEvent.MajorCategoryTM 																	AS [majorCategory]  
	  ,dimEvent.MinorCategoryTM 																	AS [minorCategory]  
	  ,DimSeat.SectionName 																			AS [section]  
	  ,DimSeat.RowName 																				AS [row]  
	  ,DimSeat.Seat 																				AS [seat]  
	  ,DimTicketType.TicketTypeName 																AS [ticketType]  
	  ,dimPromo.PromoName 																			AS [promo]  
	  ,fts.IsPremium 																				AS [isPremium]  
	  ,fts.IsSingleEvent 																			AS [isSingleEvent]  
	  ,fts.IsPlan 																					AS [isPlan]  
	  ,fts.IsPartial 																				AS [isPartial]  
	  ,fts.IsGroup 																					AS [isGroup]  
	  ,fts.IsRenewal 																				AS [isRenewal]  
	  ,fi.IsAttended 																				AS [isAttended]  
	  ,( fts.PaidAmount / CAST(fts.QtySeat AS DECIMAL(18,6)) )										AS [paidAmmount]		
FROM dbo.FactInventory fi (NOLOCK)
	JOIN dbo.FactTicketSales fts (NOLOCK) ON fts.FactTicketSalesId = fi.FactTicketSalesId
	JOIN dbo.DimDate dimdate (NOLOCK) ON dimdate.DimDateId = fi.SoldDimDateId
	JOIN dbo.DimTime dimTime (NOLOCK) ON dimTime.DimTimeId = fi.SoldDimTimeId
	JOIN dbo.DimEvent dimevent (NOLOCK) ON dimevent.DimEventId = fi.DimEventId
	JOIN dbo.DimPromo dimPromo (NOLOCK) ON dimPromo.DimPromoId = fi.SoldDimPromoId
	JOIN dbo.DimSeat dimseat (NOLOCK) ON dimseat.DimSeatId = fi.DimSeatId
	JOIN dbo.DimTicketType dimTicketType (NOLOCK) ON dimTicketType.DimTicketTypeId = fts.DimTicketTypeId
	JOIN dbo.DimCustomer dc (NOLOCK) ON dc.DimCustomerId = fts.DimCustomerId
	JOIN ods.Eloqua_Contact contact (NOLOCK) ON contact.EmailAddress = dc.EmailPrimary
WHERE IsSold = 1
	  --AND fts.updatedDate > DATEADD(DAY,-3,GETDATE())
	  AND fts.updatedDate >= '20180221'




















  
  
              

















GO
