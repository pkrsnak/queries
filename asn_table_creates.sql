--------------------------------------------------
-- Create Table EDIADMIN.T_EDI_ASN_ITEM
--------------------------------------------------
--drop table EDIADMIN.T_EDI_ASN_ITEM;
Create Table EDIADMIN.T_EDI_ASN_ITEM (
    SENDER_ID                      VARCHAR(15)         NOT NULL    ,
    LOAD_DTTM                      TIMESTAMP           NOT NULL    ,
    SHIPMENT_ID                    VARCHAR(30)         NOT NULL    ,
    HIER_LVL_CD                    INTEGER             NOT NULL    ,
    PARENT_HIER_LVL_CD             INTEGER             NOT NULL    ,
    UPC_CD                         VARCHAR(48)                     ,
    UPC_CONSUMER_CD                VARCHAR(48)                     ,
    BUYER_ITM_NBR                  VARCHAR(48)                     ,
    ITEM_NBR                       CHAR(6)                         ,
    ITEM_NBR_HS                    CHAR(7)                         ,
    LOT_NBR                        VARCHAR(48)                     ,
    UNITS_SHIPPED_QTY              INTEGER                         ,
    UNITS_SHIP_UOM_CD              VARCHAR(2)                      ,
    PACK_QTY                       INTEGER                         ,
    SIZE_MSR                       INTEGER                         ,
    SIZE_UOM_CD                    VARCHAR(2)                      ,
    ITEM_DESC                      VARCHAR(80)                     ,
    SHELF_LIFE_EXP_DATE            DATE                            ,
    EXPIRATION_DATE                DATE                            ,
    PRODUCTION_DATE                DATE                            ,
    PACKED_DATE                    DATE                            ,
    COUNTRY_ORIGIN_NM              VARCHAR(60)                     ,
    LOAD_BATCH_ID                  INTEGER                         ,
    ORIGIN_ID                      VARCHAR(10)                     ) 
in USER04K   ;

--------------------------------------------------
-- Grant Authorities for EDIADMIN.T_EDI_ASN_ITEM
--------------------------------------------------
grant control on EDIADMIN.T_EDI_ASN_ITEM to user ETL;
grant select,update,insert,delete,alter,references on EDIADMIN.T_EDI_ASN_ITEM to user ETL with grant option;
grant select,update,insert,delete on EDIADMIN.T_EDI_ASN_ITEM to user SIUSER;
grant select on EDIADMIN.T_EDI_ASN_ITEM to user WEB;


--------------------------------------------------
-- Create Primary Key T_EDI_ASN_ITEM_PK
--------------------------------------------------
--alter table EDIADMIN.T_EDI_ASN_ITEM drop primary key;
alter table EDIADMIN.T_EDI_ASN_ITEM 
	add constraint T_EDI_ASN_ITEM_PK 
	Primary Key (SENDER_ID, LOAD_DTTM, SHIPMENT_ID, HIER_LVL_CD, PARENT_HIER_LVL_CD);

--------------------------------------------------
-- Create Table EDIADMIN.T_EDI_ASN_ORGANIZATION
--------------------------------------------------
--drop table EDIADMIN.T_EDI_ASN_ORGANIZATION;
Create Table EDIADMIN.T_EDI_ASN_ORGANIZATION (
    SENDER_ID                      CHAR(15)            NOT NULL    ,
    LOAD_DTTM                      TIMESTAMP           NOT NULL    ,
    SHIPMENT_ID                    CHAR(30)            NOT NULL    ,
    ORGANIZATION_CD                CHAR(2)             NOT NULL    ,
    ORGANIZATION_NM                CHAR(60)                        ,
    DUNS_NBR                       CHAR(80)                        ,
    FACILITYID                     CHAR(3)                         ,
    LINE_1_ADDR                    CHAR(55)                        ,
    LINE_2_ADDR                    CHAR(55)                        ,
    CITY_NM                        CHAR(30)                        ,
    STATE_CD                       CHAR(2)                         ,
    POSTAL_CD                      CHAR(15)                        ,
    COUNTRY_CD                     CHAR(3)                         ,
    LOAD_BATCH_ID                  INTEGER                         ,
    ORIGIN_ID                      CHAR(10)                        ) 
in USER04K   ;

--------------------------------------------------
-- Grant Authorities for EDIADMIN.T_EDI_ASN_ORGANIZATION
--------------------------------------------------
grant control on EDIADMIN.T_EDI_ASN_ORGANIZATION to user ETL;
grant select,update,insert,delete,alter,references on EDIADMIN.T_EDI_ASN_ORGANIZATION to user ETL with grant option;
grant select,update,insert,delete on EDIADMIN.T_EDI_ASN_ORGANIZATION to user SIUSER;
grant select on EDIADMIN.T_EDI_ASN_ORGANIZATION to user WEB;


--------------------------------------------------
-- Create Primary Key T_EDI_ASN_ORGANIZATION_PK
--------------------------------------------------
--alter table EDIADMIN.T_EDI_ASN_ORGANIZATION drop primary key;
alter table EDIADMIN.T_EDI_ASN_ORGANIZATION 
	add constraint T_EDI_ASN_ORGANIZATION_PK 
	Primary Key (SENDER_ID, LOAD_DTTM, SHIPMENT_ID, ORGANIZATION_CD);

--------------------------------------------------
-- Create Table EDIADMIN.T_EDI_ASN_PACK
--------------------------------------------------
--drop table EDIADMIN.T_EDI_ASN_PACK;
Create Table EDIADMIN.T_EDI_ASN_PACK (
    SENDER_ID                      VARCHAR(15)         NOT NULL    ,
    LOAD_DTTM                      TIMESTAMP           NOT NULL    ,
    SHIPMENT_ID                    VARCHAR(30)         NOT NULL    ,
    HIER_LVL_CD                    INTEGER             NOT NULL    ,
    PARENT_HIER_LVL_CD             INTEGER             NOT NULL    ,
    UPC_CD                         VARCHAR(48)                     ,
    BUYER_ITM_NBR                  VARCHAR(48)                     ,
    ITEM_NBR                       CHAR(6)                         ,
    ITEM_NBR_HS                    CHAR(7)                         ,
    UNITS_SHIPPED_QTY              INTEGER                         ,
    UNITS_SHIP_UOM_CD              CHAR(2)                         ,
    UPC_CONTAINER_CD               VARCHAR(48)                     ,
    EXPIRATION_DATE                DATE                            ,
    SHELF_LIFE_EXP_DATE            DATE                            ,
    PRODUCTION_DATE                DATE                            ,
    COUNTRY_ORIGIN_NM              VARCHAR(60)                     ,
    LOAD_BATCH_ID                  INTEGER                         ,
    ORIGIN_ID                      VARCHAR(10)                     ) 
in USER04K   ;

--------------------------------------------------
-- Grant Authorities for EDIADMIN.T_EDI_ASN_PACK
--------------------------------------------------
grant control on EDIADMIN.T_EDI_ASN_PACK to user ETL;
grant select,update,insert,delete,alter,references on EDIADMIN.T_EDI_ASN_PACK to user ETL with grant option;
grant select,update,insert,delete on EDIADMIN.T_EDI_ASN_PACK to user SIUSER;
grant select on EDIADMIN.T_EDI_ASN_PACK to user WEB;


--------------------------------------------------
-- Create Primary Key T_EDI_ASN_PACK_PK
--------------------------------------------------
--alter table EDIADMIN.T_EDI_ASN_PACK drop primary key;
alter table EDIADMIN.T_EDI_ASN_PACK 
	add constraint T_EDI_ASN_PACK_PK 
	Primary Key (SENDER_ID, LOAD_DTTM, SHIPMENT_ID, HIER_LVL_CD, PARENT_HIER_LVL_CD);

--------------------------------------------------
-- Create Table EDIADMIN.T_EDI_ASN_PALLET
--------------------------------------------------
--drop table EDIADMIN.T_EDI_ASN_PALLET;
Create Table EDIADMIN.T_EDI_ASN_PALLET (
    SENDER_ID                      VARCHAR(15)         NOT NULL    ,
    LOAD_DTTM                      TIMESTAMP           NOT NULL    ,
    SHIPMENT_ID                    VARCHAR(30)         NOT NULL    ,
    PO_NBR                         VARCHAR(22)         NOT NULL    ,
    HIER_LVL_CD                    INTEGER             NOT NULL    ,
    SER_SHIP_CONTNR_CD             VARCHAR(48)                     ,
    PALLET_TYPE_CD                 VARCHAR(2)                      ,
    PALLET_TIERS_QTY               VARCHAR(3)                      ,
    PALLET_BLOCKS_QTY              VARCHAR(3)                      ,
    HEIGHT_MSR                     DECIMAL(8)                      ,
    HEIGHT_UOM_CD                  CHAR(2)                         ,
    GROSS_WEIGHT_MSR               DECIMAL(9)                      ,
    GROSS_WGHT_UOM_CD              CHAR(2)                         ,
    GROSS_VOL_MSR                  DECIMAL(9)                      ,
    GROSS_VOL_UOM_CD               CHAR(2)                         ,
    PALLET_EXCHANGE_CD             CHAR(1)                         ,
    LOAD_BATCH_ID                  INTEGER                         ,
    ORIGIN_ID                      VARCHAR(10)                     ) 
in USER04K   ;

--------------------------------------------------
-- Grant Authorities for EDIADMIN.T_EDI_ASN_PALLET
--------------------------------------------------
grant control on EDIADMIN.T_EDI_ASN_PALLET to user ETL;
grant select,update,insert,delete,alter,references on EDIADMIN.T_EDI_ASN_PALLET to user ETL with grant option;
grant select,update,insert,delete on EDIADMIN.T_EDI_ASN_PALLET to user SIUSER;
grant select on EDIADMIN.T_EDI_ASN_PALLET to user WEB;


--------------------------------------------------
-- Create Primary Key T_EDI_ASN_PALLET_PK
--------------------------------------------------
--alter table EDIADMIN.T_EDI_ASN_PALLET drop primary key;
alter table EDIADMIN.T_EDI_ASN_PALLET 
	add constraint T_EDI_ASN_PALLET_PK 
	Primary Key (SENDER_ID, LOAD_DTTM, SHIPMENT_ID, PO_NBR, HIER_LVL_CD);

--------------------------------------------------
-- Create Table EDIADMIN.T_EDI_ASN_PURCHASE_ORDER
--------------------------------------------------
drop table EDIADMIN.T_EDI_ASN_PURCHASE_ORDER;
Create Table EDIADMIN.T_EDI_ASN_PURCHASE_ORDER (
    SENDER_ID                      VARCHAR(15)         NOT NULL    ,
    LOAD_DTTM                      TIMESTAMP           NOT NULL    ,
    SHIPMENT_ID                    VARCHAR(30)         NOT NULL    ,
    PO_NBR                         VARCHAR(22)         NOT NULL    ,
    PO_NBR_HS                      VARCHAR(22)                     ,
    PO_DATE                        DATE                            ,
    PACKAGING_CD                   VARCHAR(5)                      ,
    LADING_QTY                     VARCHAR(7)                      ,
    LOAD_BATCH_ID                  INTEGER                         ,
    ORIGIN_ID                      VARCHAR(10)                     ) 
in USER04K   ;

--------------------------------------------------
-- Grant Authorities for EDIADMIN.T_EDI_ASN_PURCHASE_ORDER
--------------------------------------------------
grant control on EDIADMIN.T_EDI_ASN_PURCHASE_ORDER to user ETL;
grant select,update,insert,delete,alter,references on EDIADMIN.T_EDI_ASN_PURCHASE_ORDER to user ETL with grant option;
grant select,update,insert,delete on EDIADMIN.T_EDI_ASN_PURCHASE_ORDER to user SIUSER;
grant select on EDIADMIN.T_EDI_ASN_PURCHASE_ORDER to user WEB;


--------------------------------------------------
-- Create Primary Key T_EDI_ASN_PURCHASE_ORDER_PK
--------------------------------------------------
--alter table EDIADMIN.T_EDI_ASN_PURCHASE_ORDER drop primary key;
alter table EDIADMIN.T_EDI_ASN_PURCHASE_ORDER 
	add constraint T_EDI_ASN_PURCHASE_ORDER_PK 
	Primary Key (SENDER_ID, LOAD_DTTM, SHIPMENT_ID, PO_NBR);

--------------------------------------------------
-- Create Table EDIADMIN.T_EDI_ASN_SHIPMENT
--------------------------------------------------
drop table EDIADMIN.T_EDI_ASN_SHIPMENT;
Create Table EDIADMIN.T_EDI_ASN_SHIPMENT (
    SENDER_ID                      CHAR(15)            NOT NULL    ,
    LOAD_DTTM                      TIMESTAMP           NOT NULL    ,
    SHIPMENT_ID                    CHAR(30)            NOT NULL    ,
    EDI_CNTRL_NBR                  CHAR(18)                        ,
    PURPOSE_CD                     CHAR(2)                         ,
    ADV_SHIP_NOTC_DATE             DATE                            ,
    ADV_SHIP_NOTC_TIME             DECIMAL(8)                      ,
    GROSS_VOL_MSR                  DECIMAL(9)                      ,
    GROSS_VOL_UOM_CD               CHAR(2)                         ,
    PACKAGING_CD                   CHAR(5)                         ,
    GROSS_WEIGHT_MSR               DECIMAL(10)                     ,
    GROSS_WGHT_UOM_CD              CHAR(2)                         ,
    ROUTING_SEQ_CD                 CHAR(2)                         ,
    STND_CARR_ALPHA_CD             CHAR(80)                        ,
    TRANS_METHOD_CD                CHAR(2)                         ,
    ROUTING_DESC                   CHAR(35)                        ,
    STATUS_CD                      CHAR(2)                         ,
    EQUIP_DESC_CD                  CHAR(2)                         ,
    EQUIP_INITIAL_CD               CHAR(4)                         ,
    EQUIP_ID                       CHAR(10)                        ,
    BILL_LADING_NBR                VARCHAR(50)                     ,
    CARRIER_REF_NM                 CHAR(50)                        ,
    SEAL_NBR                       CHAR(50)                        ,
    SHIP_DATE                      DATE                            ,
    EST_DELIVERY_DATE              DATE                            ,
    SCHD_DELIVERY_DATE             DATE                            ,
    PAY_METHOD_CD                  CHAR(2)                         ,
    LOAD_BATCH_ID                  INTEGER                         ,
    ORIGIN_ID                      CHAR(10)                        ) 
in USER04K   ;

--------------------------------------------------
-- Grant Authorities for EDIADMIN.T_EDI_ASN_SHIPMENT
--------------------------------------------------
grant control on EDIADMIN.T_EDI_ASN_SHIPMENT to user ETL;
grant select,update,insert,delete,alter,references on EDIADMIN.T_EDI_ASN_SHIPMENT to user ETL with grant option;
grant select,update,insert,delete on EDIADMIN.T_EDI_ASN_SHIPMENT to user SIUSER;
grant select on EDIADMIN.T_EDI_ASN_SHIPMENT to user WEB;