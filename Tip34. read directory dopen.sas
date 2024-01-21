/* Tip34. Read a list of files in a directory without ls nor DIR commands, 
          using sas builtin functions to list files in a directory 
          this example list all log files found in \temp\*.log */
      
%let dir=\temp;
%let pattern=.log;
filename dir "&dir";

options ps=40;
data dir;
  length  fname $ 100 ;
  _did=dopen('dir');
  _memcount=dnum(_did);
  do _i=1 to _memcount;
    fname=dread(_did,_i);
    _fid=mopen(_did,fname);    
    if _fid > 0 then do;
       if index(lowcase(fname),"&pattern") then do;
         do _j=1 to foptnum(_fid);
           name=foptname(_fid, _j);
           value=finfo(_fid, name);
           output;
         end;
       end;
    end;    
    _rc=fclose(_fid);   
  end;
  _rc=dclose(_did);
  drop _:; /* temp variables are prefixed with _ : dropped in 1 statement */
run;


proc transpose data=dir out=dir2;
 id name;
 by notsorted fname;
 var  value;
 run;
proc print data=dir2 (drop=_name_);
run;
