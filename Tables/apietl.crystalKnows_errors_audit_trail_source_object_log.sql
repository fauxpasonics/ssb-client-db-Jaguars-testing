CREATE TABLE [apietl].[crystalKnows_errors_audit_trail_source_object_log]
(
[ETL__audit_id] [uniqueidentifier] NOT NULL,
[ETL__crystalKnows_errors_id] [uniqueidentifier] NULL,
[ETL__session_id] [uniqueidentifier] NOT NULL,
[ETL__insert_datetime] [datetime] NOT NULL CONSTRAINT [DF__crystalKn__inser__3243D4E6] DEFAULT (getutcdate()),
[json_payload] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[raw_response] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[crystalKnows_errors_audit_trail_source_object_log] ADD CONSTRAINT [PK__crystalK__5AF33E3326EDDDDC] PRIMARY KEY CLUSTERED  ([ETL__audit_id])
GO
