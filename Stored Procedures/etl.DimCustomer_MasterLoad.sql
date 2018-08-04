SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












CREATE PROCEDURE [etl].[DimCustomer_MasterLoad]

AS
BEGIN


-- CRM Account
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Jaguars', @LoadView = '[etl].[vw_Load_DimCustomer_DynamicsAccount]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

-- CRM Contact
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Jaguars', @LoadView = '[etl].[vw_Load_DimCustomer_DynamicsContacts]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

-- Turnkey
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Jaguars', @LoadView = '[etl].[vw_Load_DimCustomer_Turnkey]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

-- Eloqua
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Jaguars', @LoadView = '[etl].[vw_Load_DimCustomer_Eloqua]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'



END






GO
