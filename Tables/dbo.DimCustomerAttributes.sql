CREATE TABLE [dbo].[DimCustomerAttributes]
(
[DimCustomerAttrID] [int] NOT NULL IDENTITY(1, 1),
[DimCustomerID] [int] NULL,
[AttributeGroupID] [int] NULL,
[Attributes] [xml] NULL,
[CreatedDate] [datetime] NULL CONSTRAINT [DF__DimCustom__Creat__31EC6D26] DEFAULT (getdate()),
[UpdatedDate] [datetime] NULL CONSTRAINT [DF__DimCustom__Updat__32E0915F] DEFAULT (getdate())
)
GO
ALTER TABLE [dbo].[DimCustomerAttributes] ADD CONSTRAINT [PK__DimCusto__ABC69402D591B8A0] PRIMARY KEY NONCLUSTERED  ([DimCustomerAttrID])
GO
CREATE CLUSTERED INDEX [IXC_DimCustomerAttributes] ON [dbo].[DimCustomerAttributes] ([DimCustomerID], [AttributeGroupID])
GO
