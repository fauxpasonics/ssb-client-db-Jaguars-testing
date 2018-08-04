CREATE TABLE [etl].[EloquaOutbound_Ticketing_Materialized]
(
[RowNumber] [bigint] NULL,
[id] [int] NOT NULL,
[email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[salesDate] [datetime] NULL,
[eventName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[eventDate] [date] NULL,
[majorCategory] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[minorCategory] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seat] [int] NULL,
[ticketType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promo] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[isPremium] [bit] NOT NULL,
[isSingleEvent] [bit] NOT NULL,
[isPlan] [bit] NOT NULL,
[isPartial] [bit] NOT NULL,
[isGroup] [bit] NOT NULL,
[isRenewal] [bit] NOT NULL,
[isAttended] [bit] NOT NULL,
[paidAmmount] [decimal] (38, 20) NULL
)
GO
