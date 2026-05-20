     *** BEGIN pums905p.sas PROGRAM ***;
OPTIONS OBS=MAX ;
LIBNAME SASLIB '/ftp/pub/tmp/98110313-4' ;
     *** BEGIN DATA STEP ***;
DATA WORK.pums905p (COMPRESS=YES) ;
     *** READ DATA FROM STANDARD INPUT ***;
INFILE STDIN LRECL= 231  MISSOVER;
     *** BEGIN LENGTH SATEMENT ***;
LENGTH
	APOWST	$	1
	POWSTATE	$	2
	PWGT1	$	4
	SERIALNO	$	7
;
     *** END   LENGTH STATEMENT ***;
     *** BEGIN LABEL STATEMENT ***;
LABEL
	APOWST = 'Place of Work State Allocation Flag'
	POWSTATE = 'Place of Work State Appendix I '
	PWGT1 = 'Pers. Wgt'
	SERIALNO = 'Hu/gq Pers. Serial No. Unique Within Sta'
;
     *** END   LABEL STATEMENT ***;
     *** BEGIN KEEP STATEMENT ***;
KEEP
	APOWST
	POWSTATE
	PWGT1
	SERIALNO
;
     *** END   KEEP STATEMENT ***;
     *** BEGIN INPUT STATEMENT ***;
INPUT
	APOWST	$	212 - 212
	POWSTATE	$	95 - 96
	PWGT1	$	18 - 21
	SERIALNO	$	2 - 8
;
     *** END   INPUT STATEMENT ***;
RUN;
     *** END   DATA STEP ***;
     *** BEGIN FORMAT STATEMENT ***;
PROC FORMAT LIBRARY=WORK ; 
     *** VARIBLE='APOWST' FORMAT='$V1F' ***;
VALUE $V1F
'0' = 'No'
'1' = 'Yes'
;
     *** VARIBLE='POWSTATE' FORMAT='$V2F' ***;
VALUE $V2F
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
/**/
* BOX PROGRAM Version 001.00: (BOX.SAS) ;
* CREATED BY: Edward Cary Bean, Jr. ;
*             U.S. Bureau of Census, Office of the Director ;
* DATE:       July 25, 1990 ;
* REVISED:    Sept. 18, 1990 ;
* PURPOSE:    Converts SAS Data Sets and Format Catalogs into ;
*             a single ASCII text file for use by other languages, ;
*             software applications, databases, etc. ;
* NOTE:       The output of this program is both data and information ;
*             defining the data. It is CRITICAL that this program and ;
*             the ASCII text files it creates not be modified by ;
*             program users. If modifications or corrections are required ;
*             contact the program creator so that the master program ;
*             can be modified or corrected. The key to proper data ;
*             transfer is CONSISTENCY! ;
* USER INPUT: 1) Directory Location of Source Data Set ;
*             2) Data Set Name (1 part name) ;
*             3) Format Catalog Directory ;
*             4) Output Directory Location ;
*             5) Number of Observations/Records to output ;
* PGM OUTPUT: 1) An ASCII text "BOX" File (.box) Including:     ;
*                a) Notes b) All SAS Data Definitions c) Data ;
*             2) An ASCII text User Documentation file (.doc) ;
*******************************************************************;
*******************************;
* MACRO INITIALIZATION SECTION ;
*******************************;
%LET BOXVERS=1.01;* The BOX Program Version Variable ;
%LET BOXTYPE=1;   * The BOX Type Variable ;
%LET ANS=;        * Temporary Variable for users answers ;
%LET RECLEN=;     * Length of the DATA record (not all records) ;
%LET MEMNAME=;    * Data Set Name ;
%LET MEMLABEL=;   * Data set Label ;
%LET CRDATE=;     * Data Set Creation Date ;
%LET MODATE=;     * Data Set Modification Date ;
%LET ENGINE=;     * SAS Data Engine Type ;
%LET OUTSPEC=;    * Output File Specification ;
%LET DOCFILE=;    * User Documentation File ;
%LET INPDIR=;     * Input Directory ;
%LET FMTDIR=;     * Formats Directory ;
%LET INPSET=;     * Input Data Set Name ;
%LET OUTDIR=;     * Output Directory (for .box and .doc files) ;
%LET REQOBS=;     * Number of Observations Requested from Data Set ;
**********************;
%LET INPDIR=/ftp/pub/tmp/98110313-4/;
%LET FMTDIR=/ftp/pub/tmp/98110313-4/;
%LET OUTDIR=/ftp/pub/tmp/98110313-4/;
%LET BOXVERS=1.01;
%LET BOXTYPE=1;
%LET BOXNAME=pums905p;
%LET BOXLAB=pums905p;
%LET NUMDS=1;
%LET DSNAM1=pums905p;
%LET ROBS1=MAX;
run;
**********************;
**********************;
* END TEMP SECTION   *;
**********************;
*********************;
* BEGIN MAIN PROGRAM ;
*********************;
options obs=MAX SOURCE2;
%LET OUTSPEC=&OUTDIR&BOXNAME%STR(.box); * OUTPUT FILE SPECIFICATION ;
%PUT &OUTSPEC;
*libname INPLIB "&INPDIR";      * INPUT LIBRARY ;
libname LIBRARY "&FMTDIR";     * FORMAT LIBRARY ;
filename BOXFILE "&OUTSPEC";   * OUTPUT FILE ;
run;
*************************************;
* OUTPUT the '00' RECORDS to the BOX ;
*************************************;
data _NULL_; * Output Notes to BOXFILE ;
file BOXFILE;
put
  @1 '00'
  @3 "** BOXFILE Version &BOXVERS -- Data & Data Decription  File **"
;
put
  @1 '00'
  @3 '** Created by E. Cary Bean, Jr. - Bureau of Census - DIR **'
;
put
  @1 '00'
  @3 '** WARNING - DO NOT ALTER THE FORMAT/CONTENT OF BOX FILES (OR DATA WILL NOT TRANSFER PROPERLY)! **'
;
put
  @1 '00'
  @3 '--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0----+----1----+----2----+';
;
run;
****************************************************;
* OUTPUT the '01' (General Info) RECORDS to the BOX ;
****************************************************;
data _NULL_;         * Output General Information to BOXFILE ;
format NUMDS 3.BOXVERS 6.2 BOXTYPE 3. BOXNAME $20. BOXLAB $100.;
NUMDS=&NUMDS; * Get MacroVariable values into Data Step Variables ;
BOXVERS=&BOXVERS;
BOXTYPE=&BOXTYPE;
BOXNAME="&BOXNAME";
BOXLAB="&BOXLAB";
file BOXFILE MOD;        * WRITE TO  ;
if _N_=1 then
put
  @1     '01'
  @3     BOXVERS    z6.2
  @9     BOXTYPE    z3.
  @12    NUMDS      z3.
  @15    BOXNAME    $CHAR20.
  @35    BOXLAB     $CHAR100.
  @135   'SAS'
;
run;
****************************************************************;
*** MACNO1 - BEGIN MACRO THAT REPEATS FOR MULTIPLE DATA SETS ***;
****************************************************************;
%MACRO MACNO1(ARGV1);
%****************************************************************;
%DO MCCNT=1 %TO &ARGV1 ;
filename TMPCODE1 "&BOXNAME&MCCNT..tmp" ;
%let FMTLNK=&FMTDIR&&DSNAM&MCCNT%STR(.fmt);  %* VARIABLE to FORMAT LINK FILE ;
%put &FMTLNK;
%***************************************************************;
%*** Generate a CONTENTS Data Set from  Data Set to be BOXED ***;
%***************************************************************;
%*LET XXX=DSNAM;
%*LET TMPNAM=&&&XXX&MCCNT;RUN;
%*PUT NAME=WORK.&&DSNAM&MCCNT;
%LET INS=WORK.&&DSNAM&MCCNT;RUN;
proc contents noprint data=&INS out=TS1_&MCCNT;
%******* UNCOMMENT NEXT LINE FOR PRODUCTION *****;
%include "&FMTLNK"; %* FORMAT DUMMY CONTENTS Set using FORMAT LINK File ;
run;
%********** SORT CONTENTS Data Set for processing ;
proc sort data=TS1_&MCCNT out=STS1_&MCCNT;
  by varnum;
run;
%***************************************************************************;
%* Read the Sorted CONTENTS Data Set and generate PGM to "put" Data Records ;
%***************************************************************************;
data TS2_&MCCNT;    %* Generate program TEMPCODE1.. to be included later ;
retain CURPOS 6; %* set initial cursor position to 6 and retain ;
format
  MCCNT      z3.
  RECLEN     12.
  NOBS       14.
  MEMNAME    $CHAR8.
  MEMLABEL   $CHAR40.
  CRDATE     DATETIME16.
  MODATE     DATETIME16.
  IDXCOUNT   10.
  ENGINE     $CHAR8.
  VARNUM     6.
  NAME       $CHAR8.
  TYPE       1.
  TEXTPOS    6.
  TEXTLEN    4.
  TEXTDEC    2.
  FORMAT     $CHAR8.
  LABEL      $CHAR40.
;
set STS1_&MCCNT end=EOD;  %* Read From ;
MARKER=CURPOS+LENGTH ; %* Marker is a position indicator ;
MCCNT=&MCCNT;
file TMPCODE1;         %* Write To ;
if _N_=1 then          %* If first observation ;
        do;
                put "PUT";
                put "@1  '99'"; %* RECORD TYPE 99 - Data ;
                put "@3  '" MCCNT +(-1) "'";
        end;
if TYPE=2 then        %* If the Variables Type is 2 (Character) ;
        do;
                PUT "@(" MARKER "- length( " NAME ") ) " NAME ;
                TEXTPOS=CURPOS;
                TEXTLEN=LENGTH;
                TEXTDEC=0;
                CURPOS=MARKER;
        end;
if TYPE=1 and ( INFORML^=0 or INFORMD^=0 ) then   %* If Type is numeric and is INFORMATTED ;
        do;
                PUT "@" CURPOS NAME INFORML +(-1) "." INFORMD ;
                TEXTPOS=CURPOS;
                TEXTLEN=INFORML;
                TEXTDEC=INFORMD;
                CURPOS=CURPOS+INFORML;
        end;
else if TYPE=1 and ( FORMATL^=0 or FORMATD^=0 ) then    %* Else If Type is numeric and is FORMATTED ;
        do;
                PUT "@" CURPOS NAME FORMATL +(-1) "." FORMATD ;
                TEXTPOS=CURPOS;
                TEXTLEN=FORMATL;
                TEXTDEC=FORMATD;
                CURPOS=CURPOS+FORMATL;
        end;
else if TYPE=1 then %* Else If Type is 2 and not Formatted ;
        do;
                PUT "@" CURPOS NAME "BEST12." ;
                TEXTPOS=CURPOS;
                TEXTLEN=12;
                TEXTDEC=0;
                CURPOS=CURPOS+12;
        end;
RECLEN=TEXTPOS+TEXTLEN-1; %* Calculate Record Length ;
if EOD then %* If no more OBS save values for later use in MacroVars ;
        do;
           put ";" ;
           call symput("RECL_&MCCNT",put(RECLEN,z12.)); %* Set Macro Variables ;
           call symput("NOBS_&MCCNT",put(NOBS,z14.));
           call symput("MEMN_&MCCNT",MEMNAME);
           call symput("MEML_&MCCNT",MEMLABEL);
           call symput("CRDT_&MCCNT",put(CRDATE,DATETIME16.));
           call symput("MODT_&MCCNT",put(MODATE,DATETIME16.));
           call symput("ENGN_&MCCNT",put(ENGINE,$CHAR8.));
        end;
%GLOBAL RECL_&MCCNT;
%GLOBAL NOBS_&MCCNT;
%GLOBAL MEMN_&MCCNT;
%GLOBAL MEML_&MCCNT;
%GLOBAL CRDT_&MCCNT;
%GLOBAL MODT_&MCCNT;
%GLOBAL ENGN_&MCCNT;
run;
%put &&RECL_&MCCNT;
run;
%END; %* END OF MACRO DO LOOP;
%**************************************************************;
%MEND MACNO1;
**************************************************************;
*** MACNO1 - END MACRO THAT REPEATS FOR MULTIPLE DATA SETS ***;
**************************************************************;
RUN;
%MACNO1(&NUMDS);RUN;
**************************************************************;
*** MACNO2 - START OF MACRO NUMBER 2                       ***;
**************************************************************;
%MACRO MACNO2(ARGV1);
%**************************************************************************;
%DO MCCNT=1 %TO &ARGV1 ;
%******************************************;
%*** OUTPUT the '02' Records to the BOX ***;
%******************************************;
data _NULL_;
format RECL 14. NOBS 14. MEMN $20. MEML $100. ENGN $20. MCCNT 3. ;
MCCNT=&MCCNT;
ROBS=&&ROBS&MCCNT;
RECL=&&RECL_&MCCNT;
NOBS=&&NOBS_&MCCNT;
MEMN="&&MEMN_&MCCNT";
MEML="&&MEML_&MCCNT";
CRDT="&&CRDT_&MCCNT";
MODT="&&MODT_&MCCNT";
ENGN="&&ENGN_&MCCNT";
file BOXFILE MOD;
put
  @1     '02'
  @3     MCCNT Z3.
  @6     MEMN  $CHAR20.
  @26    RECL  Z14.
  @40    NOBS  Z14.
  @54    ROBS  Z14.
  @68    CRDT  $CHAR16.
  @84    MODT  $CHAR16.
  @110   ENGN  $CHAR20.
  @130   MEML  $CHAR100.
;
run;

%**************************************************************************;
%* 1. OUTPUT the '03' (Variable Info) RECORDS to the BOX                   ;
%* 2. Create a Data Set of Formats Required from full catalog for this box ;
%**************************************************************************;
data TMS_&MCCNT (keep=FMTNAME); %* (2) Output Variable/Contents information to BOXFILE ;
format MCCNT 3.;
MCCNT=&MCCNT;
set TS2_&MCCNT;
FMTNAME=FORMAT;
file BOXFILE mod;
put        %* (1) Put Positions / Lengths for '03' Records ;
        @1      '03'
        @3      MCCNT   Z3.
        @6      VARNUM  Z6.
        @12     NAME    $CHAR20.
        @52     TYPE    Z1.
        @53     TEXTPOS Z6.
        @59     TEXTLEN Z4.
        @63     TEXTDEC Z2.
        @65     FORMAT  $CHAR20.
        @88     LABEL   $CHAR100.
;
if FORMAT ^= "" then output; %* (2) List only Variables that are formatted ;
run;
%******************************************;
%* Dump the Format Catalog into a Data Set ;
%******************************************;
%****** modefied 2.25.91 proc format library=LIBRARY cntlout=TS3_&MCCNT;
proc format library=WORK cntlout=TS3_&MCCNT;
run;
%***************************************************************;
%* Sort the Data Set containing the LIST of formatted Variables ;
%***************************************************************;
proc sort data=TMS_&MCCNT out=STMS_&MCCNT;
by FMTNAME;
run;
%**********************************************************************;
%* Change the appearance of the "Format Name" in the Contents Data Set ;
%* to match that carried by the Formats Data Set                       ;
%**********************************************************************;
data TS4_&MCCNT;
set TS3_&MCCNT;
if TYPE="C" then FMTNAME="$"||FMTNAME;
format DSETNAME $20.;
DSETNAME="&&MEMN_&MCCNT";
DSETNUM=&MCCNT;
run;
%****************************;
%* Sort the Formats Data Set ;
%****************************;
proc sort data=TS4_&MCCNT out=STS4_&MCCNT;
by FMTNAME;
run;
%********************************************************************************;
%* Merge the list of formats required to list of formats removing excess formats ;
%********************************************************************************;
data TS5_&MCCNT;
merge STMS_&MCCNT (IN=INA) STS4_&MCCNT (IN=INB);
by FMTNAME;
if INA = 1 & INB = 1 then output;
run;
%*****************************************************;
%* OUTPUT the '04' (Category Info) RECORDS to the BOX ;
%*****************************************************;
data _NULL_; %* Output Variable Format information to BOXFILE ;
format
  FMTNAME     $CHAR8.
  START       $CHAR16.
  END         $CHAR16.
  LABEL       $CHAR40.
  MIN         3.
  MAX         3.
%* DEFAULT wont format... reserve word ;
  FUZZ        16.
  PREFIX      $CHAR2.
  MULT        BEST12.
  FILL        $CHAR1.
  NOEDIT      3.
  TYPE        $CHAR1.
  SEXCL       $CHAR1.
  EEXCL       $CHAR1.
  HLO         $CHAR3.
  MCCNT       3.
;
set TS5_&MCCNT;        %* Read From ;
MCCNT=&MCCNT;
file BOXFILE mod;      %* Write To ;
if _N_ = 1 then
do;
  put
  @1 '00'
  @3 '--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0----+----1----+----2----+';
end;
put
  @1 '04'
  @3    MCCNT       z3.
  @6    FMTNAME     $CHAR20.
  @26   START       $CHAR20.
  @46   END         $CHAR20.
  @66   LABEL       $CHAR100.
  @166  MIN         z3.
  @169  MAX         z3.
  @172  DEFAULT     z3.
  @175  FUZZ        z16.
  @191  PREFIX      $CHAR2.
  @193  MULT        BEST12.
  @205  FILL        $CHAR1.
  @206  NOEDIT      z3.
  @209  TYPE        $CHAR1.
  @210  SEXCL       $CHAR1.
  @211  EEXCL       $CHAR1.
  @212  HLO         $CHAR3.
;
run;
%END;
%MEND MACNO2;
RUN;
%MACNO2(&NUMDS);RUN;
%********************************;
%*** MACNO3 - START OF MACNO3 ***;
%********************************;
%MACRO MACNO3(ARGV1);
%DO MCCNT=1 %TO &ARGV1;
%*****************************************************;
%* OUTPUT the '99' (DATA) RECORDS to the BOX          ;
%*****************************************************;
options obs=&&ROBS&MCCNT SOURCE2;  %* Set OBS option per user spec ;
filename TMPCODE1 "&BOXNAME&MCCNT..tmp" ;
%LET INSN=WORK.&&DSNAM&MCCNT; RUN;
data _NULL_ ;***********;
file BOXFILE mod ;
  put
  @1 '00'
  @3 '--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0----+----1----+----2----+' ;
run;*********;
data _NULL_ ;
format MCCNT 3. ;
MCCNT=&MCCNT ;
set &INSN ;
file BOXFILE mod LRECL=&&RECL_&MCCNT;
%include TMPCODE1 ;
run;
%END;
%MEND MACNO3;
RUN;
%********************************;
%*** MACNO3 - END OF MACNO3 ***;
%********************************;
%MACNO3(&NUMDS);RUN;
***********************************;
***********************************;
*** BEGIN DOCUMENTATION SECTION ***;
***********************************;
***********************************;
options obs=max;run;  *** Reset OBS option ***;
%LET DOCFILE=&OUTDIR&BOXNAME%STR(.doc);RUN;
%PUT &DOCFILE;RUN;
*******************************************************;
* Prepare options and file specifications for printing ;
*******************************************************;
options pagesize=86 linesize=132 pageno=1;
run;
DATA _NULL_;
file "&DOCFILE";
put;put;
put @10 '*** "BOX" FILE USER DOCUMENTATION ***';
put @10 "    ===== ==== ==== =============    ";
put;
put @10 "   -------       THE BOX";
put @10 "  /      /";
put @10 " /      / |      DEFINITIONS";
put @10 " -------  |      &";
put @10 " |     |  |      DATA";
put @10 " |     |  /";
put @10 " |     | /       (Maintained Together for Maximum Security";
put @10 " -------          and Minimum Redundant Programming!)";
put;put;put;
put @10 "BOX File Name:..................... &BOXNAME (.box)";
put @10 "BOX File Label:.................... &BOXLAB";
put @10 "Source Data Set Directory:......... &INPDIR";
put @10 "Source Data Format Directory:...... &FMTDIR";
put @10 "Number of Source Data Sets......... &NUMDS";
put @10 "BOX File Output Directory:......... &OUTDIR";
put @10 "BOX Program Version Number......... &BOXVERS";
put @10 "BOX Type Number.................... &BOXTYPE";
put;put;
RUN;
%********************************;
%*** MACNO4 - START OF MACNO4 ***;
%********************************;
%MACRO MACNO4(ARGV1);
%DO MCCNT=1 %TO &ARGV1;
%********************************************************;
%* Sort Variable information for output to documentation ;
%********************************************************;
proc sort data=TS2_&MCCNT out=STS2_&MCCNT;
by textpos;
run;
DATA _NULL_;
file "&DOCFILE" MOD ;
put @15 "Source Data Set #&MCCNT NAME: &&DSNAM&MCCNT";
put @15 "  Logical Data Record Length:........ &&RECL_&MCCNT";
put @15 "  Number of Observations Requested:.. &&ROBS&MCCNT";
put @15 "  Data Set Label:.................... &&MEML_&MCCNT";
put @15 "  Total Observations in Data Set:.... &&NOBS_&MCCNT";
put @15 "  Date Data Set Created:............. &&CRDT_&MCCNT";
put @15 "  Date Data Set Last Modified:....... &&MODT_&MCCNT";
put @15 "  SAS Engine for Data Set:........... &&ENGN_&MCCNT";
put;
run;
%END;
%MEND MACNO4;
RUN;
%********************************;
%*** MACNO4 - END OF MACNO4 ***;
%********************************;
%MACNO4(&NUMDS);RUN;
%********************************;
%*** MACNO5 - START OF MACNO5 ***;
%********************************;
%MACRO MACNO5(ARGV1);
%DO MCCNT=1 %TO &ARGV1;
proc printto print="&DOCFILE" ;
run;
proc print data=STS2_&MCCNT noobs label split='*';
var
  MCCNT MEMNAME VARNUM NAME TYPE FORMAT LABEL TEXTPOS TEXTLEN TEXTDEC
;
format MCCNT 3.;
title '*** "BOX" FILE USER DOCUMENTATION ***';
title2 "VARIABLE INFORMATION";
title3 "BOX File: '&BOXNAME'";
title4 "Data Set Number: &MCCNT";
title5 "Data Set Name: '&&DSNAM&MCCNT'";
label MCCNT='Data*Set*No.:';
label MEMNAME='Data Set Name:';
label VARNUM='Var.*No.:';
label NAME='Variable Name:';
label TYPE='Variable*Type:';
label FORMAT='Format*Name:';
label LABEL='Variable Label:';
label TEXTPOS='Start*Position:';
label TEXTLEN='Length:';
label TEXTDEC='Dec.*Places:';
run;
proc print data=TS5_&MCCNT noobs label split='*';
var
  DSETNUM DSETNAME FMTNAME START END TYPE LABEL PREFIX MULT FILL
;
title '*** "BOX" FILE USER DOCUMENTATION ***';
title2 "VARIABLE CATEGORY/FORMAT INFORMATION";
title3 "BOX File: '&BOXNAME'";
title4 "Data Set Number: &MCCNT";
title5 "Data Set Name: '&&DSNAM&MCCNT'";
format DSETNAME $8. ;
label DSETNUM='Data*Set*No.:';
label DSETNAME='Data Set Name:';
label FMTNAME='Format*Name:';
label START='Start*Value:';
label END='End*Value:';
label TYPE='Format*Type:';
label LABEL='Format Label:';
label PREFIX='Prefix*Char.:';
label MULT='Mult*Val.:';
label FILL='Fill*Char.:';
run;
proc printto print=print ;
run;
%END;
%MEND MACNO5;
RUN;
%********************************;
%*** MACNO5 - END OF MACNO5 ***;
%********************************;
%MACNO5(&NUMDS);RUN;

* Reset Options Used for Printing User Documentation ;
options pagesize=20 linesize=77;
proc printto print=print;
run;
title1; * Clear titles *;
***************************;
* Clean up Macro Variables ;
***************************;
%LET BOXVERS=;    * The Program Version Variable ;
%LET BOXTYPE=;    * The BOX Type Variable ;
%LET ANS=;        * Temporary Variable for users answers ;
%LET RECLEN=;     * Length of the DATA record (not all records) ;
%LET MEMNAME=;    * Data Set Name ;
%LET MEMLABEL=;   * Data set Label ;
%LET CRDATE=;     * Data Set Creation Date ;
%LET MODATE=;     * Data Set Modification Date ;
%LET ENGINE=;     * SAS Data Engine Type ;
%LET OUTSPEC=;    * Output File Specification ;
%LET DOCFILE=;    * User Documentation File ;
%LET INPDIR=;     * Input Directory ;
%LET FMTDIR=;     * Formats Directory ;
%LET INPSET=;     * Input Data Set Name ;
%LET OUTDIR=;     * Output Directory (for .box and .doc files) ;
%LET REQOBS=;     * Number of Observations Requested from Data Set ;
run;
* END of BOX PROGRAM ;
