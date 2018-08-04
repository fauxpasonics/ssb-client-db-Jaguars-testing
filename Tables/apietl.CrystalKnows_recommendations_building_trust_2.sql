CREATE TABLE [apietl].[CrystalKnows_recommendations_building_trust_2]
(
[ETL__CrystalKnows_recommendations_building_trust_id] [uniqueidentifier] NOT NULL,
[ETL__CrystalKnows_recommendations_id] [uniqueidentifier] NULL,
[overview] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[phrases] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[CrystalKnows_recommendations_building_trust_2] ADD CONSTRAINT [PK__CrystalK__FFC9C575717747D7] PRIMARY KEY CLUSTERED  ([ETL__CrystalKnows_recommendations_building_trust_id])
GO
