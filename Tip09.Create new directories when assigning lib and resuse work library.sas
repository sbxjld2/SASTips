/* Tip09. Create libname AND create directories - works on Windows and Unix/Linux */

%let wpath=%sysfunc(pathname(work));
options dlcreatedir; 

libname newlib "&wpath\SecTempLib";
libname newlib list;
