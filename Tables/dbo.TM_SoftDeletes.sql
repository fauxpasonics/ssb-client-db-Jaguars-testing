CREATE TABLE [dbo].[TM_SoftDeletes]
(
[accountid] [int] NOT NULL,
[InsertDate] [datetime] NULL CONSTRAINT [DF_TM_SoftDeletes_InsertDate] DEFAULT (getdate()),
[InsertedBy] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_TM_SoftDeletes_InsertedBy] DEFAULT (user_name())
)
GO
