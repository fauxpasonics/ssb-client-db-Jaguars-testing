SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [dbo].[vwTurnKey_Qualified]
AS

--Ticketing
SELECT 'tm' AS SourceSystem	
	   ,CAST(dc.AccountId AS NVARCHAR(255)) SSID	
	   ,CAST(dc.AccountId AS NVARCHAR(255)) TicketingSystemAccountID	
	   ,dc.CreatedDate SubmitDate
FROM (
		SELECT fts.SSID_acct_id AccountID
		FROM factticketsales fts
			JOIN dbo.DimSeason dimseason ON dimseason.DimSeasonId = fts.DimSeasonId
			JOIN dbo.Dimevent dimevent ON dimevent.DimeventId = fts.DimeventId
		WHERE DimEvent.EventCode LIKE '__GM%'
			 AND seasonyear >= 2015		 
		GROUP BY SSID_acct_id

		UNION

		--Ticket Exchange
		SELECT tex.assoc_acct_id AccountID
		FROM ods.TM_Tex tex
		WHERE tex.event_name LIKE '__GM%'
			  AND tex.season_year >= 2015
			  AND activity_name IN ('TE Resale','Forward','Resale Transfer','Ticket Transfer')
		GROUP BY tex.assoc_acct_id
	 )tkt
	 JOIN dbo.DimCustomer dc ON dc.AccountId = tkt.AccountID
WHERE dc.SourceSystem = 'tm'
	  AND dc.CustomerType = 'primary'
	  AND dc.AddressPrimaryState IN ('Florida','Georgia','FL','GA')

UNION ALL

--CRM
SELECT CAST('CRM_Contacts' AS NVARCHAR(255)) AS SourceSystem 
	  , CAST(dc.SSID AS NVARCHAR(255)) AS SSID
	  , CAST(NULL AS NVARCHAR(255)) AS TicketSystemAccountID  
	  , dc.createdDate AS SubmitDate
FROM dimcustomer dc
JOIN (
		SELECT DISTINCT CAST(regardingobjectid AS NVARCHAR(100)) SSID
		FROM prodcopy.activityPointer
		WHERE activitytypecode IN ('PhoneCall','Email') 
  			AND regardingobjecttypecode = 'contact'
 			AND actualend <= GETDATE() 
  			AND actualEnd > DATEADD(DAY,-120,GETDATE())
	  
		UNION
		  
		SELECT DISTINCT CAST(str_contactid AS NVARCHAR(100)) SSID
		FROM prodcopy.str_TicketOpportunity
		WHERE 	ISNULL(str_stage3date,'19000101') >= '20160101' 
	   		 OR ISNULL(str_stage4date,'19000101') >= '20160101'  
			 OR ISNULL(str_stage5date,'19000101') >= '20160101'  
			 OR ISNULL(str_stage6date,'19000101') >= '20160101'  
			 OR ISNULL(str_stage7date,'19000101') >= '20160101'  

		UNION 

		SELECT DISTINCT entityid
		FROM prodcopy.List list
			JOIN prodcopy.ListMember ON ListMember.listid = list.listid
		WHERE list.createdbyname IN ('Jeff Miranda','Ronald Gilbert')
			  AND entitytype = 'contact'
			  AND list.createdon >= '20170101'
	)crm
ON crm.SSID = dc.SSID
WHERE dc.sourcesystem = 'CRM_Contacts'
AND dc.AddressPrimaryState IN ('Florida','Georgia','FL','GA')
;



GO
