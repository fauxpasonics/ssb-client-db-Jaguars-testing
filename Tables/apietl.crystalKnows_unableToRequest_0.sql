CREATE TABLE [apietl].[crystalKnows_unableToRequest_0]
(
[ETL__crystalKnows_unableToRequest_id] [uniqueidentifier] NOT NULL,
[ETL__session_id] [uniqueidentifier] NOT NULL,
[ETL__insert_datetime] [datetime] NOT NULL CONSTRAINT [DF__crystalKn__inser__0CA83BE3] DEFAULT (getutcdate()),
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[text_type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[text_sample] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[first_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[company_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[location] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[crystalKnows_unableToRequest_0] ADD CONSTRAINT [PK__crystalK__01D66F506B3BAD6D] PRIMARY KEY CLUSTERED  ([ETL__crystalKnows_unableToRequest_id])
GO
