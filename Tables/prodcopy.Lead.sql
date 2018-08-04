CREATE TABLE [prodcopy].[Lead]
(
[accountid] [uniqueidentifier] NULL,
[accountidname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[accountidyominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_addressid] [uniqueidentifier] NULL,
[address1_addresstypecode] [int] NULL,
[address1_addresstypecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_city] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_composite] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_country] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_county] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_fax] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_latitude] [float] NULL,
[address1_line1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_line2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_line3] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_longitude] [float] NULL,
[address1_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_postalcode] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_postofficebox] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_shippingmethodcode] [int] NULL,
[address1_shippingmethodcodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_stateorprovince] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_telephone1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_telephone2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_telephone3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_upszone] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_utcoffset] [int] NULL,
[address2_addressid] [uniqueidentifier] NULL,
[address2_addresstypecode] [int] NULL,
[address2_addresstypecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_city] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_composite] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_country] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_county] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_fax] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_latitude] [float] NULL,
[address2_line1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_line2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_line3] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_longitude] [float] NULL,
[address2_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_postalcode] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_postofficebox] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_shippingmethodcode] [int] NULL,
[address2_shippingmethodcodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_stateorprovince] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_telephone1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_telephone2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_telephone3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_upszone] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_utcoffset] [int] NULL,
[budgetamount] [money] NULL,
[budgetamount_base] [money] NULL,
[budgetstatus] [int] NULL,
[budgetstatusname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[campaignid] [uniqueidentifier] NULL,
[campaignidname] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[companyname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[confirminterest] [bit] NULL,
[confirminterestname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contactid] [uniqueidentifier] NULL,
[contactidname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contactidyominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdby] [uniqueidentifier] NULL,
[createdbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdon] [datetime] NULL,
[createdonbehalfby] [uniqueidentifier] NULL,
[createdonbehalfbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdonbehalfbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customerid] [uniqueidentifier] NULL,
[customeridname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customeridtype] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customeridyominame] [nvarchar] (450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[decisionmaker] [bit] NULL,
[decisionmakername] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotbulkemail] [bit] NULL,
[donotbulkemailname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotemail] [bit] NULL,
[donotemailname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotfax] [bit] NULL,
[donotfaxname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotphone] [bit] NULL,
[donotphonename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotpostalmail] [bit] NULL,
[donotpostalmailname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotsendmarketingmaterialname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotsendmm] [bit] NULL,
[emailaddress1] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[emailaddress2] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[emailaddress3] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[entityimage] [varbinary] (max) NULL,
[entityimage_timestamp] [bigint] NULL,
[entityimage_url] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[entityimageid] [uniqueidentifier] NULL,
[estimatedamount] [money] NULL,
[estimatedamount_base] [money] NULL,
[estimatedclosedate] [datetime] NULL,
[estimatedvalue] [float] NULL,
[evaluatefit] [bit] NULL,
[evaluatefitname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[exchangerate] [decimal] (28, 0) NULL,
[fax] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[firstname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fullname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[importsequencenumber] [int] NULL,
[industrycode] [int] NULL,
[industrycodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[initialcommunication] [int] NULL,
[initialcommunicationname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[isprivatename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[jobtitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[lastname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[lastusedincampaign] [datetime] NULL,
[leadid] [uniqueidentifier] NOT NULL,
[leadqualitycode] [int] NULL,
[leadqualitycodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[leadsourcecode] [int] NULL,
[leadsourcecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[masterid] [uniqueidentifier] NULL,
[masterleadidname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[masterleadidyominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[merged] [bit] NULL,
[mergedname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[middlename] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mobilephone] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedby] [uniqueidentifier] NULL,
[modifiedbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedon] [datetime] NULL,
[modifiedonbehalfby] [uniqueidentifier] NULL,
[modifiedonbehalfbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedonbehalfbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[need] [int] NULL,
[needname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[numberofemployees] [int] NULL,
[originatingcaseid] [uniqueidentifier] NULL,
[originatingcaseidname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[overriddencreatedon] [datetime] NULL,
[ownerid] [uniqueidentifier] NULL,
[owneridname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[owneridtype] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[owneridyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[owningbusinessunit] [uniqueidentifier] NULL,
[owningteam] [uniqueidentifier] NULL,
[owninguser] [uniqueidentifier] NULL,
[pager] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parentaccountid] [uniqueidentifier] NULL,
[parentaccountidname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parentaccountidyominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parentcontactid] [uniqueidentifier] NULL,
[parentcontactidname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parentcontactidyominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[participatesinworkflow] [bit] NULL,
[participatesinworkflowname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[preferredcontactmethodcode] [int] NULL,
[preferredcontactmethodcodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prioritycode] [int] NULL,
[prioritycodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[processid] [uniqueidentifier] NULL,
[purchaseprocess] [int] NULL,
[purchaseprocessname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[purchasetimeframe] [int] NULL,
[purchasetimeframename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[qualificationcomments] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[qualifyingopportunityid] [uniqueidentifier] NULL,
[qualifyingopportunityidname] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[relatedobjectid] [uniqueidentifier] NULL,
[relatedobjectidname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[revenue] [money] NULL,
[revenue_base] [money] NULL,
[salesstage] [int] NULL,
[salesstagecode] [int] NULL,
[salesstagecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[salesstagename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[salutation] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[schedulefollowup_prospect] [datetime] NULL,
[schedulefollowup_qualify] [datetime] NULL,
[sic] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stageid] [uniqueidentifier] NULL,
[statecode] [int] NULL,
[statecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[statuscode] [int] NULL,
[statuscodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_serviceperson] [uniqueidentifier] NULL,
[str_servicepersonname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_servicepersonyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[subject] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[telephone1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[telephone2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[telephone3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[timezoneruleversionnumber] [int] NULL,
[transactioncurrencyid] [uniqueidentifier] NULL,
[transactioncurrencyidname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[traversedpath] [nvarchar] (1250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[utcconversiontimezonecode] [int] NULL,
[versionnumber] [bigint] NULL,
[websiteurl] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[yomicompanyname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[yomifirstname] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[yomifullname] [nvarchar] (450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[yomilastname] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[yomimiddlename] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CopyLoadDate] [datetime] NOT NULL CONSTRAINT [DF__Lead__CopyLoadDa__7FD6B9FC] DEFAULT (getdate())
)
GO
ALTER TABLE [prodcopy].[Lead] ADD CONSTRAINT [PK__Lead__2870F16B1F888A72] PRIMARY KEY CLUSTERED  ([leadid])
GO