SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [etl].[vw_sync_ods_Turnkey_Models] AS (
	
SELECT * FROM ods.Turnkey_Models (NOLOCK)

)



GO
