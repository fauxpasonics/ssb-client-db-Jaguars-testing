SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [etl].[vw_sync_ods_Turnkey_Acxiom] AS (
	
SELECT * FROM ods.Turnkey_Acxiom (NOLOCK)

)



GO
