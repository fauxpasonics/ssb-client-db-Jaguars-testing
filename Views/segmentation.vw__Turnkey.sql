SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [segmentation].[vw__Turnkey]
AS

	SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID	  
		  ,acxiom.AgeInTwoYearIncrements_InputIndividual AS Two_Year_Age
		  ,acxiom.DiscretionaryIncomeIndex				 AS Discretionary_Income_Index
		  ,acxiom.presenceofchildren					 AS Children_Present
		  ,acxiom.Gender_InputIndividual				 AS Gender
		  ,models.FootballPriority						 AS [Priority]
	FROM dimcustomerssbid ssbid
		LEFT JOIN [ods].[Turnkey_Acxiom] acxiom ON concat(acxiom.abilitecID,':',acxiom.ProspectID) = ssbid.SSID
		LEFT JOIN [ods].[Turnkey_Models] Models	ON concat(Models.abilitecID,':',Models.ProspectID) = ssbid.SSID
	WHERE ssbid.sourcesystem = 'turnkey'

GO
