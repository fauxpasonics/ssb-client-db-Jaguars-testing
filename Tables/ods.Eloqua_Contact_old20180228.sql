CREATE TABLE [ods].[Eloqua_Contact_old20180228]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Co__ETL_C__5F3414E9] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Co__ETL_U__60283922] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Eloqua_Co__ETL_I__611C5D5B] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ID] [bigint] NOT NULL,
[Name] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BouncebackDate] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsBounceback] [bit] NULL,
[IsSubscribed] [bit] NULL,
[PostalCode] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Province] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubscriptionDate] [datetime] NULL,
[UnsubscriptionDate] [datetime] NULL,
[CreatedAt] [datetime] NULL,
[CreatedBy] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccessedAt] [datetime] NULL,
[CurrentStatus] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Depth] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedAt] [datetime] NULL,
[UpdatedBy] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailAddress] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Company] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address3] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MobilePhone] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BusinessPhone] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Fax] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Title] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SalesPerson] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_EmailDisplayName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_State_Prov] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Zip_Postal] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Salutation] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SFDCContactID] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SFDCLeadID] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_DateCreated] [date] NULL,
[C_DateModified] [date] NULL,
[ContactIDExt] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SFDCAccountID] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_LastModifiedByExtIntegrateSystem] [date] NULL,
[C_SFDCLastCampaignID] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SFDCLastCampaignStatus] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Company_Revenue1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SFDC_EmailOptOut1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Source___Most_Recent1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Source___Original1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Industry1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Annual_Revenue1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Status1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Job_Role1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_LS___High_Value_Website_Content1] [numeric] (38, 6) NULL,
[C_Lead_Score_Date___Most_Recent1] [date] NULL,
[C_Integrated_Marketing_and_Sales_Funnel_Stage] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Product_Solution_of_Interest1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Region1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_elqPURLName1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Rating___Combined1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_EmailAddressDomain] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_FirstAndLastName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Company_Size1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Score___Last_High_Touch_Event_Date1] [date] NULL,
[C_Lead_Rating___Explicit1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Rating___Implicit1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Score___Explicit1] [numeric] (38, 6) NULL,
[C_Lead_Score___Implicit1] [numeric] (38, 6) NULL,
[C_Lead_Score_Date___Profile___Most_Recent1] [date] NULL,
[C_Employees1] [numeric] (38, 6) NULL,
[C_Territory] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Score] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_ElqPURLName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Jaguars_ID1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRMContactID] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRMLeadID] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRMAccountID] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRMLastCampaignID] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRMLastCampaignName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRMLastCampaignStatus] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_LastMSCRMCampaignResponseID] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRM_EmailOptOut] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRM_LeadRating] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Age__2yr_Increment_1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Presence_of_Children_in_Household1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Gender1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Marital_Status_in_Household1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Discretionary_Income_Index1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Distance_to_Client_Venue1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Propensity_Towards_Football1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Income___Estimated_Household_broad1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Income___Estimated_Household_narrow1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Occupation___Input_Individual1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_PersonicX_Classic_Cluster1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_PersonicX_Classic_Group1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Type1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Relationship_Type1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Date_of_Birth1] [date] NULL,
[C_Home_Phone1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Department1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Credit_Card_Type1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Credit_Card_Number1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Credit_Card_Exp_Month1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Credit_Card_Exp_Year1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Email_Opt_In_Date1] [date] NULL,
[C_NFLSHOP_URL1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_NFLSHOP_CODE1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SHOPRUNNER_PIN1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SHOPRUNNER_URL1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Game_Rewind_Code1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Assigned_Salesperson1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Assigned_Salesperson_Phone_Number1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Assigned_Salesperson_Email1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MD5HashedEmailAddress] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SHA256HashedEmailAddress] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MD5HashedBusPhone] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SHA256HashedBusPhone] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MD5HashedMobilePhone] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SHA256HashedMobilePhone] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MRR_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MRR_Info1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MRR_Email1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MRR_Phone1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Account_Manager_Full_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Account_Manager_First_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Account_Manager_Email1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Account_Manager_Phone_Number1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MRR_First_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Fireshouse_Sub_Codes1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SYS_Opt_in1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SYS_Opt_in_Date1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Mobile_Phone_Number1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Favorite_Jaguars_Player1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Music_Genre1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_How_Purchase_Tickets1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Primary_Phone_Number1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MRR_First_Name_Capital1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_2015_PURL1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Favorite_NFL_Opponent1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Assigned_Inside_Sales_Rep1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Fan_Forum_Number1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Assigned_Renewal_Rep_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Assigned_Renewal_Rep_Email1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Assigned_Renewal_Rep_Phone1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Referrer_First_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Referrer_Last_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Referral_First_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Referral_Last_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_TwitterID1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Credit_Collection_Account_Full_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Credit_Collection_Account_Phone_Number1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Credit_Collection_Account_Email_Address1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_2015_Seat_Relocation_Day1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_2015_Seat_Relocation_Time1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_2015_Relocation_Link1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_AssureSign_Agreement_Link1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_AssureSign_Agreement_Link_FINAL1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Season_Ticket_Member_1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Rookie_Season_Ticket_Member_1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Past_Season_Ticket_Member_1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Renewed_Current_Year_1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Mini_Pack_Buyer_1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Ticket_Type1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Assigned_Sponsorship_Contact1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Junior_Jag_Kid_s_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_NFL_UK_Account_Number1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Number_Of_Tickets_Requested__Events_1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Email1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Jaguars_Women_s_Club_Number1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Special_Case_Non_Renewed___7_27_151] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_STM_Wall_First_And_Last_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Full_Name1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_2015_NFL_Shop_URL1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_2015_NFL_Shop_Code1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_2015_Game_Pass_Code1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Focus_Group_Time1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_RSVP_Link1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Focus_Group_Type1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[Eloqua_Contact_old20180228] ADD CONSTRAINT [PK__Eloqua_C__3214EC279090C24A] PRIMARY KEY CLUSTERED  ([ID])
GO
