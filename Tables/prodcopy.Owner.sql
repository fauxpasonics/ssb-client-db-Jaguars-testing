CREATE TABLE [prodcopy].[Owner]
(
[name] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ownerid] [uniqueidentifier] NOT NULL,
[owneridtype] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[versionnumber] [bigint] NULL,
[yominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CopyLoadDate] [datetime] NOT NULL CONSTRAINT [DF__Owner__CopyLoadD__13DDB2A9] DEFAULT (getdate())
)
GO
ALTER TABLE [prodcopy].[Owner] ADD CONSTRAINT [PK__Owner__7E4A4D64951BCEFE] PRIMARY KEY CLUSTERED  ([ownerid])
GO
