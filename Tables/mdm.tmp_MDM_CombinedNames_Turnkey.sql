CREATE TABLE [mdm].[tmp_MDM_CombinedNames_Turnkey]
(
[DimCustomerId] [int] NOT NULL
)
GO
CREATE CLUSTERED INDEX [ix_MDM_CombinedNames_dimcustomerID] ON [mdm].[tmp_MDM_CombinedNames_Turnkey] ([DimCustomerId])
GO
