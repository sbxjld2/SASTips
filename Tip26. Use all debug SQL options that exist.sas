/* Tip26. PROC sql has more options than what appears in sas doc - but not all are documented 
          Usually only TS uses those */

options ls=200 nocenter;
data classl;
set sashelp.class;
 drop height height;
data classr;
set sashelp.class;
 drop age sex;

proc sql _AGGR _ASGN _DFR _EXPR _PJD _PLAN _RSLV _SUBQ 
 _TRACE _TRAN _UTIL VERBOSE _TREE _SQP _METHOD _PUPD ; 
 
proc sql _ASGN_PLAN _RSLV _TRACE _TRAN  VERBOSE _TREE  _METHOD  ; 
 
create table aaaa as 
select a.sex,mean(a.age) as meanage format=commax6. length=3 
  from classl a, classr b 
 where sex='F'
   and a.name=b.name
 group by sex;

 
proc sql
 _trace  _method; 
create table aaaa as 
select a.sex,mean(a.age) as meanage format=commax6. length=3 
  from classl a, classr b 
 where sex='F'
   and a.name=b.name
 group by a.sex;
