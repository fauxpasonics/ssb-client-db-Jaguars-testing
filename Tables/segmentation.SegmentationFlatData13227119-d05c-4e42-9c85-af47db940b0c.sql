CREATE TABLE [segmentation].[SegmentationFlatData13227119-d05c-4e42-9c85-af47db940b0c]
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
ALTER TABLE [segmentation].[SegmentationFlatData13227119-d05c-4e42-9c85-af47db940b0c] ADD CONSTRAINT [pk_SegmentationFlatData13227119-d05c-4e42-9c85-af47db940b0c] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData13227119-d05c-4e42-9c85-af47db940b0c] ON [segmentation].[SegmentationFlatData13227119-d05c-4e42-9c85-af47db940b0c] ([_rn])
GO
