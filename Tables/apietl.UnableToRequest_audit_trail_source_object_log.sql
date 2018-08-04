CREATE TABLE [apietl].[UnableToRequest_audit_trail_source_object_log]
(
[audit_id] [uniqueidentifier] NOT NULL,
[UnableToRequest_id] [uniqueidentifier] NULL,
[session_id] [uniqueidentifier] NOT NULL,
[insert_datetime] [datetime] NOT NULL CONSTRAINT [DF__UnableToR__inser__0448000C] DEFAULT (getutcdate()),
[json_payload] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[raw_response] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[UnableToRequest_audit_trail_source_object_log] ADD CONSTRAINT [PK__UnableTo__5AF33E3324AAD5A5] PRIMARY KEY CLUSTERED  ([audit_id])
GO
