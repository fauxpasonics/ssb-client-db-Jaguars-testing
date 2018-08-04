CREATE TABLE [segmentation].[SegmentationFlatData8b1eb0f5-d140-48af-8466-f3c54fea6980]
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
ALTER TABLE [segmentation].[SegmentationFlatData8b1eb0f5-d140-48af-8466-f3c54fea6980] ADD CONSTRAINT [pk_SegmentationFlatData8b1eb0f5-d140-48af-8466-f3c54fea6980] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData8b1eb0f5-d140-48af-8466-f3c54fea6980] ON [segmentation].[SegmentationFlatData8b1eb0f5-d140-48af-8466-f3c54fea6980] ([_rn])
GO
