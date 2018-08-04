CREATE TABLE [segmentation].[SegmentationFlatDatad2f5d1f3-3eff-410b-b555-abb18c40e571]
(
[id] [uniqueidentifier] NOT NULL,
[DocumentType] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SessionId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Environment] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TenantId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[_rn] [bigint] NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_oppstage] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_nextactivitydate] [datetime] NULL
)
GO
ALTER TABLE [segmentation].[SegmentationFlatDatad2f5d1f3-3eff-410b-b555-abb18c40e571] ADD CONSTRAINT [pk_SegmentationFlatDatad2f5d1f3-3eff-410b-b555-abb18c40e571] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatDatad2f5d1f3-3eff-410b-b555-abb18c40e571] ON [segmentation].[SegmentationFlatDatad2f5d1f3-3eff-410b-b555-abb18c40e571] ([_rn])
GO
