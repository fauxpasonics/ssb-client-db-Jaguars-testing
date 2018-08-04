SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW	[mdm].[vw_CustomRules]
AS
SELECT dc.DimCustomerId
	  ,Last_Suite_Purchase
	  ,Last_Premium_Purchase
	  ,Last_Club_Purchase
	  ,Last_GA_Purchase
	  ,Last_Partial_Purchase
	  ,Last_Group_Purchase
	  ,Last_Single_Purchase
	  ,Eloqua.Last_Email_Activity
FROM dbo.DimCustomer dc
	LEFT JOIN (SELECT dimcustomerid
					 ,MAX(CASE WHEN DimSeatTypeId=4  THEN CalDate END)					AS  Last_Suite_Purchase
					 ,MAX(CASE WHEN DimSeatTypeId=3 THEN CalDate END)					AS  Last_Premium_Purchase
					 ,MAX(CASE WHEN DimSeatTypeId=2 THEN CalDate END)					AS  Last_Club_Purchase
					 ,MAX(CASE WHEN DimSeatTypeId=1 THEN CalDate END)					AS  Last_GA_Purchase
					 ,MAX(CASE WHEN DimTicketTypeId = 4 THEN CalDate END)				AS  Last_Partial_Purchase
					 ,MAX(CASE WHEN DimTicketTypeId IN (6,7,8) THEN CalDate END)		AS  Last_Group_Purchase
					 ,MAX(CASE WHEN DimTicketTypeId NOT IN (1,2,3) THEN CalDate END)	AS  Last_Single_Purchase
			   FROM (  
					   --original sales
					   SELECT dimcustomerid
							 ,fts.DimSeatTypeId
							 ,fts.DimTicketTypeId
							 ,dimdate.CalDate
					   FROM dbo.FactTicketSales fts
						JOIN dbo.DimDate dimdate ON dimdate.DimDateId = fts.DimDateId
						JOIN dbo.Dimseason dimseason ON dimseason.DimseasonId = fts.DimseasonId
						JOIN dbo.DimEvent dimEvent ON dimEvent.DimEventId = fts.DimEventId
					   WHERE (seasonname LIKE '%jaguars manifest%' OR SeasonName LIKE '%jaguars Season%' OR EventCode = '18STMRES')
							 AND dimdate.CalDate > DATEADD(YEAR,-2,GETDATE())

					   UNION ALL

					   --resales
					   SELECT dimcustomerid
							 , 1 dimSeatTypeID
							 , 9 dimTicketTypeID
							 , tex.add_datetime AS CalDate
					   FROM ods.TM_tex tex
						JOIN dbo.vwDimCustomer_ModAcctId dc ON dc.AccountId = tex.assoc_acct_id
						JOIN dbo.DimSeason dimseason ON SSID_season_id = tex.season_id
					   WHERE dc.SourceSystem = 'tm'
							 AND tex.activity_name IN ('Forward','TE Resale')
							 AND (seasonname LIKE '%jaguars manifest%' OR SeasonName LIKE '%jaguars Season%' OR tex.event_name = '18STMRES')
					)fts
			   GROUP BY fts.DimCustomerId
			   )tm ON tm.DimCustomerId = dc.DimCustomerId
	LEFT JOIN ( SELECT dc.DimCustomerId,8 CriteriaID ,MAX(EmailOpen.CreatedAt) Last_Email_Activity
				FROM ods.Eloqua_Contact contact
					JOIN dbo.DimCustomer dc ON dc.ssid = contact.ContactIDExt
					JOIN ods.Eloqua_ActivityEmailOpen EmailOpen ON EmailOpen.ContactId = contact.ID
				WHERE EmailOpen.CreatedAt > DATEADD(YEAR,-2,GETDATE())
				GROUP BY dimcustomerid
			   )Eloqua ON Eloqua.DimCustomerId = dc.DimCustomerId




GO
