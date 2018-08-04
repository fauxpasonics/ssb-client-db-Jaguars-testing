CREATE TABLE [email].[DimEmailType]
(
[DimEmailTypeID] [int] NOT NULL IDENTITY(1, 1),
[EmailType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedDate] [datetime] NULL CONSTRAINT [DF__DimEmailT__Creat__038E755E] DEFAULT (getdate()),
[CreatedBy] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedDate] [datetime] NULL CONSTRAINT [DF__DimEmailT__Updat__04829997] DEFAULT (getdate()),
[UpdatedBy] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [email].[DimEmailType] ADD CONSTRAINT [PK_DimEmailType_DimEmailTypeID] PRIMARY KEY CLUSTERED  ([DimEmailTypeID])
GO
