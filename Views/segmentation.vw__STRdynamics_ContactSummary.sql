SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [segmentation].[vw__STRdynamics_ContactSummary] AS


SELECT DISTINCT  contact.new_ssbcrmsystemcontactid																										AS [SSB_CRMSYSTEM_CONTACT_ID]
	  			,contact.contactId																														AS [Dynamics_Contact_ID]
	  			,contact.fullname																														AS [Contact_Name]
	  			,contact.CreatedOn																														AS [Created_On]
	  			,contact.CreatedBy																														AS [Created_By]
	  			,createdUser.fullname																													AS [Created_By_Name]
	  			,contact.modifiedOn																														AS [Modified_On]						
	  			,contact.ModifiedBy																														AS [Modified_By]
	  			,contact.OwnerId																														AS [Owner_Id]
	  			,accountOwner.fullName																													AS [Owner_Name]
	  			,contact.str_lastactivitydate																											AS [Last_Activity_Date]
	  			,DATEDIFF(DAY,contact.str_lastactivitydate,GETDATE())																					AS [Days_Since_Last_Activity]
	  			,next_activity.[Next_Activity_Date]																										AS [Next_Activity_Date]
	  			,CASE WHEN next_activity.[Next_Activity_Date] < GETDATE() THEN 1 ELSE 0 END																AS [Next_Activity_Overdue]
	  			--,LastActivityOwner /*this requires prodcopy.task to be imported*/
	  			, OpenOpp.OpenOpp																														AS [Has_Open_Opportunity]
	  			,LastOpportunity.createdon																												AS [Last_Opportunity_Created_Date]
	  			,LastOpportunity.OwnerName																												AS [Last_Opportunity_Owner_Name]
	  			,LastOpportunity.ModifiedOn																												AS [Last_Opportunity_Last_Modified_Date]
	  			,lastWon.LastWinDate																													AS [Last_Opportunity_Closed_Won_Date]
	  			,LastLost.str_stage8text																												AS [Last_Opportunity_Closed_Lost_Reason]
	  			,ISNULL(multiple_opp.Multiple_opps_diff_users,0)																						AS [MultipleOpps_Different_Users]
	  			,multi_opp_product.Flag																													AS [DuplicateOpps_with_same_product]	  
 FROM  (SELECT *, ROW_NUMBER() OVER(PARTITION BY new_ssbcrmsystemcontactid ORDER BY ModifiedOn DESC, CreatedOn) ContactRank 
	    FROM Jaguars_Reporting.ProdCopy.Contact b 
		WHERE new_ssbcrmsystemcontactid IS NOT NULL
	    ) contact
	JOIN Jaguars_Reporting.ProdCopy.[SystemUser] (NOLOCK) createdUser ON contact.CreatedBy=createdUser.systemuserID 
	JOIN Jaguars_Reporting.ProdCopy.[SystemUser] (NOLOCK) accountOwner ON contact.OwnerId=accountowner.systemuserId
	LEFT JOIN (SELECT opportunity.str_contactid
			  		   		 ,opportunity.modifiedon
			  		   		 ,[user].fullName OwnerName
			  		   		 ,opportunity.createdon
			  				 ,RANK() OVER(PARTITION BY opportunity.str_contactid ORDER BY opportunity.str_ticketopportunityid) opportunityRank
			  		   FROM Jaguars_Reporting.ProdCopy.str_TicketOpportunity (NOLOCK) opportunity
			  			JOIN (SELECT str_contactid
			  						,MAX(CreatedOn)MaxDate
			  				  FROM Jaguars_Reporting.ProdCopy.str_ticketOpportunity (NOLOCK)
			  				  GROUP BY str_contactid
			  				  )x ON x.str_contactid = opportunity.str_contactid
			  						AND x.MaxDate = opportunity.Createdon
			  		   	INNER JOIN Jaguars_Reporting.ProdCopy.[systemuser] (NOLOCK) [user] ON [user].systemuserid = opportunity.OwnerId
	
	)LastOpportunity ON LastOpportunity.str_contactid = contact.contactid
						AND LastOpportunity.opportunityRank = 1
	LEFT JOIN (SELECT str_contactid, MAX(Modifiedon)OpenOpp
			   FROM Jaguars_Reporting.ProdCopy.str_TicketOpportunity (NOLOCK)
			   WHERE statecode = 0 AND (str_ticketstageidname <> '7 - Won' OR str_ticketstageidname <> '8 - Lost')
			   GROUP BY str_contactid
			   ) OpenOpp ON OpenOpp.str_contactid = contact.contactid
	LEFT JOIN (SELECT str_contactid
					  ,MAX(ISNULL(str_stage7date,modifiedon))LastWinDate 
			   FROM Jaguars_Reporting.ProdCopy.str_TicketOpportunity (NOLOCK)
			   WHERE statecode = 0 AND str_ticketstageidname = '7 - Won'
			   GROUP BY str_contactid
			   ) LastWon ON LastWon.str_contactid = contact.contactId
	LEFT JOIN (SELECT opportunity.str_contactid AS accountid
					  ,str_stage8text
					  ,RANK() OVER(PARTITION BY opportunity.str_contactid ORDER BY opportunity.str_ticketopportunityid) opportunityRank
			   FROM Jaguars_Reporting.ProdCopy.str_TicketOpportunity opportunity (NOLOCK)
					JOIN (SELECT str_contactid
								,MAX(str_stage8date) AS LastLoss
						  FROM Jaguars_Reporting.ProdCopy.str_TicketOpportunity (NOLOCK)
						  WHERE str_ticketstageidname = '8 - Lost' AND statecode = 0
						  GROUP BY str_contactid)LastLoss ON LastLoss.str_contactid = Opportunity.str_contactid
														 AND LastLoss.LastLoss = Opportunity.str_stage8date
			   ) LastLost ON LastLost.AccountId = contact.contactId	
							 AND LastLost.opportunityRank = 1
	LEFT JOIN ( SELECT DISTINCT str_contactid, 1 AS [Multiple_opps_diff_users]
				FROM ( SELECT DISTINCT opp.str_contactid, opp.OwnerId, own.[fullName] ,RANK() OVER(PARTITION BY opp.str_contactID ORDER BY opp.ownerid) AS [Rank]
				    	FROM Jaguars_Reporting.ProdCopy.str_TicketOpportunity opp (NOLOCK)
				    		JOIN Jaguars_Reporting.ProdCopy.[systemUser] own ON opp.OwnerId = own.systemuserId
				    	WHERE (str_ticketstageidname <> '7 - Won' OR str_ticketstageidname <> '8 - Lost')
				    	) multiple_opp			
				GROUP BY str_contactid
				HAVING MAX(multiple_opp.Rank) > 1
				) multiple_opp ON multiple_opp.str_contactid = contact.contactId
			
	LEFT JOIN (SELECT a.contactid, 
				CASE WHEN a.str_nextactivitydate > a.NextActivityDate THEN a.str_nextactivitydate
					 WHEN a.str_nextactivitydate <= a.NextActivityDate THEN a.nextactivitydate
					 WHEN a.str_nextactivitydate IS NOT NULL AND a.NextActivityDate IS NULL THEN a.str_nextactivitydate
					 WHEN a.str_nextactivitydate IS NULL AND a.NextActivityDate IS NOT NULL THEN a.NextActivityDate
					 ELSE NULL
				END AS [Next_Activity_Date]
				FROM (	SELECT c.contactid, c.str_nextactivitydate, MAX(opp.str_nextactivity) AS [NextActivityDate]
				  		FROM  Jaguars_Reporting.ProdCopy.contact c
				  		 	JOIN Jaguars_Reporting.ProdCopy.str_TicketOpportunity opp ON c.contactid = opp.str_contactid
				  		WHERE (str_ticketstageidname <> '7 - Won' OR str_ticketstageidname <> '8 - Lost')
				  		GROUP BY c.contactid, c.str_nextactivitydate
				  		) a
				  	
				) next_activity ON next_activity.contactId = contact.contactid			
	LEFT JOIN (
        		SELECT opp.str_contactid, opp.str_pricelevelidname , opp.str_ticketproductidname, 1 AS [Flag]
				FROM Jaguars_Reporting.ProdCopy.str_ticketopportunity opp
				WHERE(str_ticketstageidname <> '7 - Won' OR str_ticketstageidname <> '8 - Lost')
				GROUP BY opp.str_contactid, opp.str_pricelevelidname , opp.str_ticketproductidname
				HAVING COUNT(*) > 1
				) multi_opp_product ON multi_opp_product.str_contactid = contact.contactid
WHERE contact.ContactRank = 1		


GO
