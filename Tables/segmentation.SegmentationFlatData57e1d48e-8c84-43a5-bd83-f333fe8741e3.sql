CREATE TABLE [segmentation].[SegmentationFlatData57e1d48e-8c84-43a5-bd83-f333fe8741e3]
(
[id] [uniqueidentifier] NOT NULL,
[DocumentType] [varchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SessionId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Environment] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TenantId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[_rn] [bigint] NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Two_Year_Age] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Discretionary_Income_Index] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Children_Present] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Gender] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Priority] [int] NULL
)
GO
ALTER TABLE [segmentation].[SegmentationFlatData57e1d48e-8c84-43a5-bd83-f333fe8741e3] ADD CONSTRAINT [pk_SegmentationFlatData57e1d48e-8c84-43a5-bd83-f333fe8741e3] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData57e1d48e-8c84-43a5-bd83-f333fe8741e3] ON [segmentation].[SegmentationFlatData57e1d48e-8c84-43a5-bd83-f333fe8741e3] ([_rn])
GO
