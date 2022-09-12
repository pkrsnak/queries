
SELECT   std.STORE_NBR,
         ri.PRODUCT_UPC,
         ri.ITEM_DESCRIPTION,
         ri.SIZE_UOM,
         std.TRANS_NBR,
         std.TRANS_SEQ_NBR,
         std.TOTAL_SALES_AMT,
         std.TOTAL_SALES_QTY,
         std.TOTAL_SALES_WGT,
         std.ORIGIN
FROM     EDW.RTL.STR_TRANS_DTL std 
         inner join EDW.RTL.RETAIL_ITEM_VW ri on ri.RETAIL_ITEM_PK = std.RETAIL_ITEM_ID
WHERE    STORE_NBR in (3253, 2304)
AND      SALES_DATE_ID = 20220602
;


-- EDW.RTL.RETAIL_SALES_DEPT_COUNT_VW source

create or replace view RETAIL_SALES_DEPT_COUNT_VW(
	SALES_DATE_ID,
	STORE_NBR,
	DEPT_KEY,
	EVENT_CD,
	DISCOUNT_TYPE_CD,
	ITEM_CNT,
	DEPT_ADJ_TRANS_CNT,
	ADJ_TRANS_CNT,
	CREATE_TMSP,
	UPDATE_TMSP
) as                                                                                                                                
SELECT                                                                                                                              
  SALES_DATE_ID,                                                                                                                    
  STORE_NBR,                                                                                                                        
  DEPT_KEY,                                                                                                                         
  EVENT_CD,                                                                                                                         
  DISCOUNT_TYPE_CD,                                                                                                                 
  SUM(ITEM_CNT) ITEM_CNT,                                                                                                           
  CAST(                                                                                                                             
    SUM(DEPT_ADJ_TRANS_CNT) AS NUMBER(18, 0)                                                                                        
  ) DEPT_ADJ_TRANS_CNT,                                                                                                             
  CAST(                                                                                                                             
    SUM(ADJ_TRANS_CNT) AS NUMBER(18, 0)                                                                                             
  ) ADJ_TRANS_CNT,                                                                                                                  
  CREATE_TMSP,                                                                                                                      
  UPDATE_TMSP                                                                                                                       
FROM                                                                                                                                
  (                                                                                                                                 
    SELECT                                                                                                                          
      A.SALES_DATE_ID,                                                                                                              
      A.STORE_NBR,                                                                                                                  
      A.DEPT_KEY,                                                                                                                   
      'REG' AS EVENT_CD,                                                                                                            
      '00' AS DISCOUNT_TYPE_CD,                                                                                                     
      SUM(TOTAL_SALES_QTY) AS ITEM_CNT,                                                                                             
      COUNT(                                                                                                                        
        DISTINCT DISCOUNT_TYPE_CD || TRANS_NBR || REGISTER_ID                                                                       
      ) AS DEPT_ADJ_TRANS_CNT,                                                                                                      
      0 AS ADJ_TRANS_CNT,                                                                                                           
      TO_TIMESTAMP_NTZ(                                                                                                             
        DATE(A.SALES_DATE_ID, 'YYYYMMDD')                                                                                           
      ) CREATE_TMSP,                                                                                                                
      TO_TIMESTAMP_NTZ(                                                                                                             
        DATE(A.SALES_DATE_ID, 'YYYYMMDD')                                                                                           
      ) UPDATE_TMSP                                                                                                                 
    FROM                                                                                                                            
      str_trans_dtl_ctmsp_mv A                                                                                                      
      JOIN STORE_DIM S ON A.STORE_NBR = S.STORE_NBR                                                                                 
    WHERE                                                                                                                           
      LINE_TYPE IN ('N0', 'N2', 'N8', 'T0', 'T2', 'T8')                                                                             
    AND NOT (SALES_DATE_ID < 20211107 AND S.MKTG_CHAIN_ID = 230)                                                                    
    GROUP BY                                                                                                                        
      1,                                                                                                                            
      2,                                                                                                                            
      3                                                                                                                             
    UNION                                                                                                                           
    SELECT                                                                                                                          
      A.SALES_DATE_ID,                                                                                                              
      A.STORE_NBR,                                                                                                                  
      MAX(A.DEPT_KEY) DEPT_KEY,                                                                                                     
      'REG' AS EVENT_CD,                                                                                                            
      '00' AS DISCOUNT_TYPE_CD,                                                                                                     
      0 AS ITEM_CNT,                                                                                                                
      0 AS DEPT_ADJ_TRANS_CNT,                                                                                                      
      COUNT(                                                                                                                        
        DISTINCT DISCOUNT_TYPE_CD || TRANS_NBR || REGISTER_ID                                                                       
      ) AS ADJ_TRANS_CNT,                                                                                                           
      TO_TIMESTAMP_NTZ(                                                                                                             
        DATE(A.SALES_DATE_ID, 'YYYYMMDD')                                                                                           
      ) CREATE_TMSP,                                                                                                                
      TO_TIMESTAMP_NTZ(                                                                                                             
        DATE(A.SALES_DATE_ID, 'YYYYMMDD')                                                                                           
      ) UPDATE_TMSP                                                                                                                 
    FROM                                                                                                                            
      str_trans_dtl_ctmsp_mv A                                                                                                      
      JOIN STORE_DIM S ON A.STORE_NBR = S.STORE_NBR                                                                                 
    WHERE                                                                                                                           
      LINE_TYPE IN ('N0', 'N2', 'N8', 'T0', 'T2', 'T8')                                                                             
    AND NOT (SALES_DATE_ID < 20211107 AND S.MKTG_CHAIN_ID = 230)                                                                    
    GROUP BY                                                                                                                        
      1,                                                                                                                            
      2                                                                                                                             
    UNION                                                                                                                           
    SELECT                                                                                                                          
      REPLACE(A.SALES_DATE,'-') AS SALES_DATE_ID,                                                                                   
      A.STORE_NBR,                                                                                                                  
      A.DEPARTMENT_ID AS DEPT_KEY,                                                                                                  
      'REG' AS EVENT_CD,                                                                                                            
      '00' AS DISCOUNT_TYPE_CD,                                                                                                     
      A.ITEM_CNT,                                                                                                                   
      A.DEPT_ADJ_TRANS_CNT,                                                                                                         
      0 AS ADJ_TRANS_CNT,                                                                                                           
      TO_TIMESTAMP_NTZ(A.SALES_DATE) CREATE_TMSP,                                                                                   
      TO_TIMESTAMP_NTZ(A.SALES_DATE) UPDATE_TMSP                                                                                    
    FROM EDL.POS_TOSHIBA.RSALES_DAY_STR_DPT A                                                                                       
    JOIN STORE_DIM S ON A.STORE_NBR = S.STORE_NBR                                                                                   
    WHERE S.MKTG_CHAIN_ID = 230                                                                                                     
    AND A.SALES_DATE BETWEEN '2018-01-01' AND '2021-11-06'                                                                          
    UNION                                                                                                                           
    SELECT                                                                                                                          
      REPLACE(A.SALES_DATE,'-') AS SALES_DATE_ID,                                                                                   
      A.STORE_NBR,                                                                                                                  
      MAX(A.DEPARTMENT_ID) AS DEPT_KEY,                                                                                             
      'REG' AS EVENT_CD,                                                                                                            
      '00' AS DISCOUNT_TYPE_CD,                                                                                                     
      0 AS ITEM_CNT,                                                                                                                
      0 AS DEPT_ADJ_TRANS_CNT,                                                                                                      
      RC.ADJ_TRANS_CNT,                                                                                                             
      TO_TIMESTAMP_NTZ(A.SALES_DATE) CREATE_TMSP,                                                                                   
      TO_TIMESTAMP_NTZ(A.SALES_DATE) UPDATE_TMSP                                                                                    
    FROM EDL.POS_TOSHIBA.RSALES_DAY_STR_DPT A                                                                                       
    JOIN EDL.POS_TOSHIBA.RTL_DY_STR_CNT_TYP RC ON A.SALES_DATE = RC.SALES_DATE AND A.STORE_NBR = RC.STORE_NBR AND RC.CNT_TYPE_CD = 0
    JOIN STORE_DIM S ON A.STORE_NBR = S.STORE_NBR                                                                                   
    WHERE S.MKTG_CHAIN_ID = 230                                                                                                     
    AND A.SALES_DATE BETWEEN '2018-01-01' AND '2021-11-06'                                                                          
    GROUP BY A.SALES_DATE,A.STORE_NBR, RC.ADJ_TRANS_CNT                                                                             
  ) SALESAGG                                                                                                                        
GROUP BY                                                                                                                            
  1,                                                                                                                                
  2,                                                                                                                                
  3,                                                                                                                                
  4,                                                                                                                                
  5,                                                                                                                                
  9,                                                                                                                                
  10;



SELECT   A.SALES_DATE_ID,
         A.STORE_NBR,
         A.DEPT_KEY,
         'REG' AS EVENT_CD,
         '00' AS DISCOUNT_TYPE_CD,
         sum(case when TOTAL_SALES_WGT = 0 then TOTAL_SALES_QTY else case when TOTAL_SALES_QTY = 0 then 0 else TOTAL_SALES_WGT / TOTAL_SALES_QTY end end) AS ITEM_CNT,
         COUNT( DISTINCT DISCOUNT_TYPE_CD || TRANS_NBR || REGISTER_ID ) AS DEPT_ADJ_TRANS_CNT,
         0 AS ADJ_TRANS_CNT,
         TO_TIMESTAMP_NTZ( DATE(A.SALES_DATE_ID, 'YYYYMMDD') ) CREATE_TMSP,
         TO_TIMESTAMP_NTZ( DATE(A.SALES_DATE_ID, 'YYYYMMDD') ) UPDATE_TMSP
FROM     EDW.RTL.str_trans_dtl_ctmsp_mv A 
         JOIN EDW.RTL.STORE_DIM S ON A.STORE_NBR = S.STORE_NBR
WHERE    LINE_TYPE IN ('N0', 'N2', 'N8', 'T0', 'T2', 'T8')
AND      NOT (SALES_DATE_ID < 20211107
     AND S.MKTG_CHAIN_ID = 230)
and A.store_nbr = 3253
and A.SALES_DATE_ID = 20220602
GROUP BY 1, 2, 3        
       ;



 SELECT                                                                                                                          
      A.SALES_DATE_ID,                                                                                                              
      A.STORE_NBR,                                                                                                                  
      A.DEPT_KEY,                                                                                                                   
      'REG' AS EVENT_CD,                                                                                                            
      '00' AS DISCOUNT_TYPE_CD,                                                                                                     
      SUM(TOTAL_SALES_QTY) AS ITEM_CNT,                                                                                             
      COUNT(                                                                                                                        
        DISTINCT DISCOUNT_TYPE_CD || TRANS_NBR || REGISTER_ID                                                                       
      ) AS DEPT_ADJ_TRANS_CNT,                                                                                                      
      0 AS ADJ_TRANS_CNT,                                                                                                           
      TO_TIMESTAMP_NTZ(                                                                                                             
        DATE(A.SALES_DATE_ID, 'YYYYMMDD')                                                                                           
      ) CREATE_TMSP,                                                                                                                
      TO_TIMESTAMP_NTZ(                                                                                                             
        DATE(A.SALES_DATE_ID, 'YYYYMMDD')                                                                                           
      ) UPDATE_TMSP                                                                                                                 
    FROM                                                                                                                            
      EDW.RTL.str_trans_dtl_ctmsp_mv A                                                                                                      
      JOIN EDW.RTL.STORE_DIM S ON A.STORE_NBR = S.STORE_NBR                                                                                 
    WHERE                                                                                                                           
      LINE_TYPE IN ('N0', 'N2', 'N8', 'T0', 'T2', 'T8')                                                                             
    AND NOT (SALES_DATE_ID < 20211107 AND S.MKTG_CHAIN_ID = 230)                                                                    
and A.store_nbr = 3253
and A.SALES_DATE_ID = 20220602
    GROUP BY                                                                                                                        
      1,                                                                                                                            
      2,                                                                                                                            
      3                                                           

;


-- EDW.RTL.RETAIL_SALES_VW source

create or replace view RETAIL_SALES_VW(
	STORE_NBR,
	SALES_DATE_ID,
	RETAIL_ITEM_ID,
	RSL_DEPT_ID,
	STORE_COMP_PK,
	DISCOUNT_TYPE_CD,
	PRICE_TYPE,
	EVENT_CD,
	PROMOTION_ID,
	DISCOUNT_LINK_CD,
	LIST_UNIT_COST_AMT,
	UNIT_COST_ALLW_AMT,
	LIST_UNIT_PRC_AMT,
	PROM_UNIT_PRC_AMT,
	TOTAL_SALES_AMT,
	TOTAL_SALES_QTY,
	TOTAL_SALES_WGT,
	EXT_COST_AMT,
	EXT_COST_ALLW_AMT,
	EXT_GROSS_PRC_AMT,
	EXT_PROM_PRC_AMT,
	DISCOUNT_AMT,
	ALLOCATED_DISC_AMT,
	EXT_BILLBACK_AMT,
	CREATE_TMSP,
	UPDATE_TMSP
) as
SELECT
CY.STORE_NBR,
CY.SALES_DATE_ID,
CY.RETAIL_ITEM_ID,
CY.RSL_DEPT_ID,
CY.STORE_COMP_PK,
CY.DISCOUNT_TYPE_CD,
CY.PRICE_TYPE,
CY.EVENT_CD,
CY.PROMOTION_ID,
CY.DISCOUNT_LINK_CD,
CY.LIST_UNIT_COST_AMT,
CY.UNIT_COST_ALLW_AMT,
CY.LIST_UNIT_PRC_AMT,
CY.PROM_UNIT_PRC_AMT,
SUM(CY.TOTAL_SALES_AMT) AS TOTAL_SALES_AMT,
SUM(CY.TOTAL_SALES_QTY) AS TOTAL_SALES_QTY,
SUM(CY.TOTAL_SALES_WGT) AS TOTAL_SALES_WGT,
--0 AS TOTAL_SALES_LW_AMT,
--0 AS TOTAL_SALES_LW_QTY,
--0 AS TOTAL_SALES_LW_WGT,
--0 AS LY_TOTAL_SALES_AMT,
--0 AS LY_TOTAL_SALES_QTY,
--0 AS LY_TOTAL_SALES_WGT,
--L2Y.TOTAL_SALES_AMT AS L2Y_TOTAL_SALES_AMT,
--L2Y.TOTAL_SALES_QTY AS L2Y_TOTAL_SALES_QTY,
--L2Y.TOTAL_SALES_WGT AS L2Y_TOTAL_SALES_WGT,
SUM(CY.EXT_COST_AMT) AS EXT_COST_AMT,
SUM(CY.EXT_COST_ALLW_AMT) AS EXT_COST_ALLW_AMT,
SUM(CY.EXT_GROSS_PRC_AMT) AS EXT_GROSS_PRC_AMT,
SUM(CY.EXT_PROM_PRC_AMT) AS EXT_PROM_PRC_AMT,
SUM(CY.DISCOUNT_AMT) AS DISCOUNT_AMT, 
SUM(CY.ALLOCATED_DISC_AMT) AS ALLOCATED_DISC_AMT,
SUM(CY.EXT_BILLBACK_AMT) AS EXT_BILLBACK_AMT,
CY.CREATE_TMSP,
CY.UPDATE_TMSP
FROM
EDW.RTL.STR_TRANS_DTL_AGG_MV CY
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,25,26;