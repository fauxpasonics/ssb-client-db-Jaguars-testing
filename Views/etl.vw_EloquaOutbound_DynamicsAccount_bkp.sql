SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [etl].[vw_EloquaOutbound_DynamicsAccount_bkp]

AS
  
	SELECT crm.AccountID					AS [M_MSCRMAccountID]			
		  ,crm.[NAME]						AS [M_CompanyName]				
		  ,crm.address1_line1				AS [M_Address1]					
		  ,crm.address1_line2				AS [M_Address2]					
		  ,crm.address1_line3				AS [M_Address3]					
		  ,crm.address1_city				AS [M_City]						
		  ,crm.address1_stateorprovince		AS [M_State_Prov]				
		  ,crm.address1_postalcode			AS [M_ZIP_Postal]				
		  ,crm.address1_country				AS [M_Country]					
		  ,crm.telephone1					AS [M_BusPhone]				
		  ,crm.address1_fax					AS [M_Fax1]						
		  ,crm.websiteurl					AS [M_Wesbsite1]				
		  ,crm.str_category					AS [M_elqCompanyCategory]		
		  ,crm.revenue						AS [M_Annual_Revenue1]			
		  ,crm.str_client_SICDesc			AS [M_Industry1]				
		  ,CAST(x.STH		 AS BIT)		AS [M_Season_Ticket_Member_1]	
		  ,CAST(x.IsBusiness AS BIT)		AS [M_Corporate_Account1]
	FROM Jaguars_Reporting.prodcopy.Account crm
		JOIN dimcustomerssbid ssbid ON ssbid.ssid = crm.accountid
										AND ssbid.sourcesystem = 'CRM_Accounts'
		LEFT JOIN (SELECT SSB_CRMSYSTEM_CONTACT_ID
						 ,MAX(CASE WHEN sth.DimCustomerId IS NULL THEN 0 ELSE 1 END) STH
						 ,MAX(CAST(dc.IsBusiness AS INT)) IsBusiness
				   FROM dbo.dimcustomerssbid ssbid
					LEFT JOIN (SELECT DISTINCT DimCustomerId
							   FROM dbo.FactTicketSales fts
								JOIN dbo.Dimseason dimseason ON dimseason.DimseasonId = fts.DimseasonId
							   WHERE dimseason.SeasonYear = YEAR(DATEADD(MONTH,-2,GETDATE()))
									  AND fts.DimTicketClassId = 1
							   )sth ON sth.DimCustomerId = ssbid.DimCustomerId
					LEFT JOIN dbo.DimCustomer dc ON dc.DimCustomerId = ssbid.DimCustomerId
				   GROUP BY SSB_CRMSYSTEM_CONTACT_ID	
				   )x ON x.SSB_CRMSYSTEM_CONTACT_ID = ssbid.SSB_CRMSYSTEM_CONTACT_ID

GO
