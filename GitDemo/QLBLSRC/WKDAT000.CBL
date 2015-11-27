000100000000      *******************************************************************
000200000727      * WKDAT000-COMMUNICATION FILEDS SUB-PROGRAM   ACBDT000  -15/10/87 *
000300000727      *                          104 CHARACTERS                         *
000400000727      * VALIDATES A DATE AND PUTS IT INTO PRINTED FORMAT...             *
000500000727      * IF CYYMMDD=SPACES OR INVALID  -> S/P WORKS WITH DAY'S DATE      *
000600000727      * OTHERWISE                     -> S/P WORKS WITH CYYMMDD         *
000700000000      *******************************************************************
000800000000       01  WKDAT000.
000900000727      ***** DD/MM/YY HH.MM.SS.CC *****  POS=1 LG=20
001000000000           05      WDATE-HEURE-EDT VALUE "01/01/01 01:01:01:01".
001100000727      ***** DATE. FORMAT EDITED DD/MM/YY *****
001200000000            10     WJJMMAA-EDT.
001300000000             15    WJJ-EDT                        PIC X(2).
001400880425             15    FILLER                         PIC X.
001500000000             15    WMM-EDT                        PIC X(2).
001600880425             15    FILLER                         PIC X.
001700000000             15    WAA-EDT                        PIC X(2).
001800880425            10     FILLER                         PIC X.
001900000727      ***** TIME FORMAT EDITED HH.MM.SS.CC *****
002000000000            10     WHHMNSSCC-EDT.
002100000000             15    WHHMNSS-EDT.
002200000000              20   WHHMN-EDT.
002300000000               25  WHH-EDT                        PIC X(2).
002400880425               25  FILLER                         PIC X.
002500000000               25  WMN-EDT                        PIC X(2).
002600880425              20   FILLER                         PIC X.
002700000000              20   WSS-EDT                        PIC X(2).
002800880425             15    FILLER                         PIC X.
002900000000             15    WCC-EDT                        PIC X(2).
003000000727      ***** DD/MM/YY HH.MM.SS *****
003100880425           05      FILLER REDEFINES WDATE-HEURE-EDT.
003200000000            10     WDAT-HEUR-EDT                  PIC X(17).
003300880425            10     FILLER                         PIC X(3).
003400000727      ***** LEAP YEAR=0, ELSE 1,2 OR 3 *****  POS=21 LG=1
003500000000           05      WAN-BISSEX.
003600000000            10     WAN-BISSEX9                    PIC 9 VALUE ZERO.
003700000727      ** NBR DAYS IN WEEK (1=MONDAY TO 7=SUNDAY) ** POS=22 LG=1
003800000000           05      WDAY-IN-WEEK.
003900000000            10     WDAY-IN-WEEK9                  PIC 9 VALUE ZERO.
004000000727      ***** DAY/NB.DAY/MONTH/YEAR NOT IN CODE ***   POS=23 LG=26
004100000000           05      WDATE-CLAIR VALUE "MERCREDI 01 SEPTEMBRE 1901".
004200000000            10     WJOUR                          PIC X(8).
004300880425            10     FILLER                         PIC X.
004400000000            10     WNOJOUR                        PIC X(2).
004500880425            10     FILLER                         PIC X.
004600000000            10     WMOIS-AAAA.
004700000000             15    WMOIS                          PIC X(9).
004800880425             15    FILLER                         PIC X(3).
004900000000             15    WAN                            PIC X(2).
005000000727      ***** YEAR FORMAT YYYY *****
005100880425            10     FILLER REDEFINES WMOIS-AAAA.
005200880425             15    FILLER                         PIC X(10).
005300000000             15    WAAAA.
005400000000              20   WAAAA9                         PIC 9(4).
005500000727      ***** QUANTIEME. FORMAT DDD FOR YEAR *** POS=49 LG=3
005600000000           05      WJJJ.
005700000000            10     WJJJ9                          PIC 9(3) VALUE ZERO.
005800000727      ***** DATE FORM DDMM                    *** POS=52 LG=4
005900000000           05      WJJMM                          PIC X(4) VALUE "JJMM".
006000000727      ***** DATE/TIME. FORMAT YYMMDDHHMNSSCC ***  POS=56 LG=14
006100000000           05      WAAMMJJ-HHMNSSCC VALUE "AAMMJJ01010101".
006200000727      ***** DATE. FORMAT YYMMDD *****
006300000000            10     WAAMMJJ.
006400000000             15    WAAMM.
006500000000              20   WAA.
006600000000               25  WAA1-1                         PIC X.
006700000000               25  WAA2-2                         PIC X.
006800000000              20   WAA9 REDEFINES WAA             PIC 9(2).
006900000000              20   WMM.
007000000000               25  WMM9                           PIC 9(2).
007100000000             15    WAAMM9 REDEFINES WAAMM         PIC 9(4).
007200000000             15    WJJ.
007300000000              20   WJJ9                           PIC 9(2).
007400000727      ***** DATE. FORMAT YYMMDD DIGITAL *****
007500000000            10     WAAMMJJ9 REDEFINES WAAMMJJ     PIC 9(6).
007600000727      ***** TIME. FORMAT HHMNSSCC *****
007700000000            10     WHHMNSSCC.
007800000000             15    WHHMNSS.
007900000000              20   WHH.
008000000000               25  WHH9                           PIC 9(2).
008100000000              20   WMN.
008200000000               25  WMN9                           PIC 9(2).
008300000000              20   WSS.
008400000000               25  WSS9                           PIC 9(2).
008500000000             15    WCC.
008600000000              20   WCC9                           PIC 9(2).
008700000727      ***** TIME. FORMAT HHMNSSCC DIGITAL *****
008800000000            10     WHHMNSSCC9 REDEFINES WHHMNSSCC PIC 9(8).
008900000727      ***** TIME. FORMAT HHMNSS DIGITAL *****
009000880425            10     FILLER REDEFINES WHHMNSSCC.
009100000000             15    WHHMNSS9                       PIC 9(6).
009200880425             15    FILLER                         PIC X(2).
009300000727      ***** TIME. FORMAT HHMN DIGITAL *****
009400880425            10     FILLER REDEFINES WHHMNSSCC.
009500000000             15    WHHMN.
009600000000              20   WHHMN9                         PIC 9(4).
009700880425             15    FILLER                         PIC X(4).
009800000727      ***** DATE/TIME. FORMAT YYMMDDHHMNSS *****
009900880425           05      FILLER REDEFINES WAAMMJJ-HHMNSSCC.
010000000000            10     WAAMMJJ-HHMNSS.
010100000000             15    WAAMMJJ-HHMNSS9                PIC 9(12).
010200880425            10     FILLER                         PIC X(2).
010300000727      ***** DAY/DAY NBR/MONTH/NOT IN CODE ***  POS=70 LG=13
010400000000           05      WDATE-CLAIRC VALUE "JEU 01 MAR 85".
010500000000            10     WJOURC                         PIC X(3).
010600880425            10     FILLER                         PIC X.
010700000000            10     WNOJOURC                       PIC X(2).
010800880425            10     FILLER                         PIC X.
010900000000            10     WMOISC                         PIC X(3).
011000880425            10     FILLER                         PIC X.
011100000000            10     WANC                           PIC X(2).
011200000727      ***** PUBLIC HOLIDAYS *****           POS=82 LG=10
011300000000           05      WNOM-FETE                      PIC X(10) VALUE SPACE.
011400000727      ***** QUANTIEME. FORMAT DDDDD FOR THE CENTURY ** POS=93 LG=5
011500000000           05      WJJJJJ.
011600000000            10     WJJJJJ9                        PIC 9(5) VALUE ZERO.
011700000727      ***** NUMBER OF WEEK IN YEAR *** POS=98 LG=2
011800000000           05      WNO-SEMAINE.
011900000000            10     WNO-SEMAINE9                   PIC 9(2) VALUE ZERO.
012000000727      ***** NUMBER OF DAYS IN MONTH ***** POS=100 LG=2
012100000000           05      WNBJOUR-MOIS.
012200000000            10     WNBJOUR-MOIS9                  PIC 9(2) VALUE ZERO.
012300000727      ***** TRIMESTER NUMBER (1 TO 4) *** POS=102 LG=1
012400000000           05      WNO-TRIMESTRE.
012500000000            10     WNO-TRIMESTRE9                 PIC 9 VALUE ZERO.
012600000727      ***** SEMESTER NUMBER (1 OR 2) *** POS=103 LG=1
012700000000           05      WNO-SEMESTRE.
012800000000            10     WNO-SEMESTRE9                  PIC 9 VALUE ZERO.
012900000727      ***** 1=NON WORK  0=ELSE *** POS=104 LG=1
013000000000           05      WFERIE                         PIC X VALUE "0".
013100000727      ***** YEAR/QUANTIEME. FORMAT YYDDD *****
013200880425       01  FILLER REDEFINES WKDAT000.
013300880425           05      FILLER                         PIC X(46).
013400000000           05      WAAJJJ.
013500000000            10     WAAJJJ9                        PIC 9(5).
013600000727      ***** DATE. FORMAT DDMMYY *****
013700000000           05      WJJMMAA                        PIC X(6).
013800880425           05      FILLER                         PIC X(47).
013900000000      *
