CREATE TABLE [prodcopystg].[Owner]
(
[name] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ownerid] [uniqueidentifier] NOT NULL,
[owneridtype] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[versionnumber] [bigint] NULL,
[yominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CopyLoadDate] [datetime] NOT NULL CONSTRAINT [DF_ProdCopy_Owner] DEFAULT (getdate())
)
GO
