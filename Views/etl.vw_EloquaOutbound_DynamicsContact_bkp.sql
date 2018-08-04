SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








CREATE VIEW [etl].[vw_EloquaOutbound_DynamicsContact_bkp]

AS
  
SELECT	 CRMContact.firstname                        AS C_FirstName
		,CRMContact.lastname                         AS C_LastName
		,CRMContact.telephone1                       AS C_BusPhone
		,CRMContact.address1_city                    AS C_City
		,CRMContact.address1_country                 AS C_Country
		,CRMContact.str_number                       AS C_Jaguars_ID1
		,CRMContact.contactid                        AS C_MSCRMContactID
		,CRMContact.parentcustomerid                 AS C_MSCRMAccountID
		,CRMContact.str_client_companydecisionmaker  AS C_Company_Decision_Maker1
		,CRMContact.str_priority					 AS C_Lead_Score
		,MostRecentLead.listname					 AS C_Lead_Source___Most_Recent1
		,OriginalLead.listname						 AS C_Lead_Source___Original1
		,cc.ExpirationMonth							 AS C_Credit_Card_Exp_Month1
		,cc.ExpirationYear							 AS C_Credit_Card_Exp_Year1
		,CRMContact.str_externaldistancetovenue      AS C_Distance_to_Client_Venue1
		,CRMContact.str_externaldii                  AS C_Discretionary_Income_Index1
		,CRMContact.str_favoriteplayer               AS C_Favorite_Jaguars_Player1
		,CRMContact.str_favoriteteam                 AS C_Favorite_NFL_Opponent1
		,CRMContact.str_externalfootballpropensity   AS C_Propensity_Towards_Football1
		,CRMContact.creditonhold                     AS C_Credit_Hold1
		,CRMContact.gendercode                       AS C_Gender1
		,CRMContact.jobtitle                         AS C_Job_Role1
		,CRMContact.str_clientminipackbuyer          AS C_Mini_Pack_Buyer_1
		,CRMContact.familystatuscode                 AS C_Marital_Status_in_Household1
		,CRMContact.str_clientpaststm                AS C_Past_Season_Ticket_Member_1
		,CRMContact.new_clientcategoryofinterest	 AS C_Product_Solution_of_Interest1
		,CRMContact.str_clientrenewedcurrentyear     AS C_Renewed_Current_Year_1
		,CRMContact.str_clientrookiestm              AS C_Rookie_Season_Ticket_Member_1
		,CRMContact.str_clientstm                    AS C_Season_Ticket_Member_1
		,CRMContact.str_clientticketbuyertype        AS C_Ticket_Type1
		,CRMContact.str_ticketpriceaverageall        AS C_Ticket_Price_Average1
		,eloquacontact.IsSubscribed				     AS C_Unsubscribed1
		,EloquaContact.EmailAddress					 AS C_EmailAddress
FROM ods.Eloqua_Contact EloquaContact
	JOIN dbo.dimcustomerssbid eloquaSSBID ON eloquaSSBID.ssid = eloquacontact.ContactIDExt	
	JOIN Jaguars_Reporting.prodcopy.Contact CRMContact ON CRMContact.contactid = EloquaContact.C_MSCRMContactID
	LEFT JOIN (SELECT SSB_CRMSYSTEM_CONTACT_ID
					, LEFT(cc_exp,2)   ExpirationMonth
					, RIGHT(cc_exp,2)  ExpirationYear
					, RANK() OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID ORDER BY updateDate DESC, id DESC, dc.dimcustomerid) rnk
			   FROM ods.TM_PayScheduleMOP tm
				JOIN dbo.DimCustomer dc ON dc.AccountId = tm.acct_id
											AND dc.CustomerType = 'Primary'
											AND dc.SourceSystem = 'tm'
				JOIN dbo.dimcustomerssbid ssbid ON ssbid.dimcustomerid = dc.DimCustomerId
			   )cc ON cc.SSB_CRMSYSTEM_CONTACT_ID = eloquaSSBID.SSB_CRMSYSTEM_CONTACT_ID
					  AND cc.rnk = 1
	LEFT JOIN  (SELECT x.entityid
					  ,ListName
				FROM ( SELECT entityid
	   					 , list.listname
	   					 , RANK() OVER(PARTITION BY entityid ORDER BY list.createdon DESC) RecentRank
					   FROM prodcopy.List list
	   					JOIN prodcopy.ListMember ON ListMember.listid = list.listid
					   WHERE list.createdbyname IN ('Jeff Miranda','Ronald Gilbert')
	   					  AND entitytype = 'contact'
					  )x
				WHERE RecentRank = 1
				)MostRecentLead ON MostRecentLead.entityid = CRMContact.contactid
	LEFT JOIN  (SELECT x.entityid
					  ,ListName
				FROM ( SELECT entityid
	   					 , list.listname
	   					 , RANK() OVER(PARTITION BY entityid ORDER BY list.createdon ) OriginalRank
					   FROM prodcopy.List list
	   					JOIN prodcopy.ListMember ON ListMember.listid = list.listid
					   WHERE list.createdbyname IN ('Jeff Miranda','Ronald Gilbert')
	   					  AND entitytype = 'contact'
					  )x
				WHERE OriginalRank = 1
				)OriginalLead ON OriginalLead.entityid = CRMContact.contactid
WHERE eloquaSSBID.SourceSystem = 'eloqua'


GO
