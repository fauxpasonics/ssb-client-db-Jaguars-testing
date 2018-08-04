CREATE TABLE [mdm].[tmpPrimaryFlagRanking]
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
[Suite >=24mon] [date] NULL,
[Premium >= 24mon] [date] NULL,
[Club >= 24mon] [date] NULL,
[GA >= 24mon] [date] NULL,
[Partial >= 24mon] [date] NULL,
[Group >= 24mon] [date] NULL,
[Non-STH >= 24mon] [date] NULL,
[Last Email Activity] [datetime] NULL,
[Source System Priority] [int] NOT NULL,
[Most Recently Updated] [datetime] NULL,
[ranking] [bigint] NULL
)
GO
CREATE CLUSTERED INDEX [ix_tmpRanking] ON [mdm].[tmpPrimaryFlagRanking] ([dimcustomerid])
GO
