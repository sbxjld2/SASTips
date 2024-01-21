/*  Tip40. You have a macro library somewhere on GIT. 
           You would like to use it in the sas session you are just using. 
           example with Boemska macros (i.e. %mf_existds) 
           Clone that repos to saswork, then modify sasautos to include the macros in your code
           https://github.com/Boemska/macrocore.git
*/

%let mysasauto=%sysfunc(pathname(WORK))\mysasauto;
%put &mysasauto;

/* Clone  that git reprostory to mysaswork library */
data _null_;
 version = gitfn_version();
 put version=;             
 rc = gitfn_clone("https://github.com/Boemska/macrocore.git/","&mysasauto");
 put rc=;
run;

/* change sasautos to include the just downloaded macros in your session */
options sasautos=("&mysasauto\base" sasautos);

/* use that macro %MF_EXIST() */
%macro testit(data);
  %if %mf_existds(&data) %then %Put NOTE: &data DOES exist;
  %else  %put ERROR: &data DOES NOT exist;
%mend;

%testit(sashelp.class);
%testit(sashelp.doesnotexist);
