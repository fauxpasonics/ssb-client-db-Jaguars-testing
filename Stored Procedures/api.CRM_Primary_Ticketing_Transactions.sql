SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--EXEC [API].[CRM_Primary_Ticketing_Transactions] @SSB_CRMSYSTEM_CONTACT_ID = '0011A751-07BD-40B1-AC25-A499DC58DDD4', @DisplayTable = 1

CREATE PROCEDURE [api].[CRM_Primary_Ticketing_Transactions]
    @SSB_CRMSYSTEM_ACCT_ID VARCHAR(50) = 'Test',
	@SSB_CRMSYSTEM_CONTACT_ID VARCHAR(50) = 'Test',
	@DisplayTable INT = 0,
	@RowsPerPage  INT = 500, @PageNumber   INT = 0
AS
    BEGIN 

-- Init vars needed for API
DECLARE @totalCount         INT,
		@xmlDataNode        XML,
		@recordsInResponse  INT,
		@remainingCount     INT,
		@rootNodeName       NVARCHAR(100),
		@responseInfoNode   NVARCHAR(MAX),
		@finalXml           XML

	/*
DECLARE @SSB_CRMSYSTEM_CONTACT_ID VARCHAR(50) = '8F98286C-7875-42C1-91BD-196B3A64A112'
DECLARE	@RowsPerPage  INT = 500, @PageNumber   INT = 0
DECLARE @DisplayTable INT = 0
*/


PRINT 'Acct-' + @SSB_CRMSYSTEM_ACCT_ID
PRINT 'Contact-' + @SSB_CRMSYSTEM_CONTACT_ID

DECLARE @GUIDTable TABLE (
GUID VARCHAR(50)
)

IF (@SSB_CRMSYSTEM_ACCT_ID NOT IN ('None','Test'))
BEGIN
	INSERT INTO @GUIDTable
	        ( GUID )
	SELECT DISTINCT z.SSB_CRMSYSTEM_CONTACT_ID
		FROM dbo.vwDimCustomer_ModAcctId z 
		WHERE z.SSB_CRMSYSTEM_ACCT_ID = @SSB_CRMSYSTEM_ACCT_ID
END

IF (@SSB_CRMSYSTEM_CONTACT_ID NOT IN ('None','Test'))
BEGIN
	INSERT INTO @GUIDTable
	        ( GUID )
	SELECT @SSB_CRMSYSTEM_CONTACT_ID
END

SELECT   ssbid.SSB_CRMSYSTEM_CONTACT_ID
        ,CAST(DimDate.CalDate AS DATE) AS Order_Date
        ,DimSeason.SeasonYear AS Season_Year
        ,DimEvent.EventCode AS Event_Code
        ,DimEvent.EventName AS Event_Name
        ,DimEvent.EventDate AS Event_Date
        ,DimPriceCode.PriceCode AS Price_Code
        ,DimItem.ItemCode AS Item_Code
        ,DimTicketType.TicketTypeName AS Ticket_Type_Name
        ,DimSeatType.SeatTypeName AS Seat_Type_Name
        ,DimSeat.SectionName AS Section_Name
        ,DimSeat.RowName AS Row_Name
        ,fts.QtySeat AS Qty_Seat
        ,fts.BlockPurchasePrice AS Block_Purchase_Price
        ,fts.PaidAmount AS Paid_Amount
        ,fts.OwedAmount AS Owed_Amount
		,AccountRep.FirstName + ' ' + AccountRep.LastName AS repName
		,fts.DimTicketClassId
INTO #tmpBase
FROM dbo.FactTicketSales fts WITH ( NOLOCK )
    JOIN rpt.vw_DimPriceCode DimPriceCode WITH ( NOLOCK ) ON DimPriceCode.DimPriceCodeId = fts.DimPriceCodeId
    JOIN rpt.vw_DimTicketType DimTicketType WITH ( NOLOCK ) ON DimTicketType.DimTicketTypeId = fts.DimTicketTypeId
    JOIN rpt.vw_DimPlanType DimPlanType WITH ( NOLOCK ) ON DimPlanType.DimPlanTypeId = fts.DimPlanTypeId
    JOIN rpt.vw_DimSeatType DimSeatType WITH ( NOLOCK ) ON DimSeatType.DimSeatTypeId = fts.DimSeatTypeId
    JOIN dbo.DimCustomer DimCustomer WITH ( NOLOCK ) ON DimCustomer.DimCustomerId = fts.DimCustomerId
														AND DimCustomer.CustomerType = 'Primary'
														AND DimCustomer.SourceSystem = 'TM'
    JOIN dbo.DimCustomer AccountRep WITH ( NOLOCK ) ON AccountRep.DimCustomerId = fts.DimCustomerIdSalesRep
    JOIN rpt.vw_DimDate DimDate WITH ( NOLOCK ) ON DimDate.DimDateId = fts.DimDateId
    JOIN rpt.vw_DimSeason DimSeason WITH ( NOLOCK ) ON DimSeason.DimSeasonId = fts.DimSeasonId
    JOIN rpt.vw_DimEvent DimEvent WITH ( NOLOCK ) ON DimEvent.DimEventId = fts.DimEventId
    JOIN dbo.dimcustomerssbid ssbid WITH ( NOLOCK ) ON ssbid.DimCustomerId = fts.DimCustomerId
    JOIN rpt.vw_DimSalesCode DimSaleCode WITH ( NOLOCK ) ON DimSaleCode.DimSalesCodeId = fts.DimSalesCodeId
    JOIN rpt.vw_DimPromo DimPromo WITH ( NOLOCK ) ON DimPromo.DimPromoID = fts.DimPromoId
    JOIN rpt.vw_DimSeat DimSeat WITH ( NOLOCK ) ON DimSeat.DimSeatId = fts.DimSeatIdStart
    JOIN rpt.vw_DimItem DimItem WITH ( NOLOCK ) ON DimItem.DimItemId = fts.DimItemId
    JOIN rpt.vw_DimEventHeader DimEventHeader WITH ( NOLOCK ) ON DimEventHeader.DimEventHeaderId = DimEvent.DimEventHeaderId
    JOIN rpt.vw_DimPlan DimPlan WITH ( NOLOCK ) ON DimPlan.DimPlanId = fts.DimPlanId
WHERE (DimSeason.SeasonYear >= 2015  OR fts.DimSeasonId = 5) --deposits have a seasonyear of 2007
		AND ssbid.SSB_CRMSYSTEM_CONTACT_ID IN (SELECT GUID FROM @GUIDTable)


SELECT  ISNULL(Order_Date		,'')	Order_Date
	   ,ISNULL(Season_Year		,'')	Season_Year
	   ,ISNULL(Event_Code		,'')	Event_Code
	   ,ISNULL(Event_Name		,'')	Event_Name
	   ,ISNULL(Price_Code		,'')	Price_Code
	   ,ISNULL(Item_Code		,'')	Item_Code
	   ,ISNULL(Ticket_Type_Name	,'')	Ticket_Type_Name
	   ,ISNULL(Section_Name		,'')	Section_Name
	   ,ISNULL(Row_Name			,'')	Row_Name
	   ,ISNULL(Qty_Seat		 	,'')	Qty_Seat
	   ,CASE WHEN SIGN(Block_Purchase_Price)<0 THEN '-' ELSE '' END + '$' + ISNULL(CONVERT(VARCHAR(12),CAST(ABS(Block_Purchase_Price) AS DECIMAL(18,2))), '0.00') AS Block_Purchase_Price
	   ,CASE WHEN SIGN(Paid_Amount)<0 THEN '-' ELSE '' END + '$' + ISNULL(CONVERT(VARCHAR(12),CAST(ABS(Paid_Amount) AS DECIMAL(18,2))), '0.00') AS Paid_Amount
	   ,CASE WHEN SIGN(Owed_Amount)<0 THEN '-' ELSE '' END + '$' + ISNULL(CONVERT(VARCHAR(12),CAST(ABS(Owed_Amount) AS DECIMAL(18,2))), '0.00') AS Owed_Amount
	   ,ISNULL(repname,'') Sales_Rep
INTO #tmpOutput
FROM #tmpBase
ORDER BY ORDER_DATE DESC
OFFSET (@PageNumber) * @RowsPerPage ROWS
FETCH NEXT @RowsPerPage ROWS ONLY

SELECT CAST(Season_Year AS VARCHAR(50)) + ' ' + Ticket_Type_Name Ticket_Type
	   ,Season_Year
	   ,Ticket_Type_Name
	   ,CASE WHEN SIGN(SUM(Paid_Amount))<0 THEN '-' ELSE '' END + '$' + ISNULL(CONVERT(VARCHAR(12),ABS( CAST(SUM(Paid_Amount) AS DECIMAL(18,2)))), '0.00') AS Paid_Amount
	   ,CASE WHEN SIGN(SUM(Block_Purchase_Price))<0 THEN '-' ELSE '' END + '$' + ISNULL(CONVERT(VARCHAR(12),ABS( CAST(SUM(Block_Purchase_Price) AS DECIMAL(18,2) ))), '0.00') AS Order_Value
	   ,CAST(ISNULL(SUM(Paid_Amount) / NULLIF(CAST(SUM(Block_Purchase_Price) AS FLOAT),0),0)*100 AS VARCHAR(50)) + '%' AS 'Paid'
INTO #tmpParent
FROM #tmpBase
GROUP BY CAST(Season_Year AS VARCHAR(50)) + ' ' + Ticket_Type_Name, Season_Year, Ticket_Type_Name

-- Pull counts
SELECT @recordsInResponse = COUNT(*) FROM #tmpOutput
SELECT @totalCount = COUNT(*) FROM #tmpBase

SET @xmlDataNode = (
		SELECT Ticket_Type_Name AS Ticket_Type,
			   Paid_Amount ,
			   Order_Value ,
			   Paid ,
			(
            SELECT  a.Order_Date ,
					a.Sales_Rep ,
                    a.Item_Code ,
                    a.Event_Code ,
                    a.Event_Name ,
                    a.Price_Code ,
                    a.Section_Name ,
                    a.Row_Name ,
                    a.Qty_Seat ,
                    a.Block_Purchase_Price ,
                    a.Paid_Amount ,
                    a.Owed_Amount 
            FROM    #tmpOutput a
            WHERE   a.Season_Year = p.Season_Year
                    AND a.Ticket_Type_Name = p.Ticket_Type_Name
            FOR     XML PATH('Child') ,
                        TYPE
			) AS 'Children'                
		FROM #tmpParent p
		ORDER BY p.Season_Year DESC
				, p.Order_Value DESC
		FOR XML PATH ('Parent'), ROOT('Parents'))

SET @rootNodeName = 'Parents'

-- Calculate remaining count
SET @remainingCount = @totalCount - (@RowsPerPage * (@PageNumber + 1))
IF @remainingCount < 0
BEGIN
	SET @remainingCount = 0
END

-- Create response info node
SET @responseInfoNode = ('<ResponseInfo>'
	+ '<TotalCount>' + CAST(@totalCount AS NVARCHAR(20)) + '</TotalCount>'
	+ '<RemainingCount>' + CAST(@remainingCount AS NVARCHAR(20)) + '</RemainingCount>'
	+ '<RecordsInResponse>' + CAST(@recordsInResponse AS NVARCHAR(20)) + '</RecordsInResponse>'
	+ '<PagedResponse>true</PagedResponse>'
	+ '<RowsPerPage>' + CAST(@RowsPerPage AS NVARCHAR(20)) + '</RowsPerPage>'
	+ '<PageNumber>' + CAST(@PageNumber AS NVARCHAR(20)) + '</PageNumber>'
	+ '<RootNodeName>' + @rootNodeName + '</RootNodeName>'
	+ '</ResponseInfo>')

	PRINT @responseInfoNode
	
-- Wrap response info and data, then return	
IF @xmlDataNode IS NULL
BEGIN
	SET @xmlDataNode = '<' + @rootNodeName + ' />' 
END
		
SET @finalXml = '<Root>' + @responseInfoNode + CAST(@xmlDataNode AS NVARCHAR(MAX)) + '</Root>'

IF @DisplayTable = 1
SELECT * FROM #tmpBase

IF @DisplayTable = 0
SELECT CAST(@finalXml AS XML)


DROP TABLE #tmpBase
DROP TABLE #tmpOutput
DROP TABLE #tmpParent



   END










GO
