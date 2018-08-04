CREATE TABLE [apietl].[CrystalKnows_recommendations_emailing_2]
(
[ETL__CrystalKnows_recommendations_emailing_id] [uniqueidentifier] NOT NULL,
[ETL__CrystalKnows_recommendations_id] [uniqueidentifier] NULL,
[overview] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[CrystalKnows_recommendations_emailing_2] ADD CONSTRAINT [PK__CrystalK__432D52B296ECF4BC] PRIMARY KEY CLUSTERED  ([ETL__CrystalKnows_recommendations_emailing_id])
GO
