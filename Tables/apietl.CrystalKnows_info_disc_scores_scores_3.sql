CREATE TABLE [apietl].[CrystalKnows_info_disc_scores_scores_3]
(
[ETL__CrystalKnows_info_disc_scores_scores_id] [uniqueidentifier] NOT NULL,
[ETL__CrystalKnows_info_disc_scores_id] [uniqueidentifier] NULL,
[d] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[i] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[s] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[c] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[CrystalKnows_info_disc_scores_scores_3] ADD CONSTRAINT [PK__CrystalK__5E43325D39776379] PRIMARY KEY CLUSTERED  ([ETL__CrystalKnows_info_disc_scores_scores_id])
GO
