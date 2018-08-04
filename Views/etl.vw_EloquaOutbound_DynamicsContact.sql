SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











CREATE VIEW [etl].[vw_EloquaOutbound_DynamicsContact]

AS
  
SELECT emailAddress		
	  ,MS_CRM_ContactId
	  ,businessPhone
	  ,city
	  ,companyDecisionMaker
	  ,creditCardExpMonth
	  ,creditCardExpYear
	  ,discretionaryIncomeIndex
	  ,distanceToClientVenue
	  ,favoriteJaguarsPlayer
	  ,favoriteNFLOpponent
	  ,firstName
	  ,gender
	  ,jaguarsId
	  ,jobTitle
	  ,lastName
	  ,leadScore
	  ,leadSourceMostRecent
	  ,leadSourceOriginal
	  ,maritalStatus
	  ,miniPackBuyer
	  ,MS_CRM_AccounttId
	  ,pastSeasonTicketMember
	  ,productOfInterest
	  ,propensityTowardsFootball
	  ,renewedCurrentYear
	  ,rookieSeasonTicketMember
	  ,seasonTicketMember
	  ,ticketPriceAvg
	  ,ticketType
	  ,unsubscribed
FROM (
		SELECT	 EloquaContact.EmailAddress											AS emailAddress		
				,CRMContact.contactid												AS MS_CRM_ContactId
				,CRMContact.telephone1												AS businessPhone
				,CRMContact.address1_city											AS city
				,CRMContact.str_client_companydecisionmaker							AS companyDecisionMaker
				,cc.ExpirationMonth													AS creditCardExpMonth
				,cc.ExpirationYear													AS creditCardExpYear
				--,CRMContact.creditonhold											AS creditHold
				,CRMContact.str_externaldii											AS discretionaryIncomeIndex
				,CRMContact.str_externaldistancetovenue								AS distanceToClientVenue
				,CRMContact.str_favoriteplayer										AS favoriteJaguarsPlayer
				,CRMContact.str_favoriteteam										AS favoriteNFLOpponent
				,CRMContact.firstname												AS firstName
				,CRMContact.gendercode												AS gender
				,CRMContact.new_ssb_primaryarchticsid								AS jaguarsId
				,CRMContact.jobtitle												AS jobTitle
				,CRMContact.lastname												AS lastName
				,CRMContact.str_priority											AS leadScore
				,MostRecentLead.listname											AS leadSourceMostRecent
				,OriginalLead.listname												AS leadSourceOriginal
				,CRMContact.familystatuscode										AS maritalStatus
				,CRMContact.str_clientminipackbuyer									AS miniPackBuyer
				,CRMContact.parentcustomerid										AS MS_CRM_AccounttId
				,CRMContact.str_clientpaststm										AS pastSeasonTicketMember
				,CRMContact.new_clientcategoryofinterest							AS productOfInterest
				,CRMContact.str_externalfootballpropensity							AS propensityTowardsFootball
				,CRMContact.str_clientrenewedcurrentyear							AS renewedCurrentYear
				,CRMContact.str_clientrookiestm										AS rookieSeasonTicketMember
				,CRMContact.str_clientstm											AS seasonTicketMember
				,CRMContact.str_ticketpriceaverageall								AS ticketPriceAvg
				,CRMContact.str_clientticketbuyertype								AS ticketType
				,eloquacontact.IsSubscribed											AS unsubscribed
				,RANK() OVER(PARTITION BY EloquaContact.EmailAddress ORDER BY CRMContact.modifiedon DESC) EmailRank
		FROM ods.Eloqua_Contact EloquaContact
			JOIN dbo.dimcustomerssbid eloquaSSBID ON eloquaSSBID.ssid = CAST(eloquacontact.ContactIDExt	 AS NVARCHAR(100))
			JOIN Jaguars_Reporting.prodcopy.Contact CRMContact ON CAST(CRMContact.contactid AS VARCHAR(100)) = EloquaContact.C_MSCRMContactID
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
	 )x
WHERE EmailRank = 1

GO
