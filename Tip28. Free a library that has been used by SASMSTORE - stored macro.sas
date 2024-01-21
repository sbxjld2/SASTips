/* Tip28. When using sasmstore to generate a compiled macro, 
          it is usually not possible to free the library where that macro is stored, 
		  unless you change sasmstore location first, and submit a dummy macro */
		  
LIBNAME T1 'c:\temp';

   OPTIONS MSTORED SASMSTORE=T1;
   %MACRO TEST1 / STORE; 
    DATA;
    RUN;
   %MEND;
    
   OPTIONS SASMSTORE=SASUSER;
   /* T1 lib cannot be freed */
   /* the key is here : submit a dummy macro to free the previous library 
      – If you do not do that, lib T1 is locked*/
   %MACRO DUMMY / STORE; 
   %MEND;       

   LIBNAME T1 CLEAR;
