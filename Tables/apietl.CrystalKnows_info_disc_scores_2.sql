CREATE TABLE [apietl].[CrystalKnows_info_disc_scores_2]
(
[ETL__CrystalKnows_info_disc_scores_id] [uniqueidentifier] NOT NULL,
[ETL__CrystalKnows_info_id] [uniqueidentifier] NULL,
[confidence] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[CrystalKnows_info_disc_scores_2] ADD CONSTRAINT [PK__CrystalK__C8B91DB4EA876151] PRIMARY KEY CLUSTERED  ([ETL__CrystalKnows_info_disc_scores_id])
GO
