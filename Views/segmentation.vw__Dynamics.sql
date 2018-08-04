SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [segmentation].[vw__Dynamics]
AS

	SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID	  
		  ,str_oppstage
		  ,str_nextactivitydate
	FROM dimcustomerssbid ssbid
		JOIN prodcopy.contact contact on cast(contact.contactid as NVARCHAR(100)) = ssbid.SSID
	WHERE ssbid.sourcesystem = 'CRM_Contacts'
		


GO
