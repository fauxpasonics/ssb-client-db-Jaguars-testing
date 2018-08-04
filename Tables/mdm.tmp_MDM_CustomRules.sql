CREATE TABLE [mdm].[tmp_MDM_CustomRules]
(
[DimCustomerId] [int] NOT NULL,
[Last_Suite_Purchase] [datetime] NULL,
[Last_Premium_Purchase] [datetime] NULL,
[Last_Club_Purchase] [datetime] NULL,
[Last_GA_Purchase] [datetime] NULL,
[Last_Partial_Purchase] [datetime] NULL,
[Last_Group_Purchase] [datetime] NULL,
[Last_Single_Purchase] [datetime] NULL,
[Last_Email_Activity] [datetime] NULL
)
GO
CREATE CLUSTERED INDEX [ix_MDM_CustomRules_dimcustomerID] ON [mdm].[tmp_MDM_CustomRules] ([DimCustomerId])
GO
