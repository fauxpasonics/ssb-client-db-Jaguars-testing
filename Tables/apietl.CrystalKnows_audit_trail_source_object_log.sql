CREATE TABLE [apietl].[CrystalKnows_audit_trail_source_object_log]
(
[ETL__audit_id] [uniqueidentifier] NOT NULL,
[ETL__CrystalKnows_id] [uniqueidentifier] NULL,
[ETL__session_id] [uniqueidentifier] NOT NULL,
[ETL__insert_datetime] [datetime] NOT NULL CONSTRAINT [DF__CrystalKn__inser__5F808FB1] DEFAULT (getutcdate()),
[json_payload] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[raw_response] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[CrystalKnows_audit_trail_source_object_log] ADD CONSTRAINT [PK__CrystalK__5AF33E336B517287] PRIMARY KEY CLUSTERED  ([ETL__audit_id])
GO
