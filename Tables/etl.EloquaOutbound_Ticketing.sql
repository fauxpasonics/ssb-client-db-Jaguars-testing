CREATE TABLE [etl].[EloquaOutbound_Ticketing]
(
[EmailAddress] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SaleDateTime] [datetime] NULL,
[EventName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventDate] [date] NULL,
[MajorCategoryTM] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MinorCategoryTM] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SectionName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RowName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Seat] [int] NULL,
[TicketTypeName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PromoName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsPremium] [bit] NULL,
[IsSingleEvent] [bit] NULL,
[IsPlan] [bit] NULL,
[IsPartial] [bit] NULL,
[IsGroup] [bit] NULL,
[IsRenewal] [bit] NULL,
[IsAttended] [bit] NOT NULL,
[PaidAmount] [decimal] (38, 20) NULL
)
GO
