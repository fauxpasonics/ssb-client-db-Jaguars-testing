CREATE TABLE [segmentation].[SegmentationFlatDatac7edc6d5-0ec4-4f30-9218-b7cad3a22de5]
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
ALTER TABLE [segmentation].[SegmentationFlatDatac7edc6d5-0ec4-4f30-9218-b7cad3a22de5] ADD CONSTRAINT [pk_SegmentationFlatDatac7edc6d5-0ec4-4f30-9218-b7cad3a22de5] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatDatac7edc6d5-0ec4-4f30-9218-b7cad3a22de5] ON [segmentation].[SegmentationFlatDatac7edc6d5-0ec4-4f30-9218-b7cad3a22de5] ([_rn])
GO
