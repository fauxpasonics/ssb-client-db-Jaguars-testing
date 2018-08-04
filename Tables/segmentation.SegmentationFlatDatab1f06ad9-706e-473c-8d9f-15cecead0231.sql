CREATE TABLE [segmentation].[SegmentationFlatDatab1f06ad9-706e-473c-8d9f-15cecead0231]
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
ALTER TABLE [segmentation].[SegmentationFlatDatab1f06ad9-706e-473c-8d9f-15cecead0231] ADD CONSTRAINT [pk_SegmentationFlatDatab1f06ad9-706e-473c-8d9f-15cecead0231] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatDatab1f06ad9-706e-473c-8d9f-15cecead0231] ON [segmentation].[SegmentationFlatDatab1f06ad9-706e-473c-8d9f-15cecead0231] ([_rn])
GO
