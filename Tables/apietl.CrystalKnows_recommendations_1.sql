CREATE TABLE [apietl].[CrystalKnows_recommendations_1]
(
[ETL__CrystalKnows_recommendations_id] [uniqueidentifier] NOT NULL,
[ETL__CrystalKnows_id] [uniqueidentifier] NULL,
[overview] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[CrystalKnows_recommendations_1] ADD CONSTRAINT [PK__CrystalK__E17F622178659031] PRIMARY KEY CLUSTERED  ([ETL__CrystalKnows_recommendations_id])
GO
