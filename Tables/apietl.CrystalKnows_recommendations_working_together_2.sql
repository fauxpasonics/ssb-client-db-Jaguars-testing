CREATE TABLE [apietl].[CrystalKnows_recommendations_working_together_2]
(
[ETL__CrystalKnows_recommendations_working_together_id] [uniqueidentifier] NOT NULL,
[ETL__CrystalKnows_recommendations_id] [uniqueidentifier] NULL,
[overview] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[CrystalKnows_recommendations_working_together_2] ADD CONSTRAINT [PK__CrystalK__0710634F6F9BCD01] PRIMARY KEY CLUSTERED  ([ETL__CrystalKnows_recommendations_working_together_id])
GO
