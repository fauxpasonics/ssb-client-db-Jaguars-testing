CREATE TABLE [mdm].[tmp_flag_data]
(
[dimcustomerid] [int] NOT NULL,
[sourcesystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ssid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ssb_crmsystem_acct_id] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_HOUSEHOLD_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_PRIMARY_FLAG] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_ACCT_PRIMARY_FLAG] [int] NULL,
[SSB_CRMSYSTEM_HOUSEHOLD_PRIMARY_FLAG] [int] NULL,
[Last_Suite_Purchase] [datetime] NULL,
[Last_Premium_Purchase] [datetime] NULL,
[Last_Club_Purchase] [datetime] NULL,
[Last_GA_Purchase] [datetime] NULL,
[Last_Partial_Purchase] [datetime] NULL,
[Last_Group_Purchase] [datetime] NULL,
[Last_Single_Purchase] [datetime] NULL,
[Last_Email_Activity] [datetime] NULL,
[Most Recently Updated] [datetime] NULL,
[Source System Priority] [int] NOT NULL
)
GO
