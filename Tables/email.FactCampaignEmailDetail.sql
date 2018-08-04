CREATE TABLE [email].[FactCampaignEmailDetail]
(
[FactCampaignEmailDetailId] [int] NOT NULL IDENTITY(-2, 1),
[DimCampaignId] [int] NULL,
[DimCampaignActivityTypeId] [int] NULL,
[DimEmailId] [int] NULL,
[DimBrowserId] [int] NULL,
[DimOperationSystemId] [int] NULL,
[DimEmailClientId] [int] NULL,
[DimDeviceId] [int] NULL,
[DimCampaignTypeId] [int] NULL,
[DimChannelId] [int] NULL,
[ActivityReason] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IPAddress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ActivityDateTime] [datetime] NULL,
[URL] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[URLAlias] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Src_SendId] [int] NULL,
[Src_ActivityId] [int] NULL,
[CreatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__FactCampa__Creat__492CC99F] DEFAULT (user_name()),
[CreatedDate] [datetime] NULL CONSTRAINT [DF__FactCampa__Creat__4A20EDD8] DEFAULT (getdate()),
[UpdatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__FactCampa__Updat__4B151211] DEFAULT (user_name()),
[UpdatedDate] [datetime] NULL CONSTRAINT [DF__FactCampa__Updat__4C09364A] DEFAULT (getdate())
)
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [PK__FactCamp__58B50311EEA6B197] PRIMARY KEY CLUSTERED  ([FactCampaignEmailDetailId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimBrowserId] ON [email].[FactCampaignEmailDetail] ([DimBrowserId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimCampaignActivityTypeId] ON [email].[FactCampaignEmailDetail] ([DimCampaignActivityTypeId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimCampaignId] ON [email].[FactCampaignEmailDetail] ([DimCampaignId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimCampaignTypeId] ON [email].[FactCampaignEmailDetail] ([DimCampaignTypeId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimChannelId] ON [email].[FactCampaignEmailDetail] ([DimChannelId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimDeviceId] ON [email].[FactCampaignEmailDetail] ([DimDeviceId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimEmailClientId] ON [email].[FactCampaignEmailDetail] ([DimEmailClientId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimEmailId] ON [email].[FactCampaignEmailDetail] ([DimEmailId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailDetail_DimOperationSystemId] ON [email].[FactCampaignEmailDetail] ([DimOperationSystemId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimBr__50CDEB67] FOREIGN KEY ([DimBrowserId]) REFERENCES [email].[DimBrowser] ([DimBrowserId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimCa__4DF17EBC] FOREIGN KEY ([DimCampaignId]) REFERENCES [email].[DimCampaign] ([DimCampaignId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimCa__4EE5A2F5] FOREIGN KEY ([DimCampaignActivityTypeId]) REFERENCES [email].[DimCampaignActivityType] ([DimCampaignActivityTypeId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimCa__549E7C4B] FOREIGN KEY ([DimCampaignTypeId]) REFERENCES [email].[DimCampaignType] ([DimCampaignTypeId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimCh__5592A084] FOREIGN KEY ([DimChannelId]) REFERENCES [email].[DimChannel] ([DimChannelId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimDe__53AA5812] FOREIGN KEY ([DimDeviceId]) REFERENCES [email].[DimDevice] ([DimDeviceId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimEm__4FD9C72E] FOREIGN KEY ([DimEmailId]) REFERENCES [email].[DimEmail] ([DimEmailID])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimEm__52B633D9] FOREIGN KEY ([DimEmailClientId]) REFERENCES [email].[DimEmailClient] ([DimEmailClientId])
GO
ALTER TABLE [email].[FactCampaignEmailDetail] ADD CONSTRAINT [FK__FactCampa__DimOp__51C20FA0] FOREIGN KEY ([DimOperationSystemId]) REFERENCES [email].[DimOperatingSystem] ([DimOperatingSystemId])
GO
