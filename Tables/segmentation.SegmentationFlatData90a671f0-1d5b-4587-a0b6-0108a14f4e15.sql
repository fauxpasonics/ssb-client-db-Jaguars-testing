CREATE TABLE [segmentation].[SegmentationFlatData90a671f0-1d5b-4587-a0b6-0108a14f4e15]
(
[id] [uniqueidentifier] NOT NULL,
[DocumentType] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SessionId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Environment] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TenantId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[_rn] [bigint] NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CustomerSourceSystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [segmentation].[SegmentationFlatData90a671f0-1d5b-4587-a0b6-0108a14f4e15] ADD CONSTRAINT [pk_SegmentationFlatData90a671f0-1d5b-4587-a0b6-0108a14f4e15] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData90a671f0-1d5b-4587-a0b6-0108a14f4e15] ON [segmentation].[SegmentationFlatData90a671f0-1d5b-4587-a0b6-0108a14f4e15] ([_rn])
GO
