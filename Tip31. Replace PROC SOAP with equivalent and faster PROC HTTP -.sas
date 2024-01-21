
/* Top 31. in SAS 9.4, PROC SOAP when reading large amount of data is a memory hog 
           It may require 4GB RAM just to retrieve 1K records 
           PROC HTTP (written in C) is much faster, and does not use any RAM 
           remove extra XML elements from the response */

%let myroot=%sysfunc(pathname(work));

proc javainfo;
run;

proc options option=(config jreoptions);
run;

 
options ls=120;
FILENAME request temp;
FILENAME response "&myroot\response.xml";
FILENAME respNEW "&myroot\newresponse.xml";

data _null_;
  file request;
  input;
  put _infile_;
  datalines4;
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
   <soapenv:Header/>
   <soapenv:Body>
      <tem:Add>
         <tem:intA>7</tem:intA>
         <tem:intB>44</tem:intB>
      </tem:Add>
   </soapenv:Body>
</soapenv:Envelope>
;;;;

proc soap
  debug="&sysuserid..txt"
  in=request
  out=response
  url="http://www.dneonline.com/calculator.asmx"
  /*  proxyhost="localhost"*/
  /*        proxyport=8888*/
  soapaction="http://tempuri.org/Add";
run;
/* DEBUG FILE 
data _null_;
infile "&sysuserid..txt";
input;
put _infile_;
run; 
*/
%put FROM SOAP:;

data _null_;
  infile response;
  input;
  put _infile_;
run;



/* proc http equivalent */
proc http
  in=request
  out=response
  method="post"
  url="http://www.dneonline.com/calculator.asmx"
  /*  proxyhost="localhost"*/
  /*      proxyport=8888*/
  ;
  headers "Content-Type"="text/xml; charset=UTF-8"
    "SOAPAction"="http://tempuri.org/Add";
run;

%put FROM HTTP:;

data _null_;
  infile response;
  input;
  put _infile_;
run;

/* remove soap elements */
data NULL_;
  infile response dlm='<';
  file RESPNEW;
  input xmlelement : $32000. @@;
  if xmlelement =: 'AddResult>' then put '<' xmlelement;
run;
proc print; run;
