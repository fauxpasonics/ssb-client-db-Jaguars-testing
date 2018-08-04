CREATE TABLE [mdm].[tmp_MDM_CombinedNames]
(
[DimCustomerId] [int] NOT NULL
)
GO
CREATE CLUSTERED INDEX [ix_MDM_CombinedNames_dimcustomerID] ON [mdm].[tmp_MDM_CombinedNames] ([DimCustomerId])
GO
