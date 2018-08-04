CREATE TABLE [mdm].[tmp_Account_baseTbl_2]
(
[dimcustomerid] [int] NOT NULL,
[ssid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[sourcesystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[hashplaintext_11] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hash_11] [varbinary] (32) NULL
)
GO
CREATE CLUSTERED INDEX [ix_dimcustomerid] ON [mdm].[tmp_Account_baseTbl_2] ([dimcustomerid])
GO
CREATE NONCLUSTERED INDEX [ix_hash_11] ON [mdm].[tmp_Account_baseTbl_2] ([hash_11]) INCLUDE ([dimcustomerid])
GO
