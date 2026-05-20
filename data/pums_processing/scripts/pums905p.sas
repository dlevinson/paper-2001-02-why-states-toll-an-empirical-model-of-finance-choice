     *** BEGIN pums905p.sas PROGRAM ***;
OPTIONS OBS=MAX ;
LIBNAME SASLIB '/ftp/pub/tmp/98111315-2' ;
     *** BEGIN DATA STEP ***;
DATA WORK.pums905p (COMPRESS=YES) ;
     *** READ DATA FROM STANDARD INPUT ***;
INFILE STDIN LRECL= 231  MISSOVER;
     *** BEGIN LENGTH SATEMENT ***;
LENGTH
	POWSTATE	$	2
	PWGT1	$	4
	SERIALNO	$	7
;
     *** END   LENGTH STATEMENT ***;
     *** BEGIN LABEL STATEMENT ***;
LABEL
	POWSTATE = 'Place of Work State Appendix I '
	PWGT1 = 'Pers. Wgt'
	SERIALNO = 'Hu/gq Pers. Serial No. Unique Within Sta'
;
     *** END   LABEL STATEMENT ***;
     *** BEGIN KEEP STATEMENT ***;
KEEP
	POWSTATE
	PWGT1
	SERIALNO
;
     *** END   KEEP STATEMENT ***;
     *** BEGIN INPUT STATEMENT ***;
INPUT
	POWSTATE	$	95 - 96
	PWGT1	$	18 - 21
	SERIALNO	$	2 - 8
;
     *** END   INPUT STATEMENT ***;
RUN;
     *** END   DATA STEP ***;
     *** BEGIN FORMAT STATEMENT ***;
PROC FORMAT LIBRARY=WORK ; 
     *** VARIBLE='POWSTATE' FORMAT='$V1F' ***;
VALUE $V1F
'00' = 'N/a Not a Worker Not in the Labor Force,'
'01' = 'Alabama'
'02' = 'Alaska'
'04' = 'Arizona'
'05' = 'Arkansas'
'06' = 'California'
'08' = 'Colorado'
'09' = 'Connecticut'
'10' = 'Delaware'
'11' = 'District of Columbia'
'12' = 'Florida'
'13' = 'Georgia'
'15' = 'Hawaii'
'16' = 'Idaho'
'17' = 'Illinois'
'18' = 'Indiana'
'19' = 'Iowa'
'20' = 'Kansas'
'21' = 'Kentucky'
'22' = 'Louisiana'
'23' = 'Maine'
'24' = 'Maryland'
'25' = 'Massachusetts'
'26' = 'Michigan'
'27' = 'Minnesota'
'28' = 'Mississippi'
'29' = 'Missouri'
'30' = 'Montana'
'31' = 'Nebraska'
'32' = 'Nevada'
'33' = 'New Hampshire'
'34' = 'New Jersey'
'35' = 'New Mexico'
'36' = 'New York'
'37' = 'North Carolina'
'38' = 'North Dakota'
'39' = 'Ohio'
'40' = 'Oklahoma'
'41' = 'Oregon'
'42' = 'Pennsylvania'
'44' = 'Rhode Island'
'45' = 'South Carolina'
'46' = 'South Dakota'
'47' = 'Tennessee'
'48' = 'Texas'
'49' = 'Utah'
'50' = 'Vermont'
'51' = 'Virginia'
'53' = 'Washington'
'54' = 'West Virginia'
'55' = 'Wisconsin'
'56' = 'Wyoming'
'98' = 'Abroad'
'99' = 'State Not Identified'
;
RUN;
     *** END   FORMAT STATEMENT ***;
*****************************************************************************;
*****************************************************************************;
*** PROGRAM:    Dsas2ing.sas (based on sas2ing.sas) ;
*** VERSION:    1.01;
*** CREATED BY: Edward Cary Bean, Jr. ;
***             U.S. Bureau of Census, Office of the Director ;
*** DATE:       April 22, 1991;
*** REVISED:    April 22, 1991;
*** PURPOSE:    Convert a SAS Data Set to Standard Database I/0 Format;
***             E.G. Data <TAB> Data <TAB> Data ...., with a load pgm ;
***             (This is also a UNIX standard format);
*** NOTE:       ;
***             ;
***             ;
***             ;
***             ;
***             ;
***             ;
*** USER INPUT: ;
***             ;
*****************************************************************************;
*****************************************************************************;
*** The Next Lines Can be Modified for Proper Execution ******************;
%LET INDS=WORK.pums905p;RUN;          * Input SAS Data Set Name (w/wo lib);
%LET OUTF=/ftp/pub/tmp/98111315-2/pums905p.dat;RUN;          * Output Data File Name;
%LET OUTP=/ftp/pub/tmp/98111315-2/pums905p.sql;RUN;          * Output SQL Program Name (Automatic);
%LET TMPF=/ftp/pub/tmp/98111315-2/pums905p.tp1;RUN;          * Temporary Program file
*%LET MAXR=MAX;RUN;                 * Max No. of Data Records to Output;
%LET MAXRL=10000;RUN;              * Max Length of Output Data Records;
%LET MAXV=300;RUN;                 * Max No. of Variables to Output;
*****************************************************************************;
*****************************************************************************;
proc contents data=&INDS out=cont1 noprint;run;
* proc print data=cont1;run;
filename TMP1 "&TMPF";
filename OUT1 "&OUTF";
filename OUT2 "&OUTP";
**********************************************************************;
*** START OUTPUT CODE GENERATION DATA STEP ;
**********************************************************************;
options obs=&MAXV SOURCE2;
data _NULL_;
set cont1 end=EOD;
file TMP1;
if _N_=1 then
do;
  put "PUT";
  put "  " NAME @ ;
end;
else
do;
  put "+(-1) '09'X";
  put "  " NAME @ ;
end;
if EOD then
do;
put;
put ";";
*call symput("NUMOBS",_N_);
end;
run;
*%put &NUMOBS;
**********************************************************************;
*** END   OUTPUT CODE GENERATION DATA STEP ;
**********************************************************************;
**********************************************************************;
*** START OUTPUT PRODUCTION DATA STEP ;
**********************************************************************;
OPTIONS OBS=MAX;
data _NULL_;
set &INDS end=EOD ;
file OUT1 LRECL=&MAXRL ;
%include TMP1;
if EOD then
do;
* Next line required so ingres reads a blank line before EOF;
  put;
end;
run;
**********************************************************************;
*** END   OUTPUT PRODUCTION DATA STEP ;
**********************************************************************;
**********************************************************************;
*** START LOAD PROGRAM GENERATION DATA STEP #1 ;
**********************************************************************;
OPTIONS OBS=&MAXV;
data _NULL_;
set cont1 NOBS=NUMOBS end=EOD;
file OUT2;
if _N_=1 then
do;
  put "/*******************************************************************/";
  put "/* The following program was generated by the 'SAS2ING.SAS' pgm.   */";
  put "/* This is an Structured Querey Language (SQL) program.            */";
  put "/* The purpose of this program is to create and load an SQL table  */";
  put "/*   from an ASCII (TEXT) file (also generated by 'SAS2DB.SAS'     */";
  put "/* This code is generated specifically for Ingres SQL,             */";
  put "/* NOTE: Some modifications may be required.                       */";
  put "/*       Lines containing '\p' and '\g' are for Ingres Batch.      */";
  put "/*       f8 storage class is used for all numeric variables.       */";
  put "/*       (Storage clases can be modified if space is a problem)    */";
  put "/*       [location=()] and [from 'filename'] statements can change */";
  put "/*******************************************************************/";
  put ;
  put "set autocommit on \g";
  put ;
  put "create table " MEMNAME "(";
end;
if TYPE = 2 then
do;
  put "     " NAME "char(" LENGTH +(-1) ") with null" @;
  if _N_ ^= NUMOBS AND _N_ ^= &MAXV then
  do;
    put ",";
  end;
end;
if TYPE = 1 then
do;
  put "     " NAME "f8 with null" @;
  if _N_ ^= NUMOBS AND _N_ ^= &MAXV then
  do;
    put ",";
  end;
end;
if EOD then
do;
put;
put ")";
put "with duplicates,";
put "location = (ii_database)";
put "\p\g";
put ;
end;
run;
**********************************************************************;
*** END   LOAD PROGRAM GENERATION DATA STEP #1;
**********************************************************************;
**********************************************************************;
*** START LOAD PROGRAM GENERATION DATA STEP #2 ;
**********************************************************************;
data _NULL_;
set cont1 NOBS=NUMOBS end=EOD;
file OUT2 MOD;
if _N_=1 then
do;
  put "copy " MEMNAME "(";
end;
  if _N_ ^= NUMOBS AND _N_ ^= &MAXV then
  do;
    put "     " NAME +(-1) "= c0tab with null ('NULL'),";
  end;
  else if _N_ = NUMOBS OR _N_ = &MAXV then
  do;
    put "     " NAME +(-1) "= c0nl with null ('NULL'),";
  end;
if EOD then
do;
put "     nl= d1)";
put "from '&OUTF'";
put "\p\g";
end;
run;
**********************************************************************;
*** END   LOAD PROGRAM GENERATION DATA STEP #2;
**********************************************************************;
OPTIONS OBS=MAX;
