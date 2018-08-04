SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





	


CREATE PROCEDURE [etl].[API_OutboundQueue] AS 


--TRUNCATE TABLE ods.API_OutboundQueue

-- This prcoess needs to be run after the data is ynced to azure.  Ian's outbound process will run at any point after the sync and queue load is complete 

IF OBJECT_ID('tempdb..#Working') IS NOT NULL
	DROP TABLE #working
		
	CREATE TABLE #working --TABLE	 
		(SSID	VARCHAR(50)
		,GroupID INT
		,QueueID INT )

IF OBJECT_ID('tempdb..#tempQueue') IS NOT NULL
	DROP TABLE #tempQueue
		
	CREATE TABLE #tempQueue--TABLE	 
		([APIName] [VARCHAR](100) NOT NULL,
		[APIEntity] [VARCHAR](100) NOT NULL,
		[EndpointName] [VARCHAR](100) NOT NULL,
		[SourceID] [VARCHAR](100) NOT NULL,
		[MemberID] [VARCHAR](100) NOT NULL,
		[Json_Payload] [NVARCHAR](MAX) NOT NULL,
		[httpAction] [NVARCHAR](100) NOT NULL,
		[Description] [VARCHAR](MAX) NULL
		,GroupID INT
		,QueueInsertVal UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL)

--can change ceiling count to 1 if it needs to be sent over in single record firm and not bulk
DECLARE @groups BIGINT = (SELECT CEILING(COUNT(1) / 3000) FROM ods.Emma_Contacts_Outbound_Json_Payload)  --WHERE QueueID IS NULL)
INSERT INTO #working
( SSID, GroupID)
SELECT [EmmaMemberID], NTILE(@groups) OVER(ORDER BY ETL__CreatedDate) FROM ods.Emma_Contacts_Outbound_Json_Payload --WHERE QueueID IS NULL

--SELECT groupid, COUNT(1) FROM #working GROUP BY GroupID ORDER BY 1


DECLARE @max INT = (SELECT MAX(groupid) FROM #working)
DECLARE @count INT = 1


WHILE @count <= @max
BEGIN

INSERT INTO #tempQueue (APIName,APIEntity,EndpointName,SourceID,MemberID, Json_Payload,httpAction,[Description], GroupID)

SELECT 'api' APIName, 'epient' APIEntity, 'members'EndpointName, a.accountID AS SourceID , a.EmmaMemberID AS MemberID, 
( SELECT 
	
a.TicketLevelAccountRep AS	[fields.account-rep]	
--,a.AccountFirstName AS	[fields.First_Name]
--,a.AccountLastName AS	[fields.Last_Name]	
--,a.PrimaryPhone AS	[fields.phone]	
----,a.PrimaryEmail AS	[fields.email]	
--,a.CompanyName	AS [fields.company-name]	
--,a.Address	AS [fields.parentguardian-address]	
--,a.City AS	[fields.city]	
--,a.State	AS [fields.state]	
--,a.Zip	AS [fields.postal_code]	
--,a.KidsClubMemberName	AS [fields.kids-club-member-first-name]	
--,a.KidsClubMemberBirthday	AS [fields.kids-club-members-birthday]
--,a.KidsClubMember2	AS [fields.kids-club-member-2-first-name]	
--,a.KidsClubMemberirthday2	AS [fields.kids-club-member-2s-birthday]	
--,a.KidsClubMember3	AS [fields.kids-club-member-3-first-name]	
--,a.KidsClubMemberBirthday3 AS	[fields.kids-club-member-3-birthday]	
--,a.Acct_ID	AS [fields.archtics-id]	
--,a.SeasonTicketPriceCode AS	[fields.season-ticket-price-code]	
--,a.STH AS	[fields.current-season-ticket-member]	
--,a.Founders_Flag AS	[fields.founder]	
--,a.AccountType AS	[fields.account-type]	
--,a.BrokerFlag AS	[fields.broker]	
--,a.Titans_True AS	[fields.titan-true]	
--,a.Kids_Club	 AS [fields.kids-club]	
--,a.UpcomingGameFlag AS	[fields.upcoming-game]	
--,a.sectionname AS	[fields.section]	
--,a.SeatLocation	AS [fields.seat-location]	
--,a.NumberofSeats	AS [fields.number-of-seats]	
--,a.Club_Holder	AS [fields.club-holder]	
--,a.Upper_Bowl	AS [fields.upper-bowl]	
--,a.Lower_Bowl	AS [fields.lower-bowl]	
--,a.since_date	AS [fields.ticket-holder-since]	
--,a.SGB	 AS [fields.single-game-buyer]	
--,a.Group_Buyer	AS [fields.group-buyer]	
--,a.Partial_Plan	AS [fields.partial-plan-buyer]	
--,a.SecondaryEmail AS 	[fields.secondary-email]	
--,a.ParkingFlag	AS [fields.parking-pass]	
--,a.seasonyear	AS [fields.season]

 FOR JSON PATH) AS json_payload
  ,'Put' httpAction
  ,'This is a write back to Eloqua' [Description]
  ,@count GroupID
 FROM   ods.Emma_Contacts_Outbound_Json_Payload a
  JOIN #working b ON a.[EmmaMemberID] = b.SSID
 WHERE b.GroupID = @count
 --and ETL__CreatedDate = (Getdate()-3)







 SET @count = @count + 1

END




INSERT INTO ods.API_OutboundQueue
	(APIName,
    APIEntity,
    EndpointName,
    SourceID,
	MemberID,
    Json_Payload,
    httpAction,
    [Description]
	)
SELECT 
	APIName,
    APIEntity,
    EndpointName,
    SourceID,
	MemberID,
    Json_Payload,
    httpAction,
    [Description]

FROM #tempQueue






GO
