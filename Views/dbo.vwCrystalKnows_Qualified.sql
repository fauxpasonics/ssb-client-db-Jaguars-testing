SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[vwCrystalKnows_Qualified]
AS

select firstname first_name, lastname last_name, emailPrimary email, companyname company_name, CONCAT(addressprimarycity,', ',addressprimaryState ) [location]
from dimcustomer dc
	JOIN (
			SELECT dimcustomerid
			FROM factticketsales fts
				join dimdate dd on dd.dimdateid = fts.dimdateid
			WHERE caldate > dateadd(year,-3,getdate())


			UNION

			SELECT dimcustomerid
			FROM dimcustomer dc
				JOIN (SELECT DISTINCT CAST(str_contactid AS NVARCHAR(100)) SSID
					  FROM prodcopy.str_TicketOpportunity
					  WHERE	(ISNULL(str_stage2date,'19000101')		>= '20160201' 
							 OR ISNULL(str_stage3date,'19000101')	>= '20160201' 
		    				 OR ISNULL(str_stage4date,'19000101')	>= '20160201' 
		    				 OR ISNULL(str_stage5date,'19000101')	>= '20160201' 
		    				 OR ISNULL(str_stage6date,'19000101')	>= '20160201' 
		    				 OR ISNULL(str_stage7date,'19000101')	>= '20160201') 
					  )crm on crm.SSID = dc.SSID
			where dc.sourcesystem = 'CRM_Contacts'
		  )x on x.dimcustomerid = dc.dimcustomerid











GO
