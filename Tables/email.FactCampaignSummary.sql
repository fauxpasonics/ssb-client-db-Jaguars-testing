CREATE TABLE [email].[FactCampaignSummary]
(
[FactCampaignSummaryId] [int] NOT NULL IDENTITY(-2, 1),
[DimCampaignId] [int] NULL,
[DimCampaignActivityTypeId] [int] NULL,
[ActivityTypeTotal] [int] NULL,
[ActivityTypeUnique] [int] NULL,
[ActivityTypeMinDate] [datetime] NULL,
[ActivityTypeMaxDate] [datetime] NULL,
[CreatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__FactCampa__Creat__67B150BF] DEFAULT (user_name()),
[CreatedDate] [datetime] NULL CONSTRAINT [DF__FactCampa__Creat__68A574F8] DEFAULT (getdate()),
[UpdatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__FactCampa__Updat__69999931] DEFAULT (user_name()),
[UpdatedDate] [datetime] NULL CONSTRAINT [DF__FactCampa__Updat__6A8DBD6A] DEFAULT (getdate())
)
GO
ALTER TABLE [email].[FactCampaignSummary] ADD CONSTRAINT [PK__FactCamp__7D08EBDF2CC7846F] PRIMARY KEY CLUSTERED  ([FactCampaignSummaryId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignSummary_DimCampaignActivityTypeId] ON [email].[FactCampaignSummary] ([DimCampaignActivityTypeId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignSummary_DimCampaignId] ON [email].[FactCampaignSummary] ([DimCampaignId])
GO
ALTER TABLE [email].[FactCampaignSummary] ADD CONSTRAINT [FK__FactCampa__DimCa__6C7605DC] FOREIGN KEY ([DimCampaignId]) REFERENCES [email].[DimCampaign] ([DimCampaignId])
GO
ALTER TABLE [email].[FactCampaignSummary] ADD CONSTRAINT [FK__FactCampa__DimCa__6D6A2A15] FOREIGN KEY ([DimCampaignActivityTypeId]) REFERENCES [email].[DimCampaignActivityType] ([DimCampaignActivityTypeId])
GO
