CREATE TABLE [apietl].[CrystalKnows_recommendations_behavior_2]
(
[ETL__CrystalKnows_recommendations_behavior_id] [uniqueidentifier] NOT NULL,
[ETL__CrystalKnows_recommendations_id] [uniqueidentifier] NULL,
[overview] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[phrases] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[CrystalKnows_recommendations_behavior_2] ADD CONSTRAINT [PK__CrystalK__29C5A9B28470DB15] PRIMARY KEY CLUSTERED  ([ETL__CrystalKnows_recommendations_behavior_id])
GO
