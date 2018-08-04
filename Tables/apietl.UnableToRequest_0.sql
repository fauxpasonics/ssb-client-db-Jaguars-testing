CREATE TABLE [apietl].[UnableToRequest_0]
(
[UnableToRequest_id] [uniqueidentifier] NOT NULL,
[session_id] [uniqueidentifier] NOT NULL,
[insert_datetime] [datetime] NOT NULL CONSTRAINT [DF__UnableToR__inser__07246CB7] DEFAULT (getutcdate()),
[multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[text_type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[text_sample] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[first_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[company_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[location] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[UnableToRequest_0] ADD CONSTRAINT [PK__UnableTo__EBA47771462A2144] PRIMARY KEY CLUSTERED  ([UnableToRequest_id])
GO
