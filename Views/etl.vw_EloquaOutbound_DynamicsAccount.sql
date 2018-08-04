SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










CREATE VIEW [etl].[vw_EloquaOutbound_DynamicsAccount]

AS
  
	SELECT CAST(crm.AccountID AS VARCHAR(100))				AS [MSCRMAccountID2]			
		  ,crm.[NAME]										AS [CompanyName]
		  ,crm.address1_line1								AS [address]					
		  ,crm.address1_line2								AS [address2]					
		  ,crm.address1_line3								AS [address3]					
		  ,crm.address1_city								AS [city]						
		  ,crm.address1_stateorprovince						AS [stateOrProvince]				
		  ,crm.address1_postalcode							AS [ZIPorPostalCode]				
		  ,crm.address1_country								AS [country]					
		  ,crm.telephone1									AS [businessPhone]				
		  ,crm.address1_fax									AS [fax]						
		  --,crm.websiteurl									AS [wesbsite]				
		  --,crm.str_category								AS [companyCategory]		
		  ,crm.revenue										AS [annualRevenue]			
		  ,crm.str_client_SICDesc							AS [industry]				
		  ,CAST(x.STH		 AS BIT)						AS [seasonTicketMember]	
		  ,CAST(x.IsBusiness AS BIT)						AS [corporateAccount]
	FROM Jaguars_Reporting.prodcopy.Account crm (NOLOCK)
		JOIN dimcustomerssbid ssbid (NOLOCK) ON ssbid.ssid = CAST(crm.accountid AS NVARCHAR(100))
												AND ssbid.sourcesystem = 'CRM_Accounts'
		JOIN ods.Eloqua_Account eloquaAccount ON eloquaAccount.M_MSCRMAccountID = CAST(crm.accountid AS VARCHAR(100))
		LEFT JOIN (SELECT SSB_CRMSYSTEM_CONTACT_ID
						 ,MAX(CASE WHEN sth.DimCustomerId IS NULL THEN 0 ELSE 1 END) STH
						 ,MAX(CAST(dc.IsBusiness AS INT)) IsBusiness
				   FROM dbo.dimcustomerssbid ssbid (NOLOCK)
					LEFT JOIN (SELECT DISTINCT DimCustomerId
							   FROM dbo.FactTicketSales fts (NOLOCK)
								JOIN dbo.Dimseason dimseason (NOLOCK) ON dimseason.DimseasonId = fts.DimseasonId
							   WHERE dimseason.SeasonYear = YEAR(DATEADD(MONTH,-2,GETDATE()))
									  AND fts.DimTicketClassId = 1
							   )sth ON sth.DimCustomerId = ssbid.DimCustomerId
					LEFT JOIN dbo.DimCustomer dc (NOLOCK) ON dc.DimCustomerId = ssbid.DimCustomerId
				   GROUP BY SSB_CRMSYSTEM_CONTACT_ID	
				   )x ON x.SSB_CRMSYSTEM_CONTACT_ID = ssbid.SSB_CRMSYSTEM_CONTACT_ID




GO
