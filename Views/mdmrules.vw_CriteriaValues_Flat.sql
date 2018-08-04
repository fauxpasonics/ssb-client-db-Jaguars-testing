SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [mdmrules].[vw_CriteriaValues_Flat] AS SELECT DimCustomerID, [8],[7],[1],[6],[3],[4],[2] 
			FROM  
            (SELECT DimCustomerID, CriteriaID, CriteriaValue 
				FROM mdmrules.tbl_CriteriaValues) AS SourceTable
            PIVOT 
            (
                 MAX(CriteriaValue)
                 FOR CriteriaID in ([8],[7],[1],[6],[3],[4],[2])
            ) p 
GO
