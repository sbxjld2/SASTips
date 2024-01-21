/* Tip15. when using proc http, HTTP return code is available in datastep */

%macro checkit(url);
 filename in url "&url" ;
  data _NULL_;
  infile in status=status;
  input;
  if (_N_=1 ) then do;
    if status>=200 and status < 299 then putlog 'NOTE: HTTP ' status= ;
    else putlog 'WARNING: HTTP ' status= ;
  end;
  run;
  filename in clear;
%mend;

options mprint;              
%checkit(http://www.sas.com);
%checkit(http://www.sas.com/UNKNOWN----NO-NO-NO.html);