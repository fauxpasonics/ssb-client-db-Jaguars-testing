CREATE TABLE [mdm].[tmp_MDM_customrules_QA]
(
[DimCustomerId] [int] NOT NULL,
[Last_Suite_Purchase] [date] NULL,
[Last_Premium_Purchase] [date] NULL,
[Last_Club_Purchase] [date] NULL,
[Last_GA_Purchase] [date] NULL,
[Last_Partial_Purchase] [date] NULL,
[Last_Group_Purchase] [date] NULL,
[Last_Single_Purchase] [date] NULL,
[Last_Email_Activity] [datetime] NULL
)
GO
CREATE CLUSTERED INDEX [ix_MDM_customrules_QA_dimcustomerID] ON [mdm].[tmp_MDM_customrules_QA] ([DimCustomerId])
GO
