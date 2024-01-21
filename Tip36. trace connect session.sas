/* Tip36. Used by Technical Support only ...
          trace a sas connect session for any (un-)usual problem */
		  
%let tcpdfile=tcpdebug.%sysfunc(getoption(tcpdebug)).%sysfunc(date(),YYMMDDN8.).%sysfunc(time(),6.);
options tcpdebug=62 tcpdebugfile="c:\temp\&tcpdfile..dat";
   
options remote=<host>   ;
signon user=<user> password=<password>;

        