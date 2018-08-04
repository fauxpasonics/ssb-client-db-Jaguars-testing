CREATE TABLE [apietl].[CrystalKnows_recommendations_selling_2]
(
[ETL__CrystalKnows_recommendations_selling_id] [uniqueidentifier] NOT NULL,
[ETL__CrystalKnows_recommendations_id] [uniqueidentifier] NULL,
[overview] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[phrases] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[CrystalKnows_recommendations_selling_2] ADD CONSTRAINT [PK__CrystalK__AD3C069CE2BDC2AA] PRIMARY KEY CLUSTERED  ([ETL__CrystalKnows_recommendations_selling_id])
GO
