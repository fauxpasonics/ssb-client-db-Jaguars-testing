CREATE TABLE [apietl].[crystalKnows_retriesMaxedOut_audit_trail_source_object_log]
(
[ETL__audit_id] [uniqueidentifier] NOT NULL,
[ETL__crystalKnows_retriesMaxedOut_id] [uniqueidentifier] NULL,
[ETL__session_id] [uniqueidentifier] NOT NULL,
[ETL__insert_datetime] [datetime] NOT NULL CONSTRAINT [DF__crystalKn__ETL____30F08951] DEFAULT (getutcdate()),
[json_payload] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[raw_response] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[crystalKnows_retriesMaxedOut_audit_trail_source_object_log] ADD CONSTRAINT [PK__crystalK__DB9573BC4DE120DF] PRIMARY KEY CLUSTERED  ([ETL__audit_id])
GO
