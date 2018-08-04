SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ods].[TM_vw_Ticket_QA] AS (

	SELECT a.*
	FROM ods.TM_vw_TicketActive a
	LEFT OUTER JOIN ods.TM_vw_TicketReturn r 
	ON a.acct_id = r.acct_id 
		AND a.event_id = r.event_id
		AND a.section_id = r.section_id
		AND a.row_id = r.row_id
		AND a.seat_num = r.seat_num
		AND ISNULL(a.order_num,0) <= ISNULL(r.order_num,0)
		AND ISNULL(a.order_line_item,0) <= ISNULL(r.order_line_item,0)
		AND a.add_datetime < COALESCE(r.return_datetime, r.add_datetime, '1900-01-01')
	WHERE r.acct_id IS NULL 


	--select a.*
	--from ods.TM_vw_TicketActive a
	--left outer join ods.TM_vw_TicketReturn r 
	--on a.acct_id = r.acct_id 
	--	and a.event_id = r.event_id
	--	and a.section_id = r.section_id
	--	and a.row_id = r.row_id
	--	and a.seat_num = r.seat_num
	--	and ISNULL(a.order_num,0) <= ISNULL(r.order_num,0)
	--	and ISNULL(a.order_line_item,0) <= ISNULL(r.order_line_item,0)
	--	and a.add_datetime <= isnull(r.add_datetime, '1900-01-01')
	--where r.acct_id is null 

)




GO
