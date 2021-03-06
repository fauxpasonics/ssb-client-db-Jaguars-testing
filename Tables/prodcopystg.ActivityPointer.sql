CREATE TABLE [prodcopystg].[ActivityPointer]
(
[activityid] [uniqueidentifier] NOT NULL,
[activitytypecode] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[activitytypecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[actualdurationminutes] [int] NULL,
[actualend] [datetime] NULL,
[actualstart] [datetime] NULL,
[allparties] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[community] [int] NULL,
[communityname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdby] [uniqueidentifier] NULL,
[createdbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdon] [datetime] NULL,
[createdonbehalfby] [uniqueidentifier] NULL,
[createdonbehalfbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdonbehalfbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[deliverylastattemptedon] [datetime] NULL,
[deliveryprioritycode] [int] NULL,
[deliveryprioritycodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[exchangerate] [decimal] (28, 0) NULL,
[instancetypecode] [int] NULL,
[instancetypecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[isbilled] [bit] NULL,
[isbilledname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ismapiprivate] [bit] NULL,
[ismapiprivatename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[isregularactivity] [bit] NULL,
[isregularactivityname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[isworkflowcreated] [bit] NULL,
[isworkflowcreatedname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[leftvoicemail] [bit] NULL,
[leftvoicemailname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedby] [uniqueidentifier] NULL,
[modifiedbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedon] [datetime] NULL,
[modifiedonbehalfby] [uniqueidentifier] NULL,
[modifiedonbehalfbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedonbehalfbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ownerid] [uniqueidentifier] NULL,
[owneridname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[owneridtype] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[owneridyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[owningbusinessunit] [uniqueidentifier] NULL,
[owningteam] [uniqueidentifier] NULL,
[owninguser] [uniqueidentifier] NULL,
[postponeactivityprocessinguntil] [datetime] NULL,
[prioritycode] [int] NULL,
[prioritycodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[processid] [uniqueidentifier] NULL,
[regardingobjectid] [uniqueidentifier] NULL,
[regardingobjectidname] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[regardingobjectidyominame] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[regardingobjecttypecode] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[scheduleddurationminutes] [int] NULL,
[scheduledend] [datetime] NULL,
[scheduledstart] [datetime] NULL,
[sendermailboxid] [uniqueidentifier] NULL,
[sendermailboxidname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[senton] [datetime] NULL,
[seriesid] [uniqueidentifier] NULL,
[serviceid] [uniqueidentifier] NULL,
[serviceidname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stageid] [uniqueidentifier] NULL,
[statecode] [int] NULL,
[statecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[statuscode] [int] NULL,
[statuscodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[subject] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[timezoneruleversionnumber] [int] NULL,
[transactioncurrencyid] [uniqueidentifier] NULL,
[transactioncurrencyidname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[traversedpath] [nvarchar] (1250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[utcconversiontimezonecode] [int] NULL,
[versionnumber] [bigint] NULL,
[CopyLoadDate] [datetime] NOT NULL CONSTRAINT [DF_ProdCopy_ActivityPointer] DEFAULT (getdate())
)
GO
