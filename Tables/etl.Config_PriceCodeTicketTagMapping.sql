CREATE TABLE [etl].[Config_PriceCodeTicketTagMapping]
(
[ETL__ID] [int] NOT NULL,
[ETL__UpdatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL__UpdatedDate] [datetime] NULL,
[DimSeasonID] [int] NOT NULL,
[PriceCode] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DimTicketTypeId] [int] NULL,
[DimplanTypeId] [int] NULL,
[DimseatTypeId] [int] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [etl].[Config_PriceCodeTicketTagMapping] ADD CONSTRAINT [PK__Config_P__C4EA244544B21051] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
