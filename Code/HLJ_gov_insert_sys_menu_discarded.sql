insert into sys_menu sm(sm.menu_id,sm.menu_code,sm.menu_name ,sm.enabled,sm.level_num,IS_LEAF,parent_id)  
select  module_id,'687'||rn,tab_name,'1','66','1',menu_id from (
select ROWNUM rn, substr(sys_guid(), 0, 6) record_id,
       (select MODULE_NAME from npcs_module where MODULE_id = b.module_id) MODULE_NAME,
       case
         when (select count(*)
                 from npcs_module a
                where a.module_id = b.module_id) != 0 then
          (select a.module_url
             from npcs_module a
            where a.module_id = b.module_id)
         else
          ('/pages/npcs/pdfReport/showPdfReport.html?ttt=1' || chr(38) ||
          'id=' || b.module_id)
       end module_url,
       b.module_id MODULE_ID,
       b.remark,
       b.menu_id,
       b.sort_num,
       b.year,
       b.mtb_id,
       b.show_month,
       b.money_unit MONEY_UNIT_ID,
       b.rg_code,
       (select g.unit_name
          from npcs_dim_money_unit g
         where g.money_unit_id = b.money_unit) MONEY_UNIT,
       (select g.is_current
          from npcs_dim_money_unit g
         where g.money_unit_id = b.money_unit) IS_CURRENT,
       (select distinct y.ywtype_name
          from npcs_yw_type y
         where y.ywtype_code = b.yw_type) YW_TYPE,
       (select distinct y.xm_code
          from npcs_yw_type y
         where y.ywtype_code = b.yw_type) xm_code,
       b.YW_TYPE YW_TYPE_ID,
       b.specification_id,
       b.tab_name,
       (select p.specification_name
          from npcs_specification p
         where p.specification_id = b.specification_id) as SPECIFICATION_NAME,
       b.version_code,
       (select c.version_name
          from npcs_sys_version c
         where c.version_code = b.version_code) version_name
  from npcs_menu_tal_module b
 where 
       exists (select 1 from sys_menu st where st.menu_id = b.menu_id)
   and b.rg_code = '00')
