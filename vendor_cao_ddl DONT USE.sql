--------------------------------------------------
-- Create Table CAOADMIN.T_ITEM_MASTER
--------------------------------------------------
Drop table CAOADMIN.T_ITEM_MASTER;

Create table CAOADMIN.T_ITEM_MASTER (                                 
    BEGIN_DATE                     DATE                NOT NULL    ,
    END_DATE                       DATE                NOT NULL    ,
    ORDER_CODE                     VARCHAR(16)         NOT NULL    ,
    ITEM_NBR_HS                    VARCHAR(7)          NOT NULL    ,
    ITEM_DESCRIP                   VARCHAR(35)                     ,
    PACK                           INTEGER                         ,  --assumes case pack is the order conversion factor
    ITEM_SIZE_DESCRIP              VARCHAR(10)                     ,
    ITEM_SIZE                      DECIMAL(9,2)    With Default 0  ,
    ITEM_SIZE_UOM                  VARCHAR(2)                      ,
    UPC_CASE                       VARCHAR(17)                     ,
    UPC_UNIT                       VARCHAR(17)                     ,
    ITEM_DEPT                      VARCHAR(3)                      ,
    PURCH_STATUS                   VARCHAR(1)                      ,
    BILLING_STATUS                 VARCHAR(1)                      ,
    PROCESS_TIMESTAMP              TIMESTAMP                       ,
    PROCESS_TYPE                   CHAR(1)                         ) 
;



--------------------------------------------------
-- Create View CAOADMIN.V_ITEM_MASTER
--------------------------------------------------
Drop view CAOADMIN.V_ITEM_MASTER;

Create view CAOADMIN.V_ITEM_MASTER as select * from CAOADMIN.T_ITEM_MASTER where current date between BEGIN_DATE and END_DATE;

--------------------------------------------------
-- Create Table CAOADMIN.T_CUSTOMER_MASTER
--------------------------------------------------
Drop table CAOADMIN.T_CUSTOMER_MASTER;

Create table CAOADMIN.T_CUSTOMER_MASTER (
    BEGIN_DATE                     DATE                NOT NULL    ,
    END_DATE                       DATE                NOT NULL    ,
    CUSTOMER_NBR_STND              INTEGER             NOT NULL    ,
    SERVICING_DIVISION             VARCHAR(3)          NOT NULL    ,
    CUST_CORPORATION               INTEGER                         ,
    CUSTOMER_NBR_EXTERNAL          VARCHAR(50)                     ,
    STATUS_CD                      VARCHAR(1)                      ,
    NAME                           VARCHAR(30)                     ,
    ADDRESS1                       VARCHAR(30)                     ,
    ADDRESS2                       VARCHAR(30)                     ,
    STATE                          VARCHAR(20)                     ,
    ZIP_CD                         VARCHAR(9)                      ,
    TELEPHONE                      VARCHAR(30)                     ,
    MANAGER                        VARCHAR(30)                     ,
    CREATE_DATE                    DATE                            ,
    INACTIVE_DATE                  DATE                            ,
    PROCESS_TIMESTAMP              TIMESTAMP                       ,
    PROCESS_TYPE                   CHAR(1)                         ) 
;
--Comment on Column CRMADMIN.T_WHSE_CUST.ARDA_FLG  is 'ARDA FLAG - Y OR N';
--Comment on Column CRMADMIN.T_WHSE_CUST.ARDA_TYPE is 'MW ONLY';

--------------------------------------------------
-- Create View CAOADMIN.V_CUSTOMER_MASTER
--------------------------------------------------
Drop view CAOADMIN.V_CUSTOMER_MASTER;

Create view CAOADMIN.V_CUSTOMER_MASTER as select * from CAOADMIN.T_CUSTOMER_MASTER where current date between BEGIN_DATE and END_DATE;

--------------------------------------------------
-- Create Table CAOADMIN.T_CUST_ITEM_PARMS
--------------------------------------------------
Drop table CAOADMIN.T_CUST_ITEM_PARMS;

Create table CAOADMIN.T_CUST_ITEM_PARMS (
    BEGIN_DATE                     DATE                NOT NULL    ,
    END_DATE                       DATE                NOT NULL    ,
    CUSTOMER_NBR_STND              INTEGER             NOT NULL    ,
    ORDER_CODE                     VARCHAR(16)         NOT NULL    ,
    ITEM_NBR_HS                    VARCHAR(7)          NOT NULL    ,
    TARGET_INVENTORY               INTEGER        With Default 0   ,
    SHELF_FACINGS                  INTEGER        With Default 0   ,
    SHELF_DEPTH                    INTEGER        With Default 0   ,
    SHELF_HEIGHT                   INTEGER        With Default 0   ,
    PROCESS_TIMESTAMP              TIMESTAMP                       ,
    PROCESS_TYPE                   CHAR(1)                         ) 
;

--------------------------------------------------
-- Create Table CAOADMIN.T_POS_TRANSACTIONS
--------------------------------------------------
Drop table CAOADMIN.T_POS_TRANSACTIONS;

Create table CAOADMIN.T_POS_TRANSACTIONS (
    TRAN_DATE_KEY                  DATE                NOT NULL    ,  -- business transaction date
    RECEIVE_DATE_KEY               DATE                NOT NULL    ,  -- data received date
    CUSTOMER_NBR_STND              INTEGER             NOT NULL    ,
    ORDER_CODE                     VARCHAR(16)         NOT NULL    ,  -- root-lv combination for future ordering 
    ITEM_NBR_HS                    VARCHAR(16)         NOT NULL    ,  
    UPC_UNIT                       VARCHAR(15)         NOT NULL    ,
    PACK                           INTEGER          With Default -1,  -- attribute only -1 means no pack value at time of processing
    RANDOM_WEIGHT                  DOUBLE           With Default 0 ,
    TRXN_SALE_QTY                  INTEGER          With Default 0 ,
    TRXN_SALE_AMT                  DECIMAL(13,2)    With Default 0 ,
    PROCESS_TIMESTAMP              TIMESTAMP                       ,
    PROCESS_TYPE                   CHAR(1)                         )
;

--------------------------------------------------
-- Create Table CAOADMIN.T_SHIP_TRANSACTIONS
--------------------------------------------------
Drop table CAOADMIN.T_SHIP_TRANSACTIONS;

Create table CAOADMIN.T_SHIP_TRANSACTIONS (
    TRAN_DATE_KEY                  DATE                NOT NULL    ,
    RECEIVE_DATE_KEY               DATE                NOT NULL    ,  -- data received date
    CUSTOMER_NBR_STND              INTEGER             NOT NULL    ,
    ORDER_CODE                     VARCHAR(16)         NOT NULL    ,  -- root-lv combination for future ordering 
    ITEM_NBR_HS                    VARCHAR(16)         NOT NULL    ,  
    UPC_UNIT                       VARCHAR(15)         NOT NULL    ,
    PACK                           INTEGER          With Default -1,  -- attribute only -1 means no pack value at time of processing
    RANDOM_WEIGHT                  DOUBLE           With Default 0 ,
    TRXN_SALE_QTY                  INTEGER          With Default 0 ,
    TRXN_SALE_AMT                  DECIMAL(13,2)    With Default 0 ,
    PROCESS_TIMESTAMP              TIMESTAMP                       ,
    PROCESS_TYPE                   CHAR(1)                         )
;



--------------------------------------------------
-- Create Table CAOADMIN.T_INVENTORY_TRANS   -- WANE TO PARTITION ON XX_DATE
--------------------------------------------------
Drop table CAOADMIN.T_INVENTORY_TRANS;

Create table CAOADMIN.T_INVENTORY_TRANS (
    TRANSACTION_DATE               DATE                NOT NULL    ,  --daily snapshot of inventory 
    TRANSACTION_TYPE               VARCHAR(25)         NOT NULL    ,  -- starting inventory, sales, damages, receipts, orders, etc.
    CUSTOMER_NBR_STND              INTEGER             NOT NULL    ,
    ORDER_CODE                     VARCHAR(16)         NOT NULL    ,
    ITEM_NBR_HS                    VARCHAR(7)          NOT NULL    ,
    QUANTITY                       INTEGER         With Default 0  ,
    PROCESS_TIMESTAMP              TIMESTAMP                       ,
    PROCESS_TYPE                   CHAR(1)                         ) 
;


--------------------------------------------------
-- Create Table CAOADMIN.T_ORDER   
--------------------------------------------------

DROP TABLE CAOADMIN.T_ORDER;

CREATE TABLE CAOADMIN.T_ORDER (
    ID	                         VARCHAR(150)	    NOT NULL    ,
    FACILITY_ID	                VARCHAR(3)      	NOT NULL    ,
    CUSTOMER_NBR_STND              INTEGER             NOT NULL    ,
    GROUP_ID	                   BIGINT	          NOT NULL    ,
    DEPARTMENT_ID	              VARCHAR(50)	     NOT NULL    ,
    ORDER_TIME                     TIMESTAMP	       NOT NULL    ,
    DELIVERY_REQUEST_TIME          TIMESTAMP           NOT NULL    ,
    ORDER_TYPE                     VARCHAR(150)        NOT NULL    ,
    SUBMITTED_BY                   VARCHAR(250)        NOT NULL    ,
    SUBMITTED_ON                   TIMESTAMP           NOT NULL    ,
    HANDHELD_ID                    INTEGER             NOT NULL    ,
    STATUS                         CHARACTER(1)                    ,
    REFERENCE_NBR                  VARCHAR(150)                    , -- order reference number that must be carried throug to the shipments information
    PROCESS_TIMESTAMP              TIMESTAMP                       ,
    PROCESS_TYPE                   CHAR(1)                         ) 
;

--ALTER TABLE COMMON.T_ORDER
--  ADD CONSTRAINT PK_T_ORDER PRIMARY KEY
--    (ID);

--ALTER TABLE COMMON.T_ORDER
--  DATA CAPTURE NONE
--  PCTFREE 0
--  LOCKSIZE ROW
--  APPEND OFF
--  NOT VOLATILE;

--------------------------------------------------
-- Create Table CAOADMIN.T_ORDER_ITEM
--------------------------------------------------

DROP TABLE CAOADMIN.T_ORDER_ITEM;

CREATE TABLE CAOADMIN.T_ORDER_ITEM (
    ID                             BIGINT	          NOT NULL	
      GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1, CACHE 20,
         NO MINVALUE, NO MAXVALUE, NO CYCLE, NO ORDER),
    ORDER_CODE                     VARCHAR(16)         NOT NULL    ,
    ITEM_NBR_HS                    VARCHAR(7)          NOT NULL    ,
    QUANTITY                       INTEGER         With Default 0  ,
    ORDER_ID	                   VARCHAR(150)	    NOT NULL    ,
    PROCESS_TIMESTAMP              TIMESTAMP                       ,
    PROCESS_TYPE                   CHAR(1)                         ) 
;


--ALTER TABLE COMMON.T_ORDER_ITEM
--  ADD CONSTRAINT PK_T_ORDER_ITEM PRIMARY KEY
--    (ID);

--ALTER TABLE COMMON.T_ORDER_ITEM
--  ADD CONSTRAINT FK_T_ORDER_ITEM_DG_ORDER FOREIGN KEY
--    (ORDER_ID)
--  REFERENCES COMMON.DG_ORDER
--    (ID)
--    ON DELETE NO ACTION
--    ON UPDATE NO ACTION
--    ENFORCED
--    ENABLE QUERY OPTIMIZATION;
--
COMMIT;
