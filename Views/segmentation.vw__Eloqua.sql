SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








CREATE VIEW [segmentation].[vw__Eloqua]
AS

	SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID
		  ,ISNULL(opn.Total_Opened,0)          Total_Opened
		  ,ISNULL(click.Total_Clicked,0)       Total_Clicked	
		  ,ISNULL(wv.Total_Web_Visits,0)       Total_Web_Visits
		  ,ISNULL(pv.Total_Pages_Viewed,0)     Total_Pages_Viewed
		  ,ISNULL(fs.Total_Forms_Submitted,0)  Total_Forms_Submitted
		  ,fs.AssetName Form_Submitted
	FROM dimcustomerssbid ssbid (NOLOCK)
		JOIN [ods].[Eloqua_Contact] contact (NOLOCK) on contact.ContactIDExt = ssbid.SSID
		LEFT JOIN (Select ContactID, COUNT(AssetID) Total_Opened	 FROM [ods].[Eloqua_ActivityEmailOpen] 			(NOLOCK)	GROUP BY ContactID) opn on opn.contactID = contact.ID 
		LEFT JOIN (Select ContactID, COUNT(AssetID) Total_Clicked	 FROM [ods].[Eloqua_ActivityEmailClickThrough] 	(NOLOCK)	GROUP BY ContactID) click on click.contactID = contact.ID 
		LEFT JOIN (Select ContactID, COUNT(AssetID) Total_Web_Visits FROM [ods].[Eloqua_ActivityWebVisit] 			(NOLOCK)	GROUP BY ContactID) wv on wv.contactID = contact.ID 
		LEFT JOIN (Select ContactID, COUNT([URL]) Total_Pages_Viewed FROM [ods].[Eloqua_ActivityPageView] 			(NOLOCK)	GROUP BY ContactID) pv on pv.contactID = contact.ID 
		LEFT JOIN (  Select ContactID
					 	   ,COUNT(AssetID) OVER (PARTITION BY ContactID) Total_Forms_Submitted
					 	   ,AssetName
					 FROM [ods].[Eloqua_ActivityFormSubmit]	(NOLOCK)			
				  ) fs on fs.contactID = contact.ID 
	WHERE ssbid.sourcesystem = 'eloqua'
	



GO
