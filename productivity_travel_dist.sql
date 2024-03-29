SELECT   case WHSE_ID 
     when 90 then 90 
     when 80 then 80 
     else DC_ID 
end as DC_ID,
         REC_TYPE,
         REC_ID,
         WHSE_ID,
         ASSG_ID,
         ASSOC_ID,
         RPT_DT,
         SECT_ID,
         WUST_ID,
         LAST_SECT_ID,
         JBCD_ID,
         JCTY_ID,
         JCFN_ID,
         JCSF_ID,
         CASE_QTY,
         LIC_PLT_ID,
         ORDER_TYPE_ID,
         PAL_QTY,
         UPD_COUNT,
         ASGT_ID,
         RPTG_ID,
         CUST_ID,
         PROD_WGT,
         PROD_CUB,
         SPMD_ID,
         PO_ID,
         START_DTIM,
         COMPLETE_DTIM,
         STD_TIM,
         DELAY_TIM,
         SUSPEND_TIM,
         WALK_TIM,
         HRS_WORKED,
         TRX_CREATE_DTIM,
         TRX_CHANGE_DTIM,
         CREATE_DTIM,
         CHANGE_DTIM,
         FISC_WEEK,
         FISC_PD,
         FISC_QTR,
         FISC_YEAR,
         LHTY_ID,
         PROD_ID,
         FROM_LOC_ID,
         TO_LOC_ID,
         UNIT_SHIP_CSE,
         INVC_ID,
         XD_SHP_CARRIER,
         XD_SHP_TRAILER,
         ROUTE_ID,
         STOP_ID,
         LOAD_SIDE,
         LOAD_POS,
         LD_POS_ID,
         LD_MSG_ID
FROM     EDL.EXE_CONSL.NFCLBRTRX
WHERE    RPT_DT between '2022-03-27' and '2022-04-23'
;



select DC_ID, count(*) from (
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_01.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_02.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_03.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_08.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_15.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_16.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_40.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_54.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_58.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_61.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_66.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_67.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_71.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_85.SPN_DFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_86.SPN_DFKAUD
union all
Select 70 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_01.SPN_DFKAUD
union all
Select 69 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_02.SPN_DFKAUD
union all
Select case WHSE_ID when 90 then 90 else 29 end as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_05.SPN_DFKAUD
union all
Select 27 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_06.SPN_DFKAUD
union all
Select case WHSE_ID when 80 then 80 else 33 end as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_07.SPN_DFKAUD
union all
Select 38 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_09.SPN_DFKAUD
union all
Select 39 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HFKAUD_ID, OTHD_ID, TRIP_ID, FROM_LOC, TO_LOC, CASE_HNDL_QTY, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_09.SPN_DFKAUD
)
group by DC_ID
;

select DC_ID, count(*) from (

Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_01.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_02.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_03.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_08.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_15.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_16.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_40.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_54.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_58.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_61.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_66.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_67.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_71.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_85.SPN_HFKAUD
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_FD_86.SPN_HFKAUD
union all
Select 70 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_MDV_01.SPN_HFKAUD
union all
Select 69 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_MDV_02.SPN_HFKAUD
union all
Select case WHSE_ID when 90 then 90 else 29 end as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_MDV_05.SPN_HFKAUD
union all
Select 27 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_MDV_06.SPN_HFKAUD
union all
Select case WHSE_ID when 80 then 80 else 33 end as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_MDV_07.SPN_HFKAUD
union all
Select 38 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_MDV_08.SPN_HFKAUD
union all
Select 39 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HFKAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, WGT, CUBE, CASE_HNDL_TIME, HNDL_STCK_TIME, INS_RETR_TIME, VERT_TRAVEL_DIST, VERT_TRAVEL_TIME, HORIZ_TRAVEL_DIST, HORIZ_TRAVEL_TIME, PASS_CORNER_TIME, MISC_TIME, TOT_TIME, ACCUM_TIME from EDL.EXE_MDV_09.SPN_HFKAUD
)
group by DC_ID
;

select DC_ID, count(*) from (
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_01.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_02.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_03.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_08.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_15.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_16.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_40.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_54.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_58.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_61.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_66.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_67.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_71.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_85.spn_dseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_FD_86.spn_dseaud
union all
Select 70 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_01.spn_dseaud
union all
Select 69 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_02.spn_dseaud
union all
Select case WHSE_ID when 90 then 90 else 29 end as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_05.spn_dseaud
union all
Select 27 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_06.spn_dseaud
union all
Select case WHSE_ID when 80 then 80 else 33 end as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_07.spn_dseaud
union all
Select 38 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_09.spn_dseaud
union all
Select 39 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, SEQ_ID, HSEAUD_ID, SELD_ID, SEL_LOC, PROD_ID, RTL_QTY, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, ERR_CDE from EDL.EXE_MDV_09.spn_dseaud
)
group by DC_ID
;


select DC_ID, count(*) from (

Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_01.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_02.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_03.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_08.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_15.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_16.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_40.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_54.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_58.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_61.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_66.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_67.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_71.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_85.spn_hseaud
union all
Select DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_FD_86.spn_hseaud
union all
Select 70 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_MDV_01.spn_hseaud
union all
Select 69 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_MDV_02.spn_hseaud
union all
Select case WHSE_ID when 90 then 90 else 29 end as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_MDV_05.spn_hseaud
union all
Select 27 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_MDV_06.spn_hseaud
union all
Select case WHSE_ID when 80 then 80 else 33 end as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_MDV_07.spn_hseaud
union all
Select 38 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_MDV_08.spn_hseaud
union all
Select 39 as DC_ID, FIN_DC_ID, WHSE_ID, ASSG_ID, HSEAUD_ID, LOAD_DTIM, RPT_DT, CHANGE_DTIM, STD_TIM, WGT, CUBE, FIRST_CASE_TIME, ADDL_CASE_TIME, OUT_TRAVEL_DIST, OUT_TRAVEL_TIME, IN_TRAVEL_DIST, IN_TRAVEL_TIME, PASSAGE_TIME, CORNER_TIME, TOT_TIME, ACCUM_TIME, FATIGUE_ADJ_TIME, WEIGHT_ADJ_TIME, DELAY_ADJ_TIME from EDL.EXE_MDV_09.spn_hseaud
)
group by DC_ID
;