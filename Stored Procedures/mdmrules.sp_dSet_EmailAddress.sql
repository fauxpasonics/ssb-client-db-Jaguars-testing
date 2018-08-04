SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create proc [mdmrules].[sp_dSet_EmailAddress]
AS

DECLARE @Criteria table (CriteriaID int, Criteria varchar(50))
Insert into @Criteria
Select 8, 'Email Address';


--Final Select
SELECT SSID, CriteriaID, CAST(CAST(UpdatedAt AS DATE) AS VARCHAR(50)) CriteriaValue
FROM 
(
	SELECT DISTINCT contact.ContactIDExt AS SSID,max(UpdatedAt) UpdatedAt
FROM ods.Eloqua_Contact contact
JOIN ods.Eloqua_ActivityEmailOpen EmailOpen ON EmailOpen.ContactId = contact.ID
group by ContactIDExt
)x
Join  @Criteria b
	ON b.Criteria = 'Email Address'




GO
