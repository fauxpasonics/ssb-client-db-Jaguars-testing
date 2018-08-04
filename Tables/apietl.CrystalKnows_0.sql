CREATE TABLE [apietl].[CrystalKnows_0]
(
[ETL__CrystalKnows_id] [uniqueidentifier] NOT NULL,
[ETL__session_id] [uniqueidentifier] NOT NULL,
[ETL__insert_datetime] [datetime] NOT NULL CONSTRAINT [DF__CrystalKn__inser__625CFC5C] DEFAULT (getutcdate()),
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[CrystalKnows_0] ADD CONSTRAINT [PK__CrystalK__58841448E8FE5430] PRIMARY KEY CLUSTERED  ([ETL__CrystalKnows_id])
GO
