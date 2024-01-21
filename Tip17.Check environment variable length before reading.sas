/* Tip 17. Use envlen() fucnton before using sysget() to avoid error messages - only SAS Support is using that function */

data path;
 input name $20.;
 vlen=envlen(strip(name));
 if vlen > 0 then value=sysget(strip(name));
 putlog vlen= name= value=@ ;
 if vlen > 200 then putlog '(....)' @;
 putlog;
cards;
PATH
UNKNOWNENV_VAR
USERNAME
;
run;
