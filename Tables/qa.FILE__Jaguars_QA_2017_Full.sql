CREATE TABLE [qa].[FILE__Jaguars_QA_2017_Full]
(
[ETL__ID] [bigint] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL,
[ETL__Source] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[owner_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[acct_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[add_date] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[plan_event_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seat_num] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[num_seats] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[block_purchase_price] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_code] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comp_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paid] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[payment_status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [qa].[FILE__Jaguars_QA_2017_Full] ADD CONSTRAINT [PK__FILE__Ja__C4EA244563C1139E] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
