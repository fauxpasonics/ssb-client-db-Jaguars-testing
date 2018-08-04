CREATE TABLE [etl].[EloquaOutbound_DynamicsAccount_base]
(
[EmailAddress] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Account ID] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Street 1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Street 2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Street 3] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[State/Province] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ZIP/Postal Code] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country/Region] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Phone] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Fax] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Website] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Category] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Industry] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Annual Revenue] [money] NULL,
[Season Ticket Member] [bit] NULL,
[Corporate Account] [bit] NULL,
[ValueHash] [binary] (32) NULL
)
GO
