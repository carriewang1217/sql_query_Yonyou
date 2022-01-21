select t.xh,
       t.xm_code,
       
       t.xm_name,
      
       length(t.xm_name),
       length(trim(t.xm_name))
  from npcs_ods_fb_0824 t
 where t.yw_type = 'CZ_YS_CZ_YG_0008'
   and t.year = '2019'
 order by t.xh ;
 --
 update npcs_ods_fb_0824 t set t.xm_name= '一、一般公共服务支出' where t.xm_name='一、一般公共服务' where t.yw_type = 'CZ_YS_CZ_YG_0008';
 ---
 update npcs_ods_fb_0824 t
   set t.xm_code =
       (select chr_code
          from npcs_dim_expfunc n
         where n.chr_name =
          trim(replace(replace(substr(trim( t.xm_name),instr(trim

( t.xm_name),'、')+1,length(trim ( t.xm_name))),' ',''),'　',''))
          and  length( n.chr_code)=3  and n.chr_code like '2%'
           and t.date_year = n.year and length(t.xm_name)= length(trim(t.xm_name)) )
  where t.yw_type = 'CZ_YS_CZ_YG_0008';
  ---
  declare 
v_num number(10);
v_code varchar2(60);
v_m number(10);
begin 
 select 
max(xh) into  v_num 
--t.xm_code_zc,t.xm_name_zc,t.xh, t.hold21,t.hold22
from  npcs_ods_fb_0824 t
where   t.yw_type = 'CZ_YS_CZ_YG_0008' and t.date_year='2019'   and length( ltrim(t.xm_name)) >= length(t.xm_name)-4;
 -- dbms_output.put_line(v_num);
 for v_n in 1 ..v_num 
   loop
  select  t.xm_code into v_code from npcs_ods_fb_0824 t where t.yw_type = 'CZ_YS_CZ_YG_0008' and t.date_year='2019' and t.xh=v_n;
   --  dbms_output.put_line(v_code);
   --  dbms_output.put_line(v_n); 
    update npcs_ods_fb_0824 t
        set t.xm_code = v_code 
       where xh=v_n+1  and xm_code is null and  yw_type = 'CZ_YS_CZ_YG_0008' and t.date_year='2019' ;
     end loop;
     end; 
-----
update npcs_ods_fb_0824 t set t.xm_code=(select chr_code from npcs_dim_expfunc e where e.year='2019' and length (e.chr_code)=5  and 
substr(e.chr_code,1,3)= t.xm_code and e.chr_name= trim(t.xm_name)  )
where      length( ltrim(t.xm_name)) = length(t.xm_name)-4  and  t.date_year='2019' and  yw_type = 'CZ_YS_CZ_YG_0008' ;
;
----
declare 
v_num number(10);
v_code varchar2(60);
v_m number(10);
begin 
 select 
max(xh) into  v_num 
--t.xm_code_zc,t.xm_name_zc,t.xh, t.hold21,t.hold22
from  npcs_ods_fb_0824 t
where   t.yw_type = 'CZ_YS_CZ_YG_0008' and t.date_year='2019'  ;
 -- dbms_output.put_line(v_num);
 for v_n in 1 ..v_num 
   loop
    
  select  t.xm_code into v_code from npcs_ods_fb_0824 t where t.yw_type = 'CZ_YS_CZ_YG_0008' and t.date_year='2019' and t.xh=v_n;
   --  dbms_output.put_line(v_code);
   --  dbms_output.put_line(v_n); 
    update npcs_ods_fb_0824 t
        set t.xm_code = v_code 
       where xh=v_n+1  and  yw_type = 'CZ_YS_CZ_YG_0008' and t.date_year='2019' and length( ltrim(t.xm_name)) = length(t.xm_name)-6 ;
     end loop;
     end; 
----
update npcs_ods_fb_0824 t set t.xm_code=(select chr_code from npcs_dim_expfunc e where e.year='2019' and length (e.chr_code)=7  and 
substr(e.chr_code,1,5)= t.xm_code and e.chr_name= trim(t.xm_name)  )
where  length( ltrim(t.xm_name)) = length(t.xm_name)-6    and t.date_year='2019' and  yw_type = 'CZ_YS_CZ_YG_0008' ;
