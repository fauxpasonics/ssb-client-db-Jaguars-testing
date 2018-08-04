CREATE TABLE [apietl].[CrystalKnows_info_1]
(
[ETL__CrystalKnows_info_id] [uniqueidentifier] NOT NULL,
[ETL__CrystalKnows_id] [uniqueidentifier] NULL,
[first_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[disc_image] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[CrystalKnows_info_1] ADD CONSTRAINT [PK__CrystalK__DC1E5E89C4DA4C9A] PRIMARY KEY CLUSTERED  ([ETL__CrystalKnows_info_id])
GO
