000001150928       // %CSTD===========================================================*
000002150928       // * Application. : SAM        Arcad Sample application            *
000003150928       // * Component. . : HSR200                        Type: RPGLE      *
000004150928       // *===============================================================*
000005150928       // * Sub-system . : TRD Trade                                      *
000006150928       // * Function . . : SAL Sales                                      *
000007150928       // * Sub-function :                                                *
000008150928       // *%S=============================================================*
000009150928       // * Description of functions:                                     *
000011150928       // *                                                               *
000012150928       // *                                                               *
000013150928       // *                                                               *
000014150928       // *%E=============================================================*
000015150928       // * AUTHOR:                          00:00                        *
000016150928       // * MODIFS: 07 JTICKNER   10/15/2014 14:56  V 1.00.P MR 14/   32  *
000017150928       // *           My task                                             *
000018150928       // *           =====> Type RPG        changed to RPGLE      <===== *
000019150928       // *         06 RBERNARDI  10/07/2014 16:44  V 1.00.N MR 14/   26  *
000020150928       // *           ARCAD Build CHeck                                   *
000021150928       // *         05 RBERNARDI  09/26/2014 18:10  V 1.00.M MR 14/   31  *
000022150928       // *           Performance testing (Multiple iProject)             *
000023150928       // *         04 MMARREL    09/15/2014 10:36  V 1.00.L MR 14/   30  *
000024150928       // *           Rld change                                          *
000025150928       // *         03 MMARREL    07/03/2014 11:50  V 1.00.I MR 14/   29  *
000026150928       // *           genius                                              *
000027150928       // *         02 MMARREL    05/23/2014 10:03  V 1.00.G MR 14/   22  *
000028150928       // *           MCH0001 when loading program                        *
000029150928       // *         ** RBERNARDI  10/15/2014   :    V 1.00.E MR 14/   22  *
000030150928       // *         01 ARCAD_PGMR 07/28/2000 12:13  V 1.00.B MR 14/   22  *
000031150928       // %ECSTD==========================================================*
000032150928       // %EXEC OVRDBF INTFILE EXTFILE
000033150928       //  %ATTR TGTRLS(*CURRENT)
003101150928       // /TITLE Sales Order Entry / Maintenance / Inquiry
003201150928       //
003301150928       //  System        : HSV Control & Tracking
003401150928       //  Author        : Bob Lee (Intec Systems)
003501150928       //  Date          : January 1999
003601150928       //
003701150928       // ================================================================
003801150928       //  Indicator usage:
003901150928       //   20 - Order Valid for Despatch
004001150928       //   30 - 45 Input fields- DSPATR.
004101150928       //   62 - Control display/non-display of F10-Update.
004201150928       //   75 - 78 Program mode - Dispatch/Entry/Inquiry/Maintenance
004301150928       //   79 - MSGSFL (SFLCLR ETC...).
004401150928       //   99 - General CHAIN/SETLL result.
004501150928       //
004601150928       // ================================================================
004701150928       //  Maintenance   :
004801150928       //  Fix/Chg Ref. Date       Description.
004901150928       //  ------------ ---------- -----------------------------------
005001150928       // ================================================================
005301150928       //
005401150928       Ctl-Opt DATEDIT(*YMD);
005501150928       Dcl-F HSLCUSTB   Keyed
005601150928                        RENAME(HSFCUST:HSFCUSTB);
005701150928       //  Customer Master by Post Code.
005801150928       //
005901150928       Dcl-F HSLCUSTA   Keyed;
006001150928       //  Customer Master by Customer Account.
006101150928       //
006201150928       // LTCUSTAIF  E           K        DISK
006301150928       //            HSFCUST                           KRENAMEALTCUSTF
006401150928       //  Customer Master by Customer Account.
006501150928       //
006601150928       Dcl-F HSLORDPA   Keyed;
006701150928       //  Sales Order Parameters.
006801150928       //
006901150928       Dcl-F HSLTRACB   Usage(*Update:*Delete) Keyed;
007001150928       //  Voucher Tracking by Product/Series/Serial No./Element No.
007101150928       //
007201150928       Dcl-F HSLEXPAA   Usage(*Update:*Delete:*Output) Keyed USROPN;
007301150928       //  Unbanded Order line file by Product/Series/Serial No.
007401150928       //
007501150928       Dcl-F HSLVCTLA   Usage(*Update:*Delete) Keyed;
007601150928       //  Voucher Control.
007701150928       //
007801150928       Dcl-F HSLVXRFB   Keyed;
007901150928       //  Agency Product Cross-Reference.
008001150928       //
008101150928       Dcl-F HSLORDHA   Usage(*Update:*Delete:*Output) Keyed;
008201150928       //  Sales Order Header.
008301150928       //
008401150928       Dcl-F HSLORDDB   Usage(*Update:*Delete:*Output) Keyed;
008501150928       //  Sales Order Detail.
008601150928       //
008701150928       Dcl-F HSLODELA   Usage(*Update:*Delete:*Output) Keyed;
008801150928       //  Sales Order Delivery Detail.
008901150928       //
009001150928       Dcl-F HSLSHPOA   Keyed;
009101150928       //  Ship Only.
009201150928       //
009301150928       Dcl-F HSLINVMA   Usage(*Update:*Delete) Keyed;
009401150928       //  Inventory Master.
009501150928       //
009601150928       Dcl-F HSLWHSEA   Keyed;
009701150928       //  Warehouse Master.
009801150928       //
009901150928       Dcl-F HSLCOMPA   Keyed;
010001150928       //  Company Master.
010101150928       //
010201150928       Dcl-F HSLPRODA   Keyed;
010301150928       //  Product Master.
010401150928       //
010501150928       Dcl-F HSLDISCA   Keyed;
010601150928       //  Customer Discount File
010701150928       //
010801150928       Dcl-F HSPINVT    Usage(*Update:*Delete:*Output) Keyed;
010901150928       //  Inventory Transactions.
011001150928       //
011101150928       Dcl-F ARTICLE    Keyed;
011201150928       //  FOR ARTCILE XREF
011301150928       //
011401150928       Dcl-F HSS200     WORKSTN INFDS(INFDS)
011501150928                                SFILE(HSS200C:RRNX);
011601150928       //  Screen file.
011701150928       // ================================================================
011801150928       //  Arrays.
011901150928       //
012001150928       //  Days in Month for date validation.
012101150928       Dcl-S DIM             Packed(2:0)     DIM(12) CTDATA PERRCD(12);
012201150928       // ================================================================
012301150928       //  Data Structures.
012401150928       //
012501150928       //  Screen Information DS.
012601150928       Dcl-Ds INFDS;
012701150928         KEY             Char(1)         Pos(369);
012801150928         CSRLOC          BinDec(4:0)     Pos(370);
012802150928       End-Ds;
012901150928       //
013001150928       Dcl-Ds XXXSDS PSDS Len(429);
013101150928         XPGMID          *PROC;
013201150928         XJOBNO          Char(10)        Pos(244);
013301150928         XUSRID          Char(10)        Pos(254);
013302150928       End-Ds;
013401150928       //
013501150928       //  General DDMMCCYY date format.
013601150928       Dcl-Ds *n;
013701150928         DD              Zoned(2:0)      Pos(1) INZ;
013801150928         MM              Zoned(2:0)      Pos(3) INZ;
013901150928         CC              Zoned(2:0)      Pos(5) INZ;
014001150928         YY              Zoned(2:0)      Pos(7) INZ;
014101150928         DMCY            Zoned(8:0)      Pos(1);
014102150928       End-Ds;
014201150928       //
014301150928       //  General CCYYMMDD date format.
014401150928       Dcl-Ds *n;
014501150928         CCC             Zoned(2:0)      Pos(1) INZ;
014601150928         YYY             Zoned(2:0)      Pos(3) INZ;
014701150928         MMM             Zoned(2:0)      Pos(5) INZ;
014801150928         DDD             Zoned(2:0)      Pos(7) INZ;
014901150928         CYMD            Zoned(8:0)      Pos(1);
014902150928       End-Ds;
015001150928       //
015101150928       //  Input order date format.
015201150928       Dcl-Ds *n;
015301150928         JDD             Zoned(2:0)      Pos(1) INZ;
015401150928         JMM             Zoned(2:0)      Pos(3) INZ;
015501150928         JCC             Zoned(2:0)      Pos(5) INZ;
015601150928         JYY             Zoned(2:0)      Pos(7) INZ;
015701150928         XJORDD          Zoned(8:0)      Pos(1);
015702150928       End-Ds;
015801150928       //
015901150928       //  Output order date format.
016001150928       Dcl-Ds *n;
016101150928         WKC             Zoned(2:0)      Pos(1) INZ;
016201150928         WKY             Zoned(2:0)      Pos(3) INZ;
016301150928         WKM             Zoned(2:0)      Pos(5) INZ;
016401150928         WKD             Zoned(2:0)      Pos(7) INZ;
016501150928         WKORDD          Zoned(8:0)      Pos(1);
016502150928       End-Ds;
016601150928       //
016701150928       // ----------------------------------------------------------------
016801150928       //  Constants.
016901150928       //
017001150928       //  Named hexidecimal constants for function keys.
017101150928       Dcl-C F03             CONST(X'33');
017201150928       Dcl-C F04             CONST(X'34');
017301150928       Dcl-C F06             CONST(X'36');
017401150928       Dcl-C F07             CONST(X'37');
017501150928       Dcl-C F10             CONST(X'3A');
017601150928       Dcl-C F11             CONST(X'3B');
017701150928       Dcl-C F12             CONST(X'3C');
017801150928       //
017901150928       //  Zeros to "SETOF" error indicators.
018001150928       Dcl-C XZEROS          CONST('0000000000000000000');
018002150928       Dcl-S ATag            Char(14);
018003150928       Dcl-S WKORDN          Packed(8:0);
018004150928       Dcl-S ORDERX          Packed(8:0)     DtaAra('HSAORDERNO');
018005150928       Dcl-S TOT             Packed(20:5);
018006150928       Dcl-S SHONLY          Char(1);
018007150928       Dcl-S RRNS            Packed(5:0);
018008150928       Dcl-S RRNT            Packed(5:0);
018009150928       Dcl-S pAToArrStr      Pointer;
018010150928       Dcl-S AToArrStr       Char(65535)     Based(pAToArrStr);
018011150928       Dcl-S TPROD1          Char(13);
018012150928       Dcl-S TQTYN1          Packed(15:0);
018013150928       Dcl-S TKPRIC          Packed(9:2);
018014150928       Dcl-S TKVALU          Packed(9:2);
018015150928       Dcl-S TNDESC          Char(19);
018016150928       Dcl-S TSELC           Char(1);
018017150928       Dcl-S TPROD           Char(13);
018018150928       Dcl-S TPRIC           Packed(9:2);
018019150928       Dcl-S TQTYN           Packed(9:0);
018020150928       Dcl-S TDESC           Char(19);
018021150928       Dcl-S XQUAN           Packed(9:0);
018022150928       Dcl-S XJUMP           Char(1);
018023150928       Dcl-S XFIRST          Char(1);
018024150928       Dcl-S RRNXX           Packed(5:0);
018025150928       Dcl-S OPROD           Char(13);
018026150928       Dcl-S OSERC           Char(3);
018027150928       Dcl-S OSERN           Packed(9:0);
018028150928       Dcl-S XXSERF          Packed(9:0);
018029150928       Dcl-S XXRES           Packed(9:0);
018030150928       Dcl-S XXSERC          Char(3);
018031150928       Dcl-S XXSERN          Packed(9:0);
018032150928       Dcl-S XJUMP1          Char(1);
018033150928       Dcl-S DIF             Packed(9:0);
018034150928       Dcl-S DSERN           Packed(9:0);
018035150928       Dcl-S RES             Packed(9:0);
018036150928       Dcl-S KKSERC          Char(3);
018037150928       Dcl-S KKSERT          Packed(9:0);
018038150928       Dcl-S XJCLIM          Packed(15:0);                                      // Credit Limit
018039150928       Dcl-S XJTYSL          Packed(20:5);                                      // Last Year Sales
018040150928       Dcl-S REM             Packed(4:0);
018041150928       Dcl-S LEAP            Char(1);
018042150928       Dcl-S M               Packed(2:0);
018043150928       Dcl-S CCYY            Packed(4:0);
018044150928       Dcl-S YRTNC           Char(1);
018045150928       Dcl-S YNUMBR          Char(15);
018046150928       Dcl-S FILEY           Char(10);
018047150928       Dcl-S NAMEY           Char(6);
018048150928       Dcl-S NUMBRY          Char(6);
018049150928       Dcl-S LINY            Packed(3:0);
018050150928       Dcl-S COLY            Packed(3:0);
018051150928       Dcl-S ROW             Packed(2:0);
018052150928       Dcl-S COL             Packed(2:0);
018053150928       Dcl-S TEMP            Packed(9:0);
018054150928       Dcl-S WKTOTV          Like(XKVALU);
018055150928       Dcl-S WKSERC          Like(XKSERC);
018056150928       Dcl-S WKSERN          Like(BSERNN);
018057150928       Dcl-S WKQTYN          Like(XKQTYN);
018058150928       Dcl-S WKSUBC          Like(DSUBC);
018059150928       Dcl-S WKRANG          Like(XNO);
018060150928       Dcl-S WKVCTL          Like(XNO);
018061150928       Dcl-S UPDAT           Like(XNO);
018062150928       Dcl-S XNO             Char(1);
018063150928       Dcl-S XYES            Char(1);
018064150928       Dcl-S XERROR          Char(1);
018065150928       Dcl-S XUPDAT          Char(1);
018066150928       Dcl-S XDELET          Char(1);
018067150928       Dcl-S ORDPRM          Char(8);
018068150928       Dcl-S RRNX            Packed(5:0);
018069150928       Dcl-S RRNVAL          Packed(5:0);
018070150928       Dcl-S RRNLIN          Packed(5:0);
018071150928       Dcl-S RRNQ            Packed(5:0);
018072150928       Dcl-S RRNP            Packed(5:0);
018073150928       Dcl-S P0PGMQ          Char(10);                                          // Program queu
018074150928       Dcl-S P0PGRL          Char(5);                                           // Rel queue
018075150928       Dcl-S P0MSID          Char(7);                                           // Message ID
018076150928       Dcl-S P0MSGF          Char(10);                                          // Message file
018077150928       Dcl-S P0MSDA          Char(132);                                         // Message data
018078150928       Dcl-S P0MSTP          Char(7);                                           // Message type
018079150928       // Prototype for HSC200A
018080150928       Dcl-Pr Pgm_HSC200A ExtPgm('HSC200A') End-Pr;
018081150928       // Prototype for HSR200
018082150928       Dcl-Pr Pgm_HSR200 ExtPgm('HSR200');
018083150928         YMODE           Char(1);                                               // Mode
018084150928         YORDNO          Char(8);                                               // Sales Order No.
018085150928         YTYPE           Char(3);                                               // Order Type
018086150928         YCUST           Char(8);                                               // Customer No.
018087150928       End-Pr;
018088150928       // Procedure interface for HSR200
018089150928       Dcl-Pi Pgm_HSR200;
018090150928         YMODE           Char(1);                                               // Mode
018091150928         YORDNO          Char(8);                                               // Sales Order No.
018092150928         YTYPE           Char(3);                                               // Order Type
018093150928         YCUST           Char(8);                                               // Customer No.
018094150928       End-Pi;
018095150928       // Prototype for HSR220
018096150928       Dcl-Pr Pgm_HSR220 ExtPgm('HSR220');
018097150928         ORDPRM          Char(8);
018098150928       End-Pr;
018099150928       // Prototype for HSR230
018100150928       Dcl-Pr Pgm_HSR230 ExtPgm('HSR230');
018101150928         ORDPRM          Char(8);
018102150928       End-Pr;
018103150928       // Prototype for HSR341
018104150928       Dcl-Pr Pgm_HSR341 ExtPgm('HSR341');
018105150928         YRTNC           Char(1);
018106150928         YNUMBR          Char(15);
018107150928         FILEY           Char(10);
018108150928         NAMEY           Char(6);
018109150928         NUMBRY          Char(6);
018110150928         LINY            Packed(3:0);
018111150928         COLY            Packed(3:0);
018112150928       End-Pr;
018113150928       // Prototype for HSR342
018114150928       Dcl-Pr Pgm_HSR342 ExtPgm('HSR342') End-Pr;
018115150928       // Prototype for RMVMSGC
018116150928       Dcl-Pr Pgm_RMVMSGC ExtPgm('RMVMSGC') End-Pr;
018117150928       // Prototype for SNDMSGC
018118150928       Dcl-Pr Pgm_SNDMSGC ExtPgm('SNDMSGC');
018119150928         P0PGMQ          Char(10);                                              // Program queue
018120150928         P0PGRL          Char(5);                                               // Rel queue
018121150928         P0MSID          Char(7);                                               // Message ID
018122150928         P0MSGF          Char(10);                                              // Message file
018123150928         P0MSDA          Char(132);                                             // Message data
018124150928         P0MSTP          Char(7);                                               // Message type
018125150928       End-Pr;
018126150928       //
018201150928       // ================================================================
018301150928       //  M A I N L I N E
018401150928       // ================================================================
018501150928       //
018601150928       //  Dispatch mode
018701150928       If YMODE = 'D';
018801150928         *IN75 = *ON;
018802150928         *IN79 = *OFF;
018901150928       Else;
019001150928         *IN75 = *OFF;
019101150928       EndIf;
019201150928       Read ARTICLE;
019202150928       *IN99 = %Eof;
019301150928       //
019401150928       //  Entry mode
019501150928       If YMODE = 'E';
019601150928         *IN76 = *ON;
019701150928       Else;
019801150928         *IN76 = *OFF;
019901150928       EndIf;
020001150928       //
020101150928       //  Inquiry mode
020201150928       If YMODE = 'I';
020301150928         *IN77 = *ON;
020401150928       Else;
020501150928         *IN77 = *OFF;
020601150928       EndIf;
020701150928       //
020801150928       //  Maintenance mode       changesfordemo
020901150928       If YMODE = 'M';
021001150928         *IN78 = *ON;
021101150928       Else;
021201150928         *IN78 = *OFF;
021301150928       EndIf;
021401150928       //
021501150928       //  Program mode
021502150928       DoU ATag <> 'START' and ATag <> 'HDR'
021503150928         and ATag <> 'DET';
021602150928         If ATag = 'START' or ATag = *Blanks;
021603150928           ATag = *Blanks;
021701150928           If YMODE = 'I'
021801150928             or YMODE = 'D'
021901150928             or YMODE = 'M';
022001150928             If YORDNO <> *BLANKS;
022101150928               XJSORD = %Dec(%XLate(' ':'0':
022102150928                     YORDNO):8:0);
022201150928               WKORDN = %Dec(%XLate(' ':'0':
022202150928                     YORDNO):8:0);
022301150928               Chain WKORDN HSLORDHA;
022302150928               *IN99 = not %Found;
022401150928             EndIf;
022501150928           EndIf;
022601150928           //
022701150928           If YMODE = 'D';
022801150928             XJTYPE = JTYPE;
022901150928             XJCUST = JCUST;
023001150928             WKORDD = JORDD;
023101150928             JCC = WKC;
023201150928             JYY = WKY;
023301150928             JMM = WKM;
023401150928             JDD = WKD;
023501150928             XJORDR = JORDR;
023601150928             XJSORD = JSORD;
023701150928             If JSTAT = 'A'
023801150928               or JSTAT = ' ';
023901150928               *IN20 = *ON;
024001150928             Else;
024101150928               *IN20 = *OFF;
024201150928               P0MSID = 'HSV2015';
024301150928               Exsr YSNDMG;
024401150928             EndIf;
024501150928             Chain JCUST HSLCUSTA;
024502150928             *IN13 = not %Found;
024601150928             XJPCDE = EPCDE;
024701150928             XENAM1 = ENAM1;
024801150928             Setll JSORD HSLORDDB;
024901150928             ReadE JSORD HSLORDDB;
024902150928             *IN99 = %Eof;
025001150928             DoW *IN99 = *OFF;
025101150928               XVQTY += KQTYN;
025201150928               ReadE JSORD HSLORDDB;
025202150928               *IN99 = %Eof;
025301150928             EndDo;
025401150928             XJDISP = KDISP;
025501150928           Else;
025601150928             Exsr YCLRSC;
025701150928           EndIf;
025801150928           //
025901150928           //  Dispatch mode.
026001150928           If YMODE = 'D';
026101150928             Chain JSORD HSLODELA;
026102150928             *IN99 = not %Found;
026201150928             If VNAM1 = *BLANKS;
026301150928               XXNAM1 = ENAM1;
026401150928               XXNAM2 = ENAM2;
026501150928               XXADR1 = EADR1;
026601150928               XXADR2 = EADR2;
026701150928             Else;
026801150928               XXNAM1 = VNAM1;
026901150928               XXNAM2 = *Blanks;
027001150928               XXADR1 = VADR1;
027101150928               XXADR2 = VADR2;
027201150928             EndIf;
027301150928           EndIf;
027401150928           //
027402150928           //
027501150928           //  Dispatch, or Inquiry, or Maintenance mode.
027601150928           If YMODE = 'I'
027701150928             or YMODE = 'D'
027801150928             or YMODE = 'M';
027901150928             XJCUST = YCUST;
028001150928             XJTYPE = YTYPE;
028101150928           EndIf;
028102150928         EndIf;
028202150928         If ATag = 'HDR' or ATag = *Blanks;
028203150928           ATag = *Blanks;
028301150928           *IN47 = *OFF;
028401150928           //  Display screen to receive Customer No. until F03/F10
028501150928           DoU KEY = F03
028601150928             or KEY = F10
028701150928             and XERROR = XNO;
028801150928             //
028901150928             //  Exit if F03 pressed.
029001150928             If KEY = F03;
029101150928               *INLR = *ON;
029201150928               Leave;
029301150928             EndIf;
029401150928             //
029501150928             //  Display messages.
029601150928             Write MSGCTL;
029701150928             //
029801150928             XXTME = %Dec(%Time);
029901150928             Exfmt HSS200A;
030001150928             //
030101150928             Chain XJTYPE HSLORDPA;
030102150928             *IN99 = not %Found;
030201150928             If MSALE = 'C';
030301150928               *IN30 = *ON;
030401150928               XERROR = XYES;
030501150928               P0MSID = 'HSV2027';
030601150928               Exsr YSNDMG;
030701150928               Iter;
030801150928             EndIf;
030901150928             //
031001150928             Clear XVQTY;
031101150928             If *IN20 = *OFF
031201150928               and YMODE = 'D';
031301150928               Iter;
031401150928             EndIf;
031501150928             //
031601150928             RCDNBR = 1;
031701150928             //
031801150928             //  Clear messages.
031901150928             Exsr YCLRMG;
032001150928             //
032101150928             //  Process the various function keys available on the screen.
032201150928             //
032301150928             //  Process Despatch if F07 pressed.
032401150928             If KEY = F07;
032501150928               //
032601150928               //  Validate that Order Type is a valid Type.
032701150928               Chain XJTYPE HSLORDPA;
032702150928               *IN99 = not %Found;
032801150928               If *IN99 = *ON;
032901150928                 *IN30 = *ON;
033001150928                 XERROR = XYES;
033101150928                 P0MSID = 'HSV2001';
033201150928                 Exsr YSNDMG;
033302150928                 ATag = 'START';
033303150928                 Leave;
033401150928               EndIf;
033501150928             EndIf;
033601150928             //
033701150928             If YMODE = 'D'
033801150928               and WKORDN <> XJSORD;
033901150928               WKORDN = XJSORD;
034001150928               Chain XJSORD HSLORDHA;
034002150928               *IN99 = not %Found;
034101150928               If *IN99 = *ON;
034201150928                 *IN20 = *OFF;
034301150928                 P0MSID = 'HSV2017';
034401150928                 Exsr YSNDMG;
034501150928               Else;
034601150928                 XJTYPE = JTYPE;
034701150928                 XJCUST = JCUST;
034801150928                 WKORDD = JORDD;
034901150928                 JCC = WKC;
035001150928                 JYY = WKY;
035101150928                 JMM = WKM;
035201150928                 JDD = WKD;
035301150928                 XJORDR = JORDR;
035401150928                 XJSORD = JSORD;
035501150928                 If JSTAT = 'A'
035601150928                   or JSTAT = ' ';
035701150928                   *IN20 = *ON;
035801150928                 Else;
035901150928                   *IN20 = *OFF;
036001150928                   P0MSID = 'HSV2015';
036101150928                   Exsr YSNDMG;
036201150928                 EndIf;
036301150928               EndIf;
036401150928               Chain JCUST HSLCUSTA;
036402150928               *IN13 = not %Found;
036501150928               XJPCDE = EPCDE;
036601150928               XENAM1 = ENAM1;
036701150928               Setll JSORD HSLORDDB;
036801150928               ReadE JSORD HSLORDDB;
036802150928               *IN99 = %Eof;
036901150928               DoW *IN99 = *OFF;
037001150928                 XVQTY += KQTYN;
037101150928                 ReadE JSORD HSLORDDB;
037102150928                 *IN99 = %Eof;
037201150928               EndDo;
037301150928               XJDISP = KDISP;
037402150928               ATag = 'HDR';
037403150928               Leave;
037501150928             EndIf;
037601150928             //
037701150928             //  Program in inquiry, dispatch or maintenance mode
037801150928             If YMODE = 'I'
037901150928               or YMODE = 'M'
038001150928               or YMODE = 'D';
038101150928               //
038201150928               //  Initialise subfile
038301150928               *In70 = '1';
038302150928               *In71 = '0';
038303150928               *In72 = '0';
038304150928               *In73 = '1';
038401150928               Write HSS200B;
038501150928               If XJSORD <> 0;
038601150928                 RRNX = 0;
038701150928                 Setll XJSORD HSLORDDB;
038801150928                 DoU *IN97 = *ON;
038901150928                   ReadE XJSORD HSLORDDB;
038902150928                   *IN97 = %Eof;
039001150928                   //
039101150928                   //  Build subfile from existing order.
039201150928                   If *IN97 = *OFF;
039301150928                     RRNX += 1;
039401150928                     Chain RRNX HSS200C;
039402150928                     *IN99 = not %Found;
039501150928                     XOLIN = KLINE;
039601150928                     XSELC = KLTYP;
039701150928                     XKPROD = KPROD;
039801150928                     XNDESC = KDESC;
039901150928                     XKSERC = KSERC;
040001150928                     XKSERF = KSERNF;
040101150928                     XKSERT = KSERNT;
040201150928                     XKQTYN = KQTYN;
040301150928                     XKPRIC = KPRIC;
040401150928                     XKVALU = KVALU;
040501150928                     XXQTYN = XKQTYN;
040601150928                     //
040701150928                     //  Ship Only - set line value to zero.
040801150928                     If SHONLY = 'Y'
040901150928                       and XSELC = 'S';
041001150928                       XKVALU = 0;
041101150928                     EndIf;
041201150928                     //
041301150928                     //           £KVALU    MULT MVATP     £KVATA
041401150928                     //
041501150928                     //  Extended value
041601150928                     If XSELC = 'S'
041701150928                       or XSELC = 'N';
041801150928                       XKVALU = XKPRIC * XKQTYN;
041901150928                       //
042001150928                       //  Ship Only - set line value to zero.
042101150928                       If SHONLY = 'Y'
042201150928                         and XSELC = 'S';
042301150928                         XKVALU = 0;
042401150928                       EndIf;
042501150928                       //
042601150928                       //           £KVALU    MULT MVATP     £KVATA
042701150928                       //
042801150928                     EndIf;
042901150928                     //
043001150928                     //  Write subfile record.
043101150928                     If *IN99 = *OFF;
043201150928                       Update HSS200C;
043301150928                     Else;
043401150928                       Write HSS200C;
043501150928                     EndIf;
043601150928                   EndIf;
043701150928                 EndDo;
043801150928               EndIf;
043901150928               Leave;
044001150928             EndIf;
044101150928             //
044201150928             //  Program mode - Entry
044301150928             If YMODE = 'E';
044401150928               //
044501150928               //  Execute search if F04 pressed.
044601150928               If KEY = F04;
044701150928                 Exsr YSERCH;
044801150928                 Iter;
044901150928                 Exsr YCLRMG;
045001150928               EndIf;
045101150928               //
045201150928               //  Validate header screen fields.
045301150928               Exsr VALIDH;
045401150928               //
045501150928               //  Validate ship only requirements.
045601150928               Exsr SHPONL;
045701150928               //
045801150928             EndIf;
045901150928             //
046001150928             //  Process Despatch if F07 pressed.
046101150928             If KEY = F07;
046201150928               //
046301150928               Leave;
046401150928             EndIf;
046501150928             //
046601150928             //  End of DO loops for F03/F10 key checks.
046701150928           EndDo;
046702150928           If ATag = 'START' or ATag = 'HDR';
046703150928             Iter;
046704150928           EndIf;
046801150928           *IN61 = *OFF;
046901150928           //
047001150928           //  Clear messages.
047101150928           Exsr YCLRMG;
047201150928           //
047301150928           //  Exit if F03 pressed.
047401150928           If KEY = F03;
047501150928             //  Exit program.
047601150928             *INLR = *ON;
047701150928             Return;
047801150928           EndIf;
047901150928           //
048001150928           // -------------------------------------------------------
048101150928           //
048201150928           //  Program mode - Entry
048301150928           //  Retrieve order number.
048401150928           If YMODE = 'E';
048601150928             In *LOCK ORDERX;
048701150928             ORDERX += 1;
048801150928             Out ORDERX;
048901150928             XJSORD = ORDERX;
049001150928           EndIf;
049101150928           //
049201150928           //  Display screen to receive Order Details until F10/F12
049202150928         EndIf;
049302150928         // branch when ATag = 'DET'
049303150928         ATag = *Blanks;
049401150928         //
049501150928         //  Program in inquiry, or dispatch, or maintenance mode
049601150928         If YMODE = 'I'
049701150928           or YMODE = 'M'                                                      //testing
049801150928           or YMODE = 'D'
049901150928           or KEY = F12;
050001150928           *IN73 = *OFF;
050101150928         Else;
050201150928           *IN73 = *ON;
050301150928         EndIf;
050401150928         //
050501150928         DoU KEY = F10
050601150928           and XERROR = XNO
050701150928           or KEY = F12;
050801150928           //
050901150928           //  Display messages.
051001150928           Write MSGCTL;
051101150928           //
051201150928           //  Read subfile to accumulate order value.
051301150928           If RRNX > 0;
051401150928             RRNVAL = 1;
051501150928             XKTVAL = 0;
051601150928             DoU *IN98 = *ON
051701150928               or RRNVAL = 100
051801150928               or XSELC = *BLANK;
051901150928               Chain RRNVAL HSS200C;
051902150928               *IN98 = not %Found;
052001150928               If XSELC <> *BLANK
052101150928                 and XKPROD <> *BLANK
052201150928                 and *IN98 = *OFF
052301150928                 or XSELC <> *BLANK
052401150928                 and XNDESC <> *BLANK
052501150928                 and *IN98 = *OFF;
052601150928                 XKTVAL += XKVALU;
052701150928               EndIf;
052801150928               RRNVAL += 1;
052901150928             EndDo;
053001150928           EndIf;
053101150928           //
053201150928           //  Dispatch mode.
053301150928           If YMODE = 'D';
053401150928             Chain XJCUST HSLCUSTA;
053402150928             *IN99 = not %Found;
053501150928             //  ...load Customer record into screen 2 fields.
053601150928             XJNAM1 = ENAM1;                                                    // Name 1
053701150928             XJNAM2 = ENAM2;                                                    // Name 2
053801150928             XJADR1 = EADR1;                                                    // Address 1
053901150928             XJADR2 = EADR2;                                                    // Address 2
054001150928           EndIf;
054101150928           //
054201150928           //
054301150928           //  Display footer.
054401150928           If KEY <> F07;
054501150928             Write HSS200E;
054601150928           EndIf;
054701150928           //
054801150928           XXTME = %Dec(%Time);
054901150928           *In70 = '0';
054902150928           *In71 = '1';
054903150928           *In72 = '1';
055001150928           //
055101150928           If KEY <> F07;
055201150928             Exfmt HSS200B;
055301150928             XJUMP1 = XNO;
055401150928             //
055501150928             If KEY <> F10;
055601150928               Exsr YDELT;
055701150928             EndIf;
055801150928             //
055901150928           EndIf;
056001150928           //
056101150928           *IN73 = *OFF;
056201150928           *IN86 = *OFF;
056301150928           //
056401150928           //  Clear messages (Only if an error has not been repeated)
056501150928           //
056601150928           If XERROR = XNO;
056701150928             //  Clear messages.
056801150928             Exsr YCLRMG;
056901150928           EndIf;
057001150928           //
057101150928           //  Process the various function keys available on the screen.
057201150928           //
057301150928           //  Exit if F12 pressed.
057401150928           If KEY = F12;
057502150928             ATag = 'HDR';
057503150928             Leave;
057601150928           EndIf;
057701150928           //
057801150928           //  Execute search if F04 pressed.
057901150928           If KEY = F04;
058001150928             Exsr YSERSF;
058101150928             Iter;
058201150928           EndIf;
058301150928           //
058401150928           //  Check for agency cross-references.
058501150928           If MXREF = 'Y';
058601150928             Exsr AGXREF;
058701150928           EndIf;
058801150928           //
058901150928           //  Validate order detail screen fields (only re-validate data
059001150928           //  if it has been changed. Otherwise re-display error message).
059101150928           If XERROR = XYES;
059201150928             Chain RRNS HSS200C;
059202150928             *IN98 = not %Found;
059301150928             If XSELC <> TSELC
059401150928               or XKPROD <> TPROD
059501150928               or XKPRIC <> TPRIC
059601150928               or XKQTYN <> TQTYN
059701150928               or XNDESC <> TDESC;
059801150928               *IN93 = *ON;
059901150928             EndIf;
060001150928           EndIf;
060101150928           //
060201150928           If *IN93 = *ON
060301150928             or XERROR = XNO;
060401150928             //
060501150928             //  Validate order detail screen fields.
060601150928             Exsr VALIDD;
060701150928           EndIf;
060801150928           //
060901150928           //  Discount retrieval.
061001150928           Exsr DISCNT;
061101150928           //
061201150928           //  Stock allocation preview
061301150928           //                  - with banded allocation and manual allocation.
061401150928           //           MSALE     IFEQ 'S'
061501150928           //                     EXSR ALLOCS
061601150928           //                     ENDIF
061701150928           //
061801150928           //  Process Dispatch if F07 pressed.
061901150928           If KEY = F07;
062001150928             //
062101150928             Leave;
062201150928           EndIf;
062301150928           //
062401150928           //  End of DO loops for F10/F12 key checks.
062501150928         EndDo;
062502150928         If ATag = 'HDR';
062503150928           Iter;
062504150928         EndIf;
062601150928         //
062701150928         // -------------------------------------------------------
062801150928         //  Confirm order - prompt for delivery details.
062901150928         //                - file updates when F10 pressed.
063001150928         DoU KEY = F10
063101150928           and XERROR = XNO
063201150928           or KEY = F12;
063301150928           //
063401150928           //  Clear messages.
063501150928           Exsr YCLRMG;
063601150928           //
063701150928           //  Process the various function keys available on the screen.
063801150928           //
063901150928           //  Exit if F12 pressed.
064001150928           //           KEY       IFEQ F12
064101150928           //                     GOTO DET
064201150928           //                     ENDIF
064301150928           //
064401150928           //  Check for minimum order value.
064501150928           If KEY <> F07;
064601150928             If MORDV > 0;
064701150928               Exsr MINVAL;
064801150928             EndIf;
064901150928             //
065001150928             //  Credit limit check.... Warning only.
065101150928             TOT = XKTVAL + XJTYSL;
065201150928             If TOT > XJCLIM;
065301150928               *IN46 = *ON;
065401150928               P0MSID = 'HSV2019';
065501150928               Exsr YSNDMG;
065601150928             EndIf;
065701150928           EndIf;
065801150928           //
065901150928           //  Display messages.
066001150928           Write MSGCTL;
066101150928           //
066201150928           //  Display key text footer.
066301150928           //                     WRITEHSS200E
066401150928           If KEY <> F07;
066501150928             Write HSS200F;
066601150928           EndIf;
066701150928           //
066801150928           //  Delivery address prompt screen.
066901150928           XXTME = %Dec(%Time);
067001150928           //
067101150928           //  Program in inquiry, dispatch or maintenance mode
067201150928           If YMODE = 'I'
067301150928             or YMODE = 'M'
067401150928             or YMODE = 'D';
067501150928             Chain WKORDN HSLODELA;
067502150928             *IN99 = not %Found;
067601150928             //
067701150928             //  Write fields for order delivery detail record.
067801150928             If *IN99 = *OFF;
067901150928               XVNAM1 = VNAM1;
068001150928               XVADR1 = VADR1;
068101150928               XVADR2 = VADR2;
068201150928               XVADR3 = VADR3;
068301150928               XVPCDE = VPCDE;
068401150928               XVDIN1 = VDIN1;
068501150928               XVDIN2 = VDIN2;
068601150928               XVDIN3 = VDIN3;
068701150928             EndIf;
068801150928           EndIf;
068901150928           //
069001150928           //  Write order delivery details record.
069101150928           If KEY <> F07;
069201150928             Exfmt HSS200D;
069301150928           EndIf;
069401150928           //
069501150928           //  Exit if F12 pressed.
069601150928           If KEY = F12;
069701150928             Exsr YDELT;
069802150928             ATag = 'DET';
069803150928             Leave;
069901150928           EndIf;
070001150928           //
070101150928           //  Clear messages.
070201150928           If *IN47 = *OFF;
070301150928             Exsr YCLRMG;
070401150928           EndIf;
070501150928           //
070601150928           //  Update all files, if no errors exist.
070701150928           If KEY = F10
070801150928             and XERROR = XNO
070901150928             or KEY = F07;
071001150928             RRNX = 1;
071101150928             DoU *IN98 = *ON
071201150928               or RRNX = 100
071301150928               or XSELC = *BLANK;
071401150928               Chain RRNX HSS200C;
071402150928               *IN98 = not %Found;
071501150928               If XSELC <> *BLANK
071601150928                 and XKPROD <> *BLANK
071701150928                 and *IN98 = *OFF
071801150928                 or XSELC <> *BLANK
071901150928                 and XNDESC <> *BLANK
072001150928                 and *IN98 = *OFF;
072101150928                 //
072201150928                 //  Save RRN for current order line.
072301150928                 RRNLIN = RRNX;
072401150928                 //
072501150928                 //  Update Voucher Control if in entry mode....
072601150928                 If YMODE = 'E'
072701150928                   and MSALE = 'S';
072801150928                   Exsr UPPVCT;
072901150928                 EndIf;
073001150928                 //
073101150928                 //  Re-position to required subfile line
073201150928                 RRNX = RRNLIN;
073301150928                 Chain RRNX HSS200C;
073302150928                 *IN98 = not %Found;
073401150928                 //
073501150928                 //  Create/Update order details if in Entry,Maint,or Dispatch mode.
073601150928                 If YMODE = 'E'
073701150928                   or YMODE = 'D'
073801150928                   or YMODE = 'M';
073901150928                   Exsr UPORDD;
074001150928                 EndIf;
074101150928                 //
074201150928                 //  Update voucher tracking if in Entry or Dispatch mode.
074301150928                 //  Stock lines only.
074401150928                 If YMODE = 'E'
074501150928                   and XSELC = 'S'
074601150928                   or YMODE = 'D'
074701150928                   and XSELC = 'S';
074801150928                   Exsr UPTRAC;
074901150928                 EndIf;
075001150928                 //
075101150928                 //  Allocate inventory if in Entry mode.
075201150928                 //  Stock lines only.
075301150928                 If YMODE = 'E'
075401150928                   and XSELC = 'S';
075501150928                   //  Update inventory allocations.
075601150928                   Exsr UPINVA;
075701150928                 EndIf;
075801150928                 //
075901150928                 //  Sell inventory if in Dispatch mode.
076001150928                 //  Stock lines only.
076101150928                 If YMODE = 'D'
076201150928                   and XSELC = 'S';
076301150928                   //  Update inventory sales.
076401150928                   Exsr UPINVS;
076501150928                   //
076601150928                   //  Create inventory sales transaction.
076701150928                   Exsr UPINVT;
076801150928                 EndIf;
076901150928               EndIf;
077001150928               RRNX += 1;
077101150928             EndDo;
077201150928             //
077301150928             //  Create/Update order header if in Entry,Maint,or Dispatch mode.
077401150928             If YMODE = 'E'
077501150928               or YMODE = 'D'
077601150928               or YMODE = 'M';
077701150928               Exsr UPORDH;
077801150928               //
077901150928               //  Create/update delivery record if in Entry,Maint or Dispat.mode.
078001150928               Exsr UPODEL;
078101150928             EndIf;
078201150928             //
078301150928             //  Ship to all delivery points if in Entry mode.
078401150928             If YMODE = 'E'
078501150928               and MALLP = 'Y';
078601150928               Exsr SHPALL;
078701150928             EndIf;
078801150928             //
078901150928             //  Print delivery note if in Entry mode, and charges only not set.
079001150928             If YMODE = 'E'
079101150928               and MINVC <> 'Y';
079201150928               Exsr PRTDEL;
079301150928             EndIf;
079401150928             //
079501150928             //  Print Invoice if in Entry mode, and Immediate print required.
079601150928             If YMODE = 'E'
079701150928               and MINVP = 'I';
079801150928               Exsr PRTINV;
079901150928             EndIf;
080001150928             //
080101150928           EndIf;
080201150928           //  Process Despatch if F07 pressed.
080301150928           If KEY = F07;
080401150928             Exsr YCLRSC;
080501150928             //
080601150928             Leave;
080701150928           EndIf;
080801150928           //
080901150928           //  End of Confirmation.
081001150928         EndDo;
081002150928         If ATag = 'DET';
081003150928           Iter;
081004150928         EndIf;
081101150928         //
081201150928         //  Return to order details if F12 pressed.
081301150928         If KEY = F12;
081402150928           ATag = 'DET';
081403150928           Iter;
081501150928         EndIf;
081601150928         //
081701150928         //  Clear Subfile
081801150928         *In70 = '1';
081802150928         *In71 = '0';
081803150928         *In72 = '0';
081804150928         *In73 = '0';
081901150928         Write HSS200B;
082001150928         //
082101150928         //  Clear contents of HSPEXPA.
082201150928         Exsr YDELT;
082301150928         //
082401150928         //  Return to order header.
082502150928         ATag = 'HDR';
082503150928         Iter;
082504150928       EndDo;
082601150928       //
082701150928       // ****************************************************************
082801150928       // ----------------------------------------------------------------
082901150928       //  ‡CLRSC - Clear screen fields.
083001150928       // ----------------------------------------------------------------
083101150928       //
083201150928       BegSr YCLRSC;
083301150928         //
083401150928         //  Clear header screen fields.
083501150928         If YMODE <> 'E';
083601150928           Clear XJTYPE;
083701150928         EndIf;
083801150928         If YMODE = 'D';
083901150928           Clear XJSORD;
084001150928           Clear XENAM1;
084101150928           Clear XVQTY;
084201150928         EndIf;
084301150928         Clear XJCOMP;
084401150928         Clear XJWHSE;
084501150928         Clear XJPCDE;
084601150928         Clear XJCUST;
084701150928         Clear XJDISP;
084801150928         Clear XJORDD;
084901150928         Clear XJORDR;
085001150928         //
085101150928         //  Clear delivery screen fields.
085201150928         Clear XVNAM1;
085301150928         Clear XVADR1;
085401150928         Clear XVADR2;
085501150928         Clear XVADR3;
085601150928         Clear XVPCDE;
085701150928         Clear XVDIN1;
085801150928         Clear XVDIN2;
085901150928         Clear XVDIN3;
086001150928       EndSr;
086101150928       //
086201150928       // ----------------------------------------------------------------
086301150928       //  SHPONL - Validate ship only requirements.
086401150928       // ----------------------------------------------------------------
086501150928       BegSr SHPONL;
086601150928         //
086701150928         //  Check if a ship only record exists for this customer
086801150928         Chain XJCUST HSLSHPOA;
086802150928         *IN99 = not %Found;
086901150928         If *IN99 = *OFF;
087001150928           SHONLY = 'Y';
087101150928         Else;
087201150928           SHONLY = ' ';
087301150928         EndIf;
087401150928       EndSr;
087501150928       //
087601150928       // ----------------------------------------------------------------
087701150928       //  AGXREF - Check for agency cross-references.
087801150928       // ----------------------------------------------------------------
087901150928       BegSr AGXREF;
088001150928         Chain (CCYY : XJCUST : XKPROD) HSLVXRFB;
088002150928         *IN99 = not %Found;
088101150928         If *IN99 = *OFF;
088201150928           KPROD = HPROD;
088301150928           XKPROD = HPROD;
088401150928         EndIf;
088501150928       EndSr;
088601150928       //
088701150928       // ----------------------------------------------------------------
088801150928       //  VALIDD - Validate order detail screen fields.
088901150928       // ----------------------------------------------------------------
089001150928       BegSr VALIDD;
089101150928         //
089201150928         //  Order Detail validation:
089301150928         //
089401150928         //  Reset work values.
089501150928         //                     Z-ADD0         RRN£
089601150928         RRNS = 0;
089701150928         RRNT = 1;
089801150928         Reset XERROR;
089901150928         *IN61 = *OFF;                                                          // Hide F10/F11
090001150928         //
090101150928         //  Reset error indicators.
090201150928         pAToArrStr = %Addr(*IN(30));
090202150928         %Subst(AToArrStr:1:19) = XZEROS;
090301150928         //
090401150928         //  Read all Records from subfile and validate contents.
090501150928         DoU *IN99 = *ON;                                                       // ..Do1
090601150928           //
090701150928           //  Process the subfile in one of two modes depending on whether
090801150928           //  a previous change to the subfile has been made....
090901150928           //
091001150928           If *IN82 = *OFF;
091101150928             ReadC HSS200C;
091102150928             *IN99 = %Eof;
091201150928             RRNT = RRNX;
091301150928             RRNT += 1;
091401150928           Else;
091501150928             If RRNT = 101;
091601150928               Leave;
091701150928             EndIf;
091801150928             Chain RRNT HSS200C;
091802150928             *IN99 = not %Found;
091901150928             RRNT += 1;
092001150928           EndIf;
092101150928           //
092201150928           //                     READCHSS200C                  99
092301150928           //  Retrieve subfile record.
092401150928           If *IN99 = *OFF;                                                     // ...If2
092501150928             TPROD1 = XKPROD;
092601150928             TQTYN1 = %Dec(%Subst(%EditC(TQTYN1:'X'):1:6)
092602150928                    + %EditC(XKQTYN:'X')
092603150928                       :15:0);
092701150928             *IN82 = *ON;
092801150928             //
092901150928             //  Reset subfile error indicators.
093001150928             *In36 = '0';
093002150928             *In37 = '0';
093003150928             *In38 = '0';
093004150928             *In39 = '0';
093005150928             *In40 = '0';
093006150928             *In41 = '0';
093007150928             *In42 = '0';
093008150928             *In43 = '0';
093101150928             //
093201150928             If XSELC <> *BLANK                                                 // ....If3
093301150928               or XKPROD <> *BLANK                                              // ....If3
093401150928               or XNDESC <> *BLANK                                              // ....If3
093501150928               or XKPRIC <> *ZEROS                                              // ....If3
093601150928               or XKQTYN <> *ZEROS                                              // ....If3
093701150928               or XKVALU <> *ZEROS                                              // ....If3
093801150928               or XKVATA <> *ZEROS                                              // ....If3
093901150928               or XKSERC <> *BLANKS                                             // ....If3
094001150928               or XKSERF <> *ZEROS                                              // ....If3
094101150928               or XKSERT <> *ZEROS;                                             // ....If3
094201150928               //
094301150928               //  Count active subfile records.
094401150928               //                     ADD  1         RRN£
094501150928               RRNS += 1;
094601150928               //
094701150928               //  Validate Selection code.
094801150928               If XSELC <> 'S'
094901150928                 and XSELC <> 'N'
095001150928                 and XSELC <> 'T'
095101150928                 //
095201150928                 //  Validate Selection code / Product code / Text combination
095301150928                 or XSELC = *BLANK
095401150928                 and XKPROD <> *BLANKS
095501150928                 or XSELC = *BLANK
095601150928                 and XNDESC <> *BLANKS
095701150928                 or XSELC = *BLANK
095801150928                 and XKPRIC <> 0
095901150928                 or XSELC = *BLANK
096001150928                 and XKQTYN <> 0
096101150928                 or XSELC = 'T'
096201150928                 and XKPROD <> *BLANKS
096301150928                 or XSELC = 'T'
096401150928                 and XKPRIC <> 0
096501150928                 or XSELC = 'T'
096601150928                 and XKQTYN <> 0
096701150928                 or XSELC = 'T'
096801150928                 and XKSERC <> *BLANKS
096901150928                 or XSELC = 'T'
097001150928                 and XKSERF <> 0
097101150928                 or XSELC = 'T'
097201150928                 and XKSERT <> 0
097301150928                 or XSELC = 'S'
097401150928                 and XKQTYN = 0
097501150928                 //           £SELC     OREQ 'S'
097601150928                 //           £KPRIC    ANDEQ0
097701150928                 or XSELC = 'N'
097801150928                 and XKQTYN = 0
097901150928                 or XSELC = 'N'
098001150928                 and XKPRIC = 0;
098101150928                 *IN36 = *ON;
098201150928                 XERROR = XYES;
098301150928                 P0MSID = 'HSV2006';
098401150928                 Exsr YSNDMG;
098501150928               EndIf;
098601150928               //
098701150928               //  Validate Selection code for Invoice Charge Only order type.
098801150928               If XSELC = 'S'
098901150928                 and MINVC = 'Y';
099001150928                 *IN36 = *ON;
099101150928                 XERROR = XYES;
099201150928                 P0MSID = 'HSV2014';
099301150928                 Exsr YSNDMG;
099401150928               EndIf;
099501150928               //
099601150928               If YMODE = 'D'
099701150928                 and XKQTYN > XXQTYN;
099801150928                 XERROR = XYES;
099901150928                 P0MSID = 'HSV2020';
100001150928                 Exsr YSNDMG;
100101150928                 Leave;
100201150928               Else;
100301150928                 Exsr YCLRMG;
100401150928               EndIf;
100501150928               //
100601150928               //  Validate Product.
100701150928               If XSELC = 'S';
100801150928                 If XKPROD <> *BLANKS;
100901150928                   Chain XKPROD HSLPRODA;
100902150928                   *IN99 = not %Found;
101001150928                   If *IN99 = *ON;
101101150928                     *IN37 = *ON;
101201150928                     XERROR = XYES;
101301150928                     P0MSID = 'HSV2007';
101401150928                     Exsr YSNDMG;
101501150928                   Else;
101601150928                     XNDESC = NDESC;
101701150928                     XKPRIC = NPRIC;
101801150928                   EndIf;
101901150928                 EndIf;
102001150928               EndIf;
102101150928               //
102201150928               //  Reverse price for Credit
102301150928               If MSALE = 'C';
102401150928                 XKPRIC = 0 - XKPRIC;
102501150928               EndIf;
102601150928               //
102701150928               //  Extended value
102801150928               If XSELC = 'S'
102901150928                 or XSELC = 'N';
103001150928                 XKVALU = XKPRIC * XKQTYN;
103101150928                 //
103201150928                 //           £KVALU    MULT MVATP     £KVATA
103301150928               EndIf;
103401150928               //
103501150928               //  Save Price, Value and Description field contents....
103601150928               TKPRIC = XKPRIC;
103701150928               TKVALU = XKVALU;
103801150928               TNDESC = XNDESC;
103901150928               //
104001150928               //  Check quantity against allocated serial numbers.
104101150928               //           £KQTYN    IFNE 0
104201150928               //           £KSERF    ANDNE0
104301150928               //           £KSERT    ANDNE0
104401150928               //           £KSERT    SUB  £KSERF    WKQTYN
104501150928               //                     ADD  1         WKQTYN
104601150928               //           £KQTYN    IFNE WKQTYN
104701150928               //                     MOVEA'1011'    *IN,40
104801150928               //                     MOVE £YES      £ERROR
104901150928               //                     MOVEL'HSV2013' P0MSID
105001150928               //                     EXSR ‡SNDMG
105101150928               //                     ENDIF
105201150928               //                     ENDIF
105301150928               //
105401150928               //  Check voucher control if not yet allocated
105501150928               If XSELC = 'S'
105601150928                 and XKQTYN > 0;
105701150928                 //           £KSERC    IFEQ *BLANKS
105801150928                 //           £KSERF    ANDEQ0
105901150928                 //           £KSERT    ANDEQ0
106001150928                 WKVCTL = 'U';
106101150928                 Exsr UPVCTL;
106201150928               EndIf;
106301150928               //                     ENDIF
106401150928               //
106501150928               //  Update subfile record with DSPATR settings and set SFLRCDNBR.
106601150928               RCDNBR = RRNX;
106701150928               XKPRIC = TKPRIC;
106801150928               XKVALU = TKVALU;
106901150928               XNDESC = TNDESC;
107001150928               Update HSS200C;                                                  // SFL
107101150928               *In36 = '0';
107102150928               *In37 = '0';
107103150928               *In38 = '0';
107104150928               *In39 = '0';
107105150928               *In40 = '0';
107106150928               *In41 = '0';
107107150928               *In42 = '0';
107108150928               *In43 = '0';
107201150928               //
107301150928               //  If errors encountered in subfile then exit subfile validation.
107401150928               If XERROR = XYES;
107501150928                 TSELC = XSELC;
107601150928                 TPROD = XKPROD;
107701150928                 TPRIC = XKPRIC;
107801150928                 TQTYN = XKQTYN;
107901150928                 TDESC = XNDESC;
108001150928                 //                     Z-ADDRRN£      RRNS    50
108101150928                 Leave;
108201150928               EndIf;
108301150928               //
108401150928               //  End of non-blank subfile check.
108501150928             EndIf;                                                             // ....EndIf3
108601150928             //
108701150928             //  End of Subfile CHAIN check.
108801150928           EndIf;                                                               // ...EndIf2
108901150928           //
109001150928           //  End of loop for next subfile record.
109101150928         EndDo;                                                                 // ..EndDo1
109201150928         //
109301150928         //  Save last RRN number used.
109401150928         //                     Z-ADDRRN£      SAVRRN
109501150928         //
109601150928         //  If no errors found...
109701150928         If XERROR = XNO;
109801150928           //  ...display "Data valid.Press F10 to update" message...
109901150928           P0MSID = 'HSV9006';
110001150928           Exsr YSNDMG;
110101150928           //  ...activate F10 key (*IN61=*ON).
110201150928           *IN61 = *ON;
110301150928         EndIf;
110401150928         If XJUMP1 = XYES
110501150928           and *IN52 = *ON;
110602150928           Pgm_HSR342();
110701150928         EndIf;
110801150928         *IN52 = *OFF;
110901150928       EndSr;
111001150928       //
111101150928       // ----------------------------------------------------------------
111201150928       //  DISCNT - Discount retrieval.
111301150928       // ----------------------------------------------------------------
111401150928       //
111501150928       BegSr DISCNT;
111601150928         //
111701150928         //  If customer discount is not entered on header screen either
111801150928         //  caluclate from HSPDISC file keyed on Order Value or default
111901150928         //  according to Customer Type.
112001150928         //
112101150928         If XJDISP = 0;
112201150928           //
112301150928           //  Setup key list for HSPDISC
112401150928           //
112501150928           PFAMT = XKTVAL;
112601150928           //
112701150928           //  SETLL on HSLDISCA
112801150928           //
112901150928           Setll (ECTYP : PFAMT) HSLDISCA;
112902150928           *IN99 = %Equal;
113001150928           //
113101150928           //  If record not found READP
113201150928           //
113301150928           If *IN99 = *OFF;
113401150928             ReadP HSLDISCA;
113402150928             *IN99 = %Eof;
113501150928             //
113601150928             //  If not BOF
113701150928             //
113801150928             If *IN99 = *OFF
113901150928               and PCTYP = ECTYP;
114001150928               KDISP = PDISC;
114101150928               //
114201150928               //  Else calculate discount according to Customer Type
114301150928               //
114401150928             Else;
114501150928               //
114601150928               Select;
114701150928                   //
114801150928                   //  If Customer Type is '001' - Z-ADD 10 to discount
114901150928                   //
115001150928                 When ECTYP = '001';
115101150928                   KDISP = 10;
115201150928                   //
115301150928                   //  If Customer Type is '002' - Z-ADD 20 to discount
115401150928                   //
115501150928                 When ECTYP = '002';
115601150928                   KDISP = 20;
115701150928                   //
115801150928               EndSl;
115901150928               //
116001150928             EndIf;
116101150928             //
116201150928             //  Record found on SETLL
116301150928             //
116401150928           Else;
116501150928             //
116601150928             KDISP = PDISC;
116701150928             //
116801150928           EndIf;
116901150928           //
117001150928           //  £JDISP not equal to 0
117101150928           //
117201150928         Else;
117301150928           KDISP = XJDISP;
117401150928           //
117501150928         EndIf;
117601150928         //
117701150928       EndSr;
117801150928       //
117901150928       // ----------------------------------------------------------------
118001150928       //  Check for minimum order value.
118101150928       // ----------------------------------------------------------------
118201150928       BegSr MINVAL;
118301150928         WKTOTV = 0;
118401150928         RRNP = 1;
118501150928         //
118601150928         //  Accumulate order total value
118701150928         DoU *IN99 = *ON
118801150928           or RRNP = 100
118901150928           or XSELC = *BLANK;
119001150928           Chain RRNP HSS200C;
119002150928           *IN99 = not %Found;
119101150928           If *IN99 = *OFF;
119201150928             WKTOTV += XKVALU;
119301150928           EndIf;
119401150928           RRNP += 1;
119501150928         EndDo;
119601150928         //
119701150928         //  Compare order total value and minimum order value
119801150928         If WKTOTV < MORDV;
119901150928           XERROR = XYES;
120001150928           P0MSID = 'HSV2011';
120101150928           Exsr YSNDMG;
120201150928         EndIf;
120301150928         RRNP = 1;
120401150928         RRNX = 1;
120501150928       EndSr;
120601150928       //
120701150928       // ----------------------------------------------------------------
120801150928       //  Ship to all delivery points.
120901150928       // ----------------------------------------------------------------
121001150928       BegSr SHPALL;
121101150928         //
121201150928         //  SETLL on HSLCUSTA with Customer Number
121301150928         //
121401150928         Setll XJCUST HSLCUSTA;
121501150928         //
121601150928         //  READE on HSLCUSTA with Customer Number
121701150928         //
121801150928         ReadE XJCUST HSLCUSTA;
121802150928         *IN99 = %Eof;
121901150928         //
122001150928         //  If not EOF
122101150928         //
122201150928         DoW *IN99 = *OFF;
122301150928           //
122401150928           //  If ECGRP not equal to blanks
122501150928           //
122601150928           If ECGRP <> *BLANKS;
122701150928             //
122801150928             //  CHAIN to Customer File for Delivery Name and Address
122901150928             //
123001150928             //           ECGRP     CHAINALTCUSTF             13
123101150928             //
123201150928             //           *IN13     IFEQ *OFF
123301150928             //
123401150928             //  Write Order Header Record
123501150928             //
123601150928             Exsr UPORDH;
123701150928             //
123801150928             //  Set up Delivery Name and Address
123901150928             //
124001150928             XVNAM1 = ENAM1;
124101150928             XVADR1 = EADR1;
124201150928             XVADR2 = EADR2;
124301150928             XVADR3 = EADR3;
124401150928             XVPCDE = EPCDE;
124501150928             //
124601150928             //  Write Order Delivery Record
124701150928             //
124801150928             Exsr UPODEL;
124901150928             //
125001150928             //  Write Order Detail Record
125101150928             //
125201150928             Exsr UPORDD;
125301150928             //
125401150928             //  ECGRP equal to blanks
125501150928             //
125601150928             //                     ENDIF
125701150928             //
125801150928             //  Customer Record not found
125901150928             //
126001150928           EndIf;
126101150928           //
126201150928           //  Increment order number
126301150928           //
126401150928           In *LOCK ORDERX;
126501150928           ORDERX += 1;
126601150928           Out ORDERX;
126701150928           XJSORD = ORDERX;
126801150928           //
126901150928           //  READE on HSLCUSTA with Customer Number
127001150928           //
127101150928           ReadE XJCUST HSLCUSTA;
127102150928           *IN99 = %Eof;
127201150928           //
127301150928         EndDo;
127401150928         //
127501150928         //  EOF on HSLCUSTA
127601150928         //
127701150928       EndSr;
127801150928       //
127901150928       // ----------------------------------------------------------------
128001150928       //  Update voucher control.
128101150928       // ----------------------------------------------------------------
128201150928       BegSr UPVCTL;
128301150928         //
128401150928         *IN85 = *ON;
128501150928         //  Save order line values
128601150928         //
128701150928         XQUAN = 0;
128801150928         XJUMP = XNO;
128901150928         //  Clear flag for successful range allocation.
129001150928         WKRANG = *Blanks;
129101150928         //
129201150928         //  Clear flag for first tracking record found.
129301150928         XFIRST = XNO;
129401150928         //
129501150928         //  Get Serial number range.
129601150928         WKSERC = *Blanks;
129701150928         DoU *IN92 = *ON
129801150928           or WKRANG = 'Y';
129901150928           //
130001150928           //  Work back through the subfile checking for duplicate
130101150928           //  product codes.... If found validate data under DOUB subroutine.
130201150928           //
130301150928           RRNXX = RRNX;
130401150928           DoU RRNX = 0;
130501150928             RRNX -= 1;
130601150928             If RRNX = 0;
130701150928               Leave;
130801150928             EndIf;
130901150928             Chain RRNX HSS200C;
130902150928             *IN90 = not %Found;
131001150928             If XKPROD = TPROD1;
131101150928               RRNX = RRNXX;
131201150928               Exsr DOUB;
131301150928               *IN81 = *ON;
131401150928               Leave;
131501150928             EndIf;
131601150928           EndDo;
131701150928           //
131801150928           //  Reset subfile position.....
131901150928           RRNX = RRNXX;
132001150928           Chain RRNX HSS200C;
132002150928           *IN90 = not %Found;
132101150928           //
132201150928           //  Exit from subroutine if DOUB sr has been processed....
132301150928           //
132401150928           If *IN81 = *ON;
132501150928             XKSERF = XKSERF;
132601150928             XKSERC = XKSERC;
132701150928             XKSERT = XKSERT;
132801150928             *IN81 = *OFF;
132901150928             Leave;
133001150928           EndIf;
133101150928           //
133201150928           Setll (XKPROD : WKSERC) HSLVCTLA;
133301150928           ReadE XKPROD HSLVCTLA;
133302150928           *IN92 = %Eof;
133401150928           //
133501150928           //  Move pointer file values into temporary fields....
133601150928           //
133701150928           OPROD = BPROD;
133801150928           OSERC = BSERCC;
133901150928           OSERN = BSERNN;
134001150928           WKSERN = BSERNN;
134101150928           WKSERC = BSERCC;
134201150928           XXSERF = BSERNN;
134301150928           // *******             SUB  1         ££SERF
134401150928           //
134501150928           //
134601150928           If *IN92 = *OFF;
134701150928             //
134801150928             //  Scan voucher tracking file for first available voucher....
134901150928             //
135001150928             XKSERC = BSERCC;
135101150928             XKSERF = OSERN;
135201150928             //
135301150928             DoU *IN94 = *ON
135401150928               or XQUAN = XKQTYN;
135501150928               //
135601150928               If *IN85 = *ON;
135701150928                 Setll (XKPROD : XKSERC : XKSERF) HSLTRACB;
135801150928                 *IN85 = *OFF;
135901150928               EndIf;
136001150928               //
136101150928               ReadE XKPROD HSLTRACB;
136102150928               *IN94 = %Eof;
136201150928               //
136301150928               If *IN94 = *ON;
136401150928                 Leave;
136501150928               EndIf;
136601150928               //
136701150928               If ASERC <> WKSERC
136801150928                 or ASERN <> WKSERN
136901150928                 or AALLD <> *ZEROS;
137001150928                 DSERN += 1;
137101150928                 //
137201150928                 If *IN87 = *OFF;
137301150928                   XXRES = XXSERN + 1;
137401150928                   //           XXRES     IFNE ASERN
137501150928                   //                     MOVE ASERN     ££SERF
137601150928                   //                     ELSE
137701150928                   XXSERF = ASERN;
137801150928                   XXSERF += 1;
137901150928                   WKSERN += 1;
138001150928                   *IN85 = *ON;
138101150928                   XKSERF += 1;
138201150928                   //                     ENDIF
138301150928                 Else;
138401150928                   //
138501150928                   //  No previous error so add to HSPEXPA.....
138601150928                   XXSERC = WKSERC;
138701150928                   XXSERN = WKSERN;
138801150928                   WKSERN -= 1;
138901150928                   XJUMP = XYES;
139001150928                   XJUMP1 = XYES;
139101150928                   //
139201150928                   // ***       *IN87     IFEQ *ON
139301150928                   USERNS = XXSERF;
139401150928                   USERNE = WKSERN;
139501150928                   USERCC = WKSERC;
139601150928                   UPROD = XKPROD;
139701150928                   Open HSLEXPAA;
139801150928                   Write HSFEXPA;
139901150928                   Close HSLEXPAA;
140001150928                   // ****                ENDIF
140101150928                   //
140201150928                   XXSERF = ASERN;
140301150928                   DSERN += 1;
140401150928                   If DSERN <> ASERN;
140501150928                     DIF = ASERN - DSERN;
140601150928                     XXSERF += DIF;
140701150928                   EndIf;
140801150928                   //
140901150928                   XKSERF += 1;
141001150928                   WKSERN += 2;
141101150928                   *IN85 = *ON;
141201150928                   *IN87 = *OFF;
141301150928                   //
141401150928                   If ASERC <> WKSERC;
141501150928                     WKSERC = ASERC;
141601150928                     WKSERN = ASERN;
141701150928                     XKSERC = WKSERC;
141801150928                     XKSERF = WKSERN;
141901150928                     XXSERF = WKSERN;
142001150928                     *IN85 = *ON;
142101150928                   EndIf;
142201150928                   //
142301150928                   Iter;
142401150928                 EndIf;
142501150928                 //
142601150928                 If ASERC <> WKSERC;
142701150928                   WKSERC = ASERC;
142801150928                   WKSERN = ASERN;
142901150928                   XKSERC = WKSERC;
143001150928                   XKSERF = WKSERN;
143101150928                   XXSERF = WKSERN;
143201150928                   *IN85 = *ON;
143301150928                 EndIf;
143401150928                 //
143501150928               EndIf;
143601150928               //
143701150928               //
143801150928               If AALLD = *ZEROS;
143901150928                 // **        *IN87     IFEQ *OFF
144001150928                 // **                  ADD  1         ££SERF
144101150928                 // **                  ENDIF
144201150928                 *IN87 = *ON;
144301150928                 XQUAN += 1;
144401150928                 XFIRST = XYES;
144501150928                 WKSERC = ASERC;
144601150928                 DSERN = ASERN;
144701150928                 WKSERN += 1;
144801150928                 XKSERF += 1;
144901150928                 *IN85 = *ON;
145001150928                 Iter;
145101150928               Else;
145201150928                 Iter;
145301150928               EndIf;
145401150928               //
145501150928             EndDo;
145601150928             //
145701150928             If XFIRST = XNO;
145801150928               XERROR = XYES;
145901150928               P0MSID = 'HSV2024';
146001150928               Exsr YSNDMG;
146101150928               Clear XKSERC;
146201150928               Clear XKSERT;
146301150928               Clear XKSERF;
146401150928               Leave;
146501150928             EndIf;
146601150928             //
146701150928             If XQUAN <> XKQTYN;
146801150928               XERROR = XYES;
146901150928               P0MSID = 'HSV2025';
147001150928               Exsr YSNDMG;
147101150928               Clear XKSERC;
147201150928               Clear XKSERT;
147301150928               Clear XKSERF;
147401150928               // ****                MOVE *ON       *IN52
147501150928               Leave;
147601150928             EndIf;
147701150928             //
147801150928             *IN52 = *ON;
147901150928             //
148001150928             If XJUMP = XYES;
148101150928               // **                  MOVE £YES      £ERROR
148201150928               P0MSID = 'HSV2026';
148301150928               Exsr YSNDMG;
148401150928               //
148501150928               WKSERN -= 1;
148601150928               WKRANG = 'Y';
148701150928               //
148801150928               // ****                MOVE XXSERC    £KSERC
148901150928               // ****                MOVE XXSERN    £KSERF
149001150928               // ****      TRCKEY    CHAINHSLTRACB             99
149101150928               // ****      *IN99     IFEQ *OFF
149201150928               // ****                ADD  1         ££SERF
149301150928               // ****                ENDIF
149401150928               //
149501150928               USERNS = XXSERF;
149601150928               USERNE = WKSERN;
149701150928               USERCC = WKSERC;
149801150928               Open HSLEXPAA;
149901150928               Write HSFEXPA;
150001150928               Close HSLEXPAA;
150101150928               //
150201150928               Clear XKSERC;
150301150928               Clear XKSERT;
150401150928               Clear XKSERF;
150501150928               Exsr YJUMP;
150601150928               *IN86 = *ON;
150701150928               *IN61 = *ON;
150801150928               Leave;
150901150928             EndIf;
151001150928             //
151101150928             //  Series code found.
151201150928             XKSERC = BSERCC;
151301150928             //
151401150928             XKSERF = OSERN;
151501150928             WKSERN -= 1;
151601150928             XKSERT = WKSERN;
151701150928             //
151801150928             //  Flag successful range allocation.
151901150928             WKRANG = 'Y';
152001150928             //
152101150928             //  Update if required.
152201150928           EndIf;
152301150928         EndDo;
152401150928         //
152501150928         //  Unsuccessful range allocation.
152601150928         If WKRANG <> 'Y';
152701150928           *In41 = '1';
152702150928           *In42 = '1';
152703150928           *In43 = '1';
152801150928           // ***                 MOVE £YES      £ERROR
152901150928           P0MSID = 'HSV2012';
153001150928           Exsr YSNDMG;
153101150928         EndIf;
153201150928         //
153301150928       EndSr;
153401150928       //
153501150928       // ----------------------------------------------------------------
153601150928       //  Display contents of HSLEXPAA
153701150928       // ----------------------------------------------------------------
153801150928       //
153901150928       BegSr YJUMP;
154001150928       EndSr;
154101150928       //
154201150928       //
154301150928       // ----------------------------------------------------------------
154401150928       //  Delete contents of HSLEXPAA
154501150928       // ----------------------------------------------------------------
154601150928       //
154701150928       BegSr YDELT;
154802150928         Pgm_HSC200A();
154901150928       EndSr;
155001150928       //
155101150928       // ----------------------------------------------------------------
155201150928       //  Repeat of Product Code in a single order
155301150928       // ----------------------------------------------------------------
155401150928       //
155501150928       BegSr DOUB;
155601150928         //
155701150928         //  Get Serial number range.
155801150928         WKSERC = *Blanks;
155901150928         DoU *IN92 = *ON
156001150928           or WKRANG = 'Y';
156101150928           //
156201150928           Setll (XKPROD : WKSERC) HSLVCTLA;
156301150928           ReadE XKPROD HSLVCTLA;
156302150928           *IN92 = %Eof;
156401150928           If *IN92 = *OFF;
156501150928             //
156601150928             //  Get available series code.
156701150928             XXSERN = BSERNN + TQTYN1;
156801150928             //           ££SERN    IFGT BSERNE
156901150928             //                     MOVELBSERCN    WKSERC
157001150928             Iter;
157101150928           Else;
157201150928             //
157301150928             //  Work back through the subfile searching for duplicate
157401150928             //  product code/series code combination records......
157501150928             //
157601150928             RRNXX = RRNX;
157701150928             DoU RRNX = 0;
157801150928               RRNX -= 1;
157901150928               If RRNX = 0;
158001150928                 *IN83 = *ON;
158101150928                 Leave;
158201150928               EndIf;
158301150928               Chain RRNX HSS200C;
158302150928               *IN90 = not %Found;
158401150928               If XKSERC = BSERCC;
158501150928                 RES = XKSERT + TQTYN1;
158601150928                 //           RES       IFLE BSERNE
158701150928                 KKSERC = XKSERC;
158801150928                 KKSERT = XKSERT;
158901150928                 Leave;
159001150928               Else;
159101150928                 *IN84 = *ON;
159201150928                 Leave;
159301150928               EndIf;
159401150928               //                     ENDIF
159501150928             EndDo;
159601150928             //
159701150928             //  Reset the subfile pointer position.....
159801150928             RRNX = RRNXX;
159901150928             Chain RRNX HSS200C;
159902150928             *IN90 = not %Found;
160001150928             //
160101150928             If *IN84 = *OFF
160201150928               and *IN83 = *OFF;
160301150928               //  Series code found.
160401150928               XKSERC = KKSERC;
160501150928               //
160601150928               //  Set To serial number for the order.
160701150928               XKSERT = RES;
160801150928               //
160901150928               //  Set From Serial Number for the order.
161001150928               XKSERF = KKSERT + 1;
161101150928               //
161201150928               //  Set Next Serial Number for the voucher control.
161301150928               BSERNN += TQTYN1;
161401150928               //
161501150928               //  Flag successful range allocation.
161601150928               WKRANG = 'Y';
161701150928               Iter;
161801150928             EndIf;
161901150928             //
162001150928             If *IN83 = *ON
162101150928               and *IN84 = *OFF;
162201150928               *IN83 = *OFF;
162301150928               //
162401150928               //  Series code found.
162501150928               XKSERC = BSERCC;
162601150928               //
162701150928               //  Set To serial number for the order.
162801150928               XKSERT = BSERNN + TQTYN1;
162901150928               XKSERT -= 1;
163001150928               //
163101150928               //  Set From Serial Number for the order.
163201150928               XKSERF = BSERNN;
163301150928               //
163401150928               //  Set Next Serial Number for the voucher control.
163501150928               BSERNN += TQTYN1;
163601150928               //
163701150928               //  Flag successful range allocation.
163801150928               WKRANG = 'Y';
163901150928               Iter;
164001150928             EndIf;
164101150928             *IN84 = *OFF;
164201150928             //                     MOVELBSERCN    WKSERC
164301150928             //
164401150928             //                     ENDIF
164501150928           EndIf;
164601150928         EndDo;
164701150928       EndSr;
164801150928       // ----------------------------------------------------------------
164901150928       //  Update voucher tracking.
165001150928       // ----------------------------------------------------------------
165101150928       BegSr UPTRAC;
165201150928         //
165301150928         //  Reverse order date before update.
165401150928         If YMODE = 'E';
165501150928           WKD = JDD;
165601150928           WKM = JMM;
165701150928           WKC = JCC;
165801150928           WKY = JYY;
165901150928           ADFIS = WKORDD;
166001150928         EndIf;
166101150928         //
166201150928         //  Locate voucher record.
166301150928         Setll (XKPROD : XKSERC : XKSERF) HSLTRACB;
166401150928         DoU XKPROD <> APROD
166501150928           or *IN99 = *ON;
166601150928           Read HSLTRACB;
166602150928           *IN99 = %Eof;
166701150928           If *IN99 = *OFF;
166801150928             //
166901150928             //  Exit if product code or series code does not match.
167001150928             If XKPROD <> APROD
167101150928               or XKSERC <> ASERC;
167201150928               Leave;
167301150928             EndIf;
167401150928             //
167501150928             //  Update vouchers in the serial number range.
167601150928             If XKSERF <= ASERN
167701150928               and XKSERT >= ASERN;
167801150928               If YMODE = 'D';
167901150928                 ACUST = XJCUST;
168001150928                 ADSPB = 0;
168101150928               Else;
168201150928                 //
168301150928                 ASORD = XJSORD;
168401150928                 ADFIS = WKORDD;
168501150928                 Update HSFTRAC;
168601150928               EndIf;
168701150928             EndIf;
168801150928           EndIf;
168901150928         EndDo;
169001150928       EndSr;
169101150928       //
169201150928       // ----------------------------------------------------------------
169301150928       //  Update inventory allocations.
169401150928       // ----------------------------------------------------------------
169501150928       BegSr UPINVA;
169601150928         //
169701150928         //  Update stock quantities.
169801150928         Chain (XKPROD : WKSUBC) HSLINVMA;
169802150928         *IN99 = not %Found;
169901150928         If *IN99 = *OFF;
170001150928           //
170101150928           //  Increase allocated quantity and reduce available quantity.
170201150928           DQTYR += XKQTYN;
170301150928           DQTYF -= XKQTYN;
170401150928           Update HSFINVM;
170501150928         EndIf;
170601150928       EndSr;
170701150928       //
170801150928       // ----------------------------------------------------------------
170901150928       //  Update inventory sales.
171001150928       // ----------------------------------------------------------------
171101150928       BegSr UPINVS;
171201150928         //
171301150928         //  Update stock quantities.
171401150928         Chain (XKPROD : WKSUBC) HSLINVMA;
171402150928         *IN99 = not %Found;
171501150928         If *IN99 = *OFF;
171601150928           //
171701150928           //  Reduce allocated quantity and reduce on-hand quantity.
171801150928           DQTYR -= XKQTYN;
171901150928           DQTYO -= XKQTYN;
172001150928           Update HSFINVM;
172101150928         EndIf;
172201150928       EndSr;
172301150928       //
172401150928       // ----------------------------------------------------------------
172501150928       //  Print delivery note.
172601150928       // ----------------------------------------------------------------
172701150928       BegSr PRTDEL;
172801150928         ORDPRM = %EditC(XJSORD:'X');
172902150928         Pgm_HSR230(ORDPRM);
173101150928       EndSr;
173201150928       //
173301150928       // ----------------------------------------------------------------
173401150928       //  Print invoice.
173501150928       // ----------------------------------------------------------------
173601150928       BegSr PRTINV;
173701150928         ORDPRM = %EditC(XJSORD:'X');
173802150928         Pgm_HSR220(ORDPRM);
174001150928       EndSr;
174101150928       //
174201150928       // ----------------------------------------------------------------
174301150928       //  Create order details.
174401150928       // ----------------------------------------------------------------
174501150928       BegSr UPORDD;
174601150928         //
174701150928         //  Order line already exists
174801150928         UPDAT = ' ';
174901150928         If XOLIN > 0;
175001150928           Chain (XJSORD : XOLIN) HSLORDDB;
175002150928           *IN98 = not %Found;
175101150928           KLINE = XOLIN;
175201150928         EndIf;
175301150928         //
175401150928         //  Write fields for order detail record.
175501150928         KLTYP = XSELC;
175601150928         KCOMP = XJCOMP;
175701150928         KTYPE = XJTYPE;
175801150928         KSORD = XJSORD;
175901150928         KLINE = RRNX;
176001150928         KCUST = XJCUST;
176101150928         KPROD = XKPROD;
176201150928         KSERC = XKSERC;
176301150928         KSERNF = XKSERF;
176401150928         KELEMF = 0;
176501150928         KSERNT = XKSERT;
176601150928         KELEMT = 0;
176701150928         KQTYN = XKQTYN;
176801150928         KCOST = NCOST;
176901150928         KPRIC = XKPRIC;
177001150928         KVALU = XKVALU;
177101150928         //
177201150928         //  Obtain VAT% from Order Type record.
177301150928         //           £KVALU    MULT .175      KVATA
177401150928         //           £KVALU    MULT MVATP     KVATA
177501150928         //           KVATA     DIV  100       KVATA     H
177601150928         KCRTD = CYMD;
177701150928         KCRTT = XXTME;
177801150928         %Subst(KDESC:1:19) = XNDESC;
177901150928         KCRTS = XJOBNO;
178001150928         KCRTU = XUSRID;
178101150928         KCRTP = XPGMID;
178201150928         KDELT = *Blanks;
178301150928         //
178401150928         //  Update order detail record.
178501150928         If XOLIN > 0;
178601150928           If *IN98 = *OFF;
178701150928             UPDAT = 'Y';
178801150928             Update HSFORDD;
178901150928           EndIf;
179001150928         Else;
179101150928           //
179201150928           //  Write order detail record.
179301150928           Write HSFORDD;
179401150928         EndIf;
179501150928       EndSr;
179601150928       //
179701150928       // ----------------------------------------------------------------
179801150928       //  Create order header.
179901150928       // ----------------------------------------------------------------
180001150928       BegSr UPORDH;
180101150928         //
180201150928         //  Program mode - Maintenance, or Dispatch
180301150928         If YMODE = 'M'
180401150928           or YMODE = 'D';
180501150928           //
180601150928           //  Access order header record.
180701150928           Chain XJSORD HSLORDHA;
180702150928           *IN99 = not %Found;
180801150928         EndIf;
180901150928         //
181001150928         //  Write fields for order header record.
181101150928         JCOMP = XJCOMP;
181201150928         JCUST = XJCUST;
181301150928         JCUSB = *Blanks;
181401150928         JORDR = XJORDR;
181501150928         JTYPE = XJTYPE;
181601150928         JSORD = XJSORD;
181701150928         JORDD = WKORDD;
181801150928         JINVN = *Blanks;
181901150928         JINVD = 0;
182001150928         JDELN = *Blanks;
182101150928         JDELD = 0;
182201150928         JCRTD = CYMD;
182301150928         JCRTT = XXTME;
182401150928         JCRTS = XJOBNO;
182501150928         JCRTU = XUSRID;
182601150928         JCRTP = XPGMID;
182701150928         JDELT = *Blanks;
182801150928         //
182901150928         //  Program mode - Entry
183001150928         If YMODE = 'E';
183101150928           //
183201150928           //  Write order header record.
183301150928           JSTAT = 'A';
183401150928           Write HSFORDH;
183501150928         EndIf;
183601150928         //
183701150928         //  Program mode - Maintenance, or Dispatch
183801150928         If YMODE = 'M'
183901150928           or YMODE = 'D';
184001150928           If YMODE = 'D';
184101150928             JDELD = *DATE;
184201150928             JSTAT = 'D';
184301150928           EndIf;
184401150928           //
184501150928           //  Update order header record.
184601150928           If *IN99 = *OFF;
184701150928             Update HSFORDH;
184801150928           EndIf;
184901150928         EndIf;
185001150928       EndSr;
185101150928       //
185201150928       // ----------------------------------------------------------------
185301150928       //  Create order delivery details.
185401150928       BegSr UPODEL;
185501150928         //
185601150928         //  Program mode - Maintenance, or Dispatch
185701150928         If YMODE = 'M'
185801150928           or YMODE = 'D';
185901150928           //
186001150928           Chain XJSORD HSFODEL;
186002150928           *IN99 = not %Found;
186101150928         EndIf;
186201150928         //
186301150928         //  Write fields for order delivery detail record.
186401150928         VCOMP = XJCOMP;
186501150928         VTYPE = XJTYPE;
186601150928         VSORD = XJSORD;
186701150928         VNAM1 = XVNAM1;
186801150928         VADR1 = XVADR1;
186901150928         VADR2 = XVADR2;
187001150928         VADR3 = XVADR3;
187101150928         VPCDE = XVPCDE;
187201150928         VDIN1 = XVDIN1;
187301150928         VDIN2 = XVDIN2;
187401150928         VDIN3 = XVDIN3;
187501150928         VDELT = *Blanks;
187601150928         //
187701150928         //  Program mode - Entry
187801150928         If YMODE = 'E';
187901150928           //
188001150928           //  Write order delivery details record.
188101150928           Write HSFODEL;
188201150928         EndIf;
188301150928         //
188401150928         //  Program mode - Maintenance, or Dispatch
188501150928         If YMODE = 'M'
188601150928           or YMODE = 'D';
188701150928           //
188801150928           //  Update order delivery details record.
188901150928           If *IN99 = *OFF;
189001150928             Update HSFODEL;
189101150928           EndIf;
189201150928         EndIf;
189301150928         //
189401150928       EndSr;
189501150928       // ----------------------------------------------------------------
189601150928       //  Create inventory sales transaction.
189701150928       // ----------------------------------------------------------------
189801150928       BegSr UPINVT;
189901150928         //
190001150928         //  Write fields for inventory sales transaction record.
190101150928         CCOMP = XJCOMP;
190201150928         CWHSE = XJWHSE;
190301150928         CPROD = XKPROD;
190401150928         CSUBCF = *Blanks;
190501150928         CSUBCT = *Blanks;
190601150928         CVTYP = *Blanks;
190701150928         CSERC = XKSERC;
190801150928         CSERNF = XKSERF;
190901150928         CELEMF = 0;
191001150928         CSERNT = XKSERT;
191101150928         CELEMT = 0;
191201150928         CQTYN = XKQTYN;
191301150928         CBATC = 0;
191401150928         CDELN = %EditC(XJSORD:'X');
191501150928         CREAS = *Blanks;
191601150928         CTDAT = CYMD;
191701150928         CTYPE = MTTYP;
191801150928         CSUPP = *Blanks;
191901150928         CCUST = XJCUST;
192001150928         CAREA = *Blanks;
192101150928         CAISL = *Blanks;
192201150928         CBAYR = *Blanks;
192301150928         CLEVL = *Blanks;
192401150928         CINVN = *Blanks;
192501150928         CCRTD = CYMD;
192601150928         CCRTT = XXTME;
192701150928         CCRTS = XJOBNO;
192801150928         CCRTU = XUSRID;
192901150928         CCRTP = XPGMID;
193001150928         CDELT = *Blanks;
193101150928         //
193201150928         //  Write inventory sales transaction record.
193301150928         Write HSFINVT;
193401150928       EndSr;
193501150928       //
193601150928       // ----------------------------------------------------------------
193701150928       //  VALIDH - Validate header screen.
193801150928       // ----------------------------------------------------------------
193901150928       //
194001150928       BegSr VALIDH;
194101150928         //
194201150928         //  Screen Header validation:
194301150928         //
194401150928         //  Reset work values.
194501150928         Reset XERROR;
194601150928         *IN61 = *OFF;                                                          // Hide F10/F11
194701150928         //
194801150928         //  Reset error indicators.
194901150928         pAToArrStr = %Addr(*IN(30));
194902150928         %Subst(AToArrStr:1:19) = XZEROS;
195001150928         //
195101150928         //  Validate that Order Type is a valid Type.
195201150928         Chain XJTYPE HSLORDPA;
195202150928         *IN99 = not %Found;
195301150928         If *IN99 = *ON;
195401150928           *IN30 = *ON;
195501150928           XERROR = XYES;
195601150928           P0MSID = 'HSV2001';
195701150928           Exsr YSNDMG;
195801150928         EndIf;
195901150928         //
196001150928         //  Validate that Company is valid.
196101150928         If XJCOMP <> *BLANKS;
196201150928           Chain XJCOMP HSLCOMPA;
196202150928           *IN99 = not %Found;
196301150928           If *IN99 = *ON;
196401150928             *IN31 = *ON;
196501150928             XERROR = XYES;
196601150928             P0MSID = 'HSV2002';
196701150928             Exsr YSNDMG;
196801150928           EndIf;
196901150928         EndIf;
197001150928         //
197101150928         //  Validate that Warehouse is valid.
197201150928         If XJWHSE <> *BLANKS;
197301150928           Chain XJWHSE HSLWHSEA;
197302150928           *IN99 = not %Found;
197401150928           If *IN99 = *ON;
197501150928             *IN32 = *ON;
197601150928             XERROR = XYES;
197701150928             P0MSID = 'HSV0006';
197801150928             Exsr YSNDMG;
197901150928           EndIf;
198001150928         EndIf;
198101150928         //
198201150928         //  Validate Post Code
198301150928         If XJCUST = *BLANKS;
198401150928           If XJPCDE <> *BLANKS;
198501150928             Chain XJPCDE HSLCUSTB;
198502150928             *IN99 = not %Found;
198601150928             If *IN99 = *ON;
198701150928               *IN33 = *ON;
198801150928               XERROR = XYES;
198901150928               P0MSID = 'HSV2003';
199001150928               Exsr YSNDMG;
199101150928             EndIf;
199201150928             //
199301150928             //  If Customer is found
199401150928             If *IN99 = *OFF;
199501150928               //  ...load Customer record into screen fields.
199601150928               XJNAM1 = ENAM1;                                                  // Name 1
199701150928               XJNAM2 = ENAM2;                                                  // Name 2
199801150928               XJADR1 = EADR1;                                                  // Address 1
199901150928               XJADR2 = EADR2;                                                  // Address 2
200001150928               XJCUST = ECUST;                                                  // Cust No.
200101150928               XJCLIM = ECLIM;                                                  // Credit Limit
200201150928               XJTYSL = ETYSL;                                                  // Last Year Sales
200301150928             EndIf;
200401150928             //
200501150928           EndIf;
200601150928         EndIf;
200701150928         //
200801150928         //  Validate Customer Number
200901150928         //           £JCUST    IFNE *BLANKS
201001150928         Chain XJCUST HSLCUSTA;
201002150928         *IN99 = not %Found;
201101150928         If *IN99 = *ON;
201201150928           *IN34 = *ON;
201301150928           XERROR = XYES;
201401150928           P0MSID = 'HSV2004';
201501150928           Exsr YSNDMG;
201601150928         EndIf;
201701150928         //
201801150928         //  If Customer is found
201901150928         If *IN99 = *OFF;
202001150928           //  ...load Customer record into screen fields.
202101150928           XJNAM1 = ENAM1;                                                      // Name 1
202201150928           XJNAM2 = ENAM2;                                                      // Name 2
202301150928           XJADR1 = EADR1;                                                      // Address 1
202401150928           XJADR2 = EADR2;                                                      // Address 2
202501150928           XJPCDE = EPCDE;                                                      // Post Code
202601150928           XJCLIM = ECLIM;                                                      // Credit Limit
202701150928           XJTYSL = ETYSL;                                                      // Last Year Sales
202801150928           //
202901150928           //  Check customer's credit rating allows order entry......
203001150928           If ECRAT = '01 ';
203101150928             *IN34 = *ON;
203201150928             XERROR = XYES;
203301150928             P0MSID = 'HSV2018';
203401150928             Exsr YSNDMG;
203501150928           EndIf;
203601150928           //
203701150928         EndIf;
203801150928         //                     ENDIF
203901150928         //
204001150928         //  Maximum discount is 40%
204101150928         If XJDISP > 40;
204201150928           *IN36 = *ON;
204301150928           XERROR = XYES;
204401150928           P0MSID = 'HSV0142';
204501150928           Exsr YSNDMG;
204601150928         EndIf;
204701150928         //
204801150928         //  Check order date
204901150928         If XJORDD = 0;
205001150928           Exsr YDATEC;
205101150928         Else;
205201150928           //
205301150928           //  a) Check for leap year and adjust number of days in February
205401150928           //     in Days in Month array.
205501150928           REM = JYY / 4;
205601150928           If REM = 0;
205701150928             LEAP = 'Y';
205801150928           Else;
205901150928             LEAP = ' ';
206001150928           EndIf;
206101150928           Select;
206201150928             When LEAP = ' ';
206301150928               DIM(2) = 28;
206401150928             When LEAP = 'Y';
206501150928               DIM(2) = 29;
206601150928           EndSl;
206701150928           //  Day
206801150928           If JDD > 31
206901150928             or JDD < 01
207001150928             //  Month
207101150928             or JMM > 12
207201150928             or JMM < 01;
207301150928             //
207401150928             //  If date error found...
207501150928             *IN35 = *ON;
207601150928             XERROR = XYES;
207701150928             P0MSID = 'HSV2005';
207801150928             Exsr YSNDMG;
207901150928           EndIf;
208001150928           //
208101150928           //  Validate Day within month.
208201150928           M = JMM;
208301150928           If JDD < 1
208401150928             or JMM >= 1
208501150928             and JMM <= 12
208601150928             and JDD > DIM(M);
208701150928             //
208801150928             //  If date error found...
208901150928             *IN35 = *ON;
209001150928             XERROR = XYES;
209101150928             P0MSID = 'HSV2005';
209201150928             Exsr YSNDMG;
209301150928           EndIf;
209401150928         EndIf;
209501150928         //
209601150928         //  If no errors found...
209701150928         If XERROR = XNO;
209801150928           //  ...display "Data valid.Press F10 to update" message...
209901150928           P0MSID = 'HSV9006';
210001150928           Exsr YSNDMG;
210101150928           //  ...activate F10 key (*IN61=*ON).
210201150928           *IN61 = *ON;
210301150928         EndIf;
210401150928         //
210501150928       EndSr;
210601150928       //
210701150928       // ----------------------------------------------------------------
210801150928       //  ‡DATEC - Date Check Routine
210901150928       // ----------------------------------------------------------------
211001150928       //
211101150928       BegSr YDATEC;
211201150928         //
211301150928         //  Convert six-digit system date to eight digits, with century.
211401150928         DD = UDAY;
211501150928         MM = UMONTH;
211601150928         YY = UYEAR;
211701150928         If YY > 80;
211801150928           CC = 19;
211901150928         Else;
212001150928           CC = 20;
212101150928         EndIf;
212201150928         CCYY = %Dec(%EditC(CC:'X')
212202150928                 + %Subst(%EditC(CCYY:'X'):3:2)
212203150928                 :4:0);
212301150928         CCYY = %Dec(%Subst(%EditC(CCYY:'X'):1:2)
212302150928                + %EditC(YY:'X')
212303150928                   :4:0);
212401150928         //
212501150928         //  Set default date for order entry.
212601150928         If XJORDD = 0;
212701150928           XJORDD = DMCY;
212801150928         EndIf;
212901150928         //
213001150928         //  Set date for transaction audit field.
213101150928         DDD = DD;
213201150928         MMM = MM;
213301150928         CCC = CC;
213401150928         YYY = YY;
213501150928       EndSr;
213601150928       //
213701150928       // ----------------------------------------------------------------
213801150928       //  ‡SERCH - F4 prompt control.
213901150928       // ----------------------------------------------------------------
214001150928       //
214101150928       BegSr YSERCH;
214201150928         //
214301150928         //  Check that cursor is in a valid field for prompting.
214401150928         If CSRRCD = 'HSS200A'
214501150928           and CSRFLD = 'XJCUST'
214601150928           or CSRRCD = 'HSS200A'
214701150928           and CSRFLD = 'XJTYPE'
214801150928           or CSRRCD = 'HSS200A'
214901150928           and CSRFLD = 'XJCOMP'
215001150928           or CSRRCD = 'HSS200A'
215101150928           and CSRFLD = 'XJWHSE'
215201150928           or CSRRCD = 'HSS200A'
215301150928           and CSRFLD = 'XJPCDE'
215401150928           or CSRRCD = 'HSS200C'
215501150928           and CSRFLD = 'XKPROD';
215601150928           //
215701150928           //  Move appropriate data to parameter fields depending upon search
215801150928           //  field chosen.
215901150928           Select;
216001150928               //
216101150928               //  Customer No.
216201150928             When CSRFLD = 'XJCUST';
216301150928               FILEY = 'HSLCUSTA';
216401150928               NAMEY = 'ENAM1';
216501150928               NUMBRY = 'ECUST';
216601150928               //
216701150928               //  Post Code
216801150928             When CSRFLD = 'XJPCDE';
216901150928               FILEY = 'HSLCUSTB';
217001150928               NAMEY = 'ENAM1';
217101150928               NUMBRY = 'EPCDE';
217201150928               //
217301150928               //  Order Type.
217401150928             When CSRFLD = 'XJTYPE';
217501150928               FILEY = 'HSLORDPA';
217601150928               NAMEY = 'MODES';
217701150928               NUMBRY = 'MOTYP';
217801150928               //
217901150928               //  Company Code
218001150928             When CSRFLD = 'XJCOMP';
218101150928               FILEY = 'HSLCOMPA';
218201150928               NAMEY = 'WODES';
218301150928               NUMBRY = 'WCOMP';
218401150928               //
218501150928               //  Warehouse Code
218601150928             When CSRFLD = 'XJWHSE';
218701150928               FILEY = 'HSLWHSEA';
218801150928               NAMEY = 'PODES';
218901150928               NUMBRY = 'PWHSE';
219001150928               //
219101150928               //  Product Code
219201150928             When CSRFLD = 'XKPROD';
219301150928               FILEY = 'HSLPRODA';
219401150928               NAMEY = 'NDESC';
219501150928               NUMBRY = 'NPROD';
219601150928               //
219701150928           EndSl;
219801150928           //
219901150928           //  Call system window program to retrieve data.  If Return Code is
220001150928           //  *OFF then load retrieved data into screen fields.
220101150928           LINY = 10;
220201150928           COLY = 8;
220302150928           Pgm_HSR341(YRTNC : YNUMBR : FILEY : NAMEY :
220303150928                 NUMBRY : LINY : COLY);
220401150928           //
220501150928           //  If Return Code is *OFF then load retrieved data into
220601150928           //  appropriate screen fields.
220701150928           If YRTNC = *OFF;                                                     // ..If2
220801150928             //
220901150928             Select;
221001150928                 //
221101150928                 //  Customer No.
221201150928               When CSRFLD = 'XJCUST';
221301150928                 XJCUST = YNUMBR;
221401150928                 //
221501150928                 //  Post Code
221601150928               When CSRFLD = 'XJPCDE';
221701150928                 XJPCDE = YNUMBR;
221801150928                 //
221901150928                 //  Customer Type.
222001150928               When CSRFLD = 'XJTYPE';
222101150928                 XJTYPE = YNUMBR;
222201150928                 //
222301150928                 //  Company Code
222401150928               When CSRFLD = 'XJCOMP';
222501150928                 XJCOMP = YNUMBR;
222601150928                 //
222701150928                 //  Warehouse Code
222801150928               When CSRFLD = 'XJWHSE';
222901150928                 XJWHSE = YNUMBR;
223001150928                 //
223101150928                 //  Product Code
223201150928               When CSRFLD = 'XKPROD';
223301150928                 XKPROD = YNUMBR;
223401150928                 //
223501150928             EndSl;
223601150928           EndIf;                                                               // ..EndIf2
223701150928           //
223801150928           //  otherwise cursor is in wrong format/field so display message.
223901150928         Else;                                                                  // .ElseIf1
224001150928           P0MSID = 'HSV9009';
224101150928           Exsr YSNDMG;
224201150928         EndIf;                                                                 // .EndIf1
224301150928         //
224401150928       EndSr;
224501150928       //
224601150928       // ----------------------------------------------------------------
224701150928       //  ‡SERSF - F4 prompt control for order detail subfile.
224801150928       // ----------------------------------------------------------------
224901150928       //
225001150928       BegSr YSERSF;
225101150928         //  Clear row / column control.
225201150928         CSRROW = 0;
225301150928         CSRCOL = 0;
225401150928         //
225501150928         //  Retrieve the current cursor position.
225601150928         ROW = CSRLOC / 256;
225701150928         COL = %Rem(CSRLOC : 256);
225801150928         CSRROW = ROW;
225901150928         CSRCOL = COL;
226001150928         //
226101150928         //  Execute search.
226201150928         Exsr YSERCH;
226301150928         //
226401150928         //  Flag subfile record to return value.
226501150928         Chain CSRRRN HSS200C;
226502150928         *IN99 = not %Found;
226601150928         If *IN99 = *OFF;
226701150928           *IN37 = *ON;
226801150928           If YNUMBR <> *BLANKS;
226901150928             XKPROD = YNUMBR;
227001150928           EndIf;
227101150928           Update HSS200C;
227201150928           *IN37 = *OFF;
227301150928         EndIf;
227401150928       EndSr;
227501150928       //
227601150928       // ----------------------------------------------------------------
227701150928       //  ‡SNDMG - Send message to this program's MSGQ.
227801150928       // ----------------------------------------------------------------
227901150928       //
228001150928       BegSr YSNDMG;
228101150928         //
228202150928         Pgm_SNDMSGC(P0PGMQ : P0PGRL : P0MSID : P0MSGF :
228203150928               P0MSDA : P0MSTP);
228901150928         //
229001150928       EndSr;
229101150928       //
229201150928       // ----------------------------------------------------------------
229301150928       //  ‡CLRMG - Clear message(s) from this program's MSGQ.
229401150928       // ----------------------------------------------------------------
229501150928       //
229601150928       BegSr YCLRMG;
229701150928         //
229802150928         Pgm_RMVMSGC();
229901150928         //
230001150928       EndSr;
230101150928       //
230201150928       // ----------------------------------------------------------------
230301150928       //  *UPPVCT- Update the voucher control
230401150928       // ----------------------------------------------------------------
230501150928       //
230601150928       BegSr UPPVCT;
230701150928         RRNQ = 1;
230801150928         Chain RRNQ HSS200C;
230802150928         *IN97 = not %Found;
230901150928         DoW *IN97 = *OFF;
231001150928           //
231101150928           RRNQ += 1;
231201150928           If XSELC <> *BLANK
231301150928             or XKPROD <> *BLANK
231401150928             or XNDESC <> *BLANK
231501150928             or XKPRIC <> *ZEROS
231601150928             or XKQTYN <> *ZEROS
231701150928             or XKVALU <> *ZEROS
231801150928             or XKVATA <> *ZEROS
231901150928             or XKSERC <> *BLANKS
232001150928             or XKSERF <> *ZEROS
232101150928             or XKSERT <> *ZEROS;
232201150928             WKSERC = XKSERC;
232301150928             TEMP = XKSERT;
232401150928             TEMP += 1;
232501150928             Setll (XKPROD : WKSERC) HSLVCTLA;
232601150928             ReadE XKPROD HSLVCTLA;
232602150928             *IN92 = %Eof;
232701150928             BSERNN = TEMP;
232801150928             Update HSFVCTL;
232901150928           EndIf;
233001150928           //
233101150928           If RRNQ = 100;
233201150928             Leave;
233301150928           EndIf;
233401150928           Chain RRNQ HSS200C;
233402150928           *IN97 = not %Found;
233501150928         EndDo;
233601150928       EndSr;
233701150928       //
233801150928       // ----------------------------------------------------------------
233901150928       //  *INZSR - Initialization.
234001150928       // ----------------------------------------------------------------
234101150928       //
234201150928       BegSr *INZSR;
234301150928         //
234401150928         //  Dummy read to open file.
234501150928         Read HSPINVT;
234502150928         *IN99 = %Eof;
234601150928         Update HSFINVT;
234701150928         Open HSLEXPAA;
234801150928         Read HSLEXPAA;
234802150928         *IN99 = %Eof;
234901150928         Close HSLEXPAA;
235001150928         //
235101150928         //  Key lists.
235201150928         //  Key List for Voucher Control.
235601150928         //
235701150928         //  Key List for Voucher Cross-Reference.
236201150928         //
236301150928         //  Key List for Sales Order.
236701150928         //
236801150928         //  Key List for Inventory Masterfile.
237201150928         WKSUBC = *Blanks;
237301150928         //
237401150928         //  Key List for Voucher Tracking.
237901150928         //
238001150928         //  Key List for Customer Discount File.
238401150928         //
238501150928         //  Parameter Lists.
238601150928         //  Entry parameter list.
239201150928         //
239301150928         //  List for Call to HSR341 - Search program.
240201150928         //
240301150928         //  Field definitions
241201150928         //
241301150928         //  Variable declarations.
241401150928         XNO = '0';
241501150928         XYES = '1';
241601150928         XERROR = XNO;
241701150928         XUPDAT = XNO;
241801150928         XDELET = XNO;
241901150928         ORDPRM = *Blanks;
242001150928         RCDNBR = 1;
242101150928         RRNX = 0;
242201150928         RRNVAL = 0;
242301150928         RRNLIN = 0;
242401150928         RRNQ = 0;
242501150928         RRNP = 0;
242601150928         //
242701150928         //  Prepare message subfile.
242801150928         *IN79 = *ON;
242901150928         P0PGMQ = XPGMID;                                                       // Program queu
243001150928         %Subst(P0PGRL:1:4) = '*PRV';                                           // Rel queue
243101150928         P0MSID = *Blanks;                                                      // Message ID
243201150928         %Subst(P0MSGF:1:6) = 'HSM001';                                         // Message file
243301150928         P0MSDA = *Blanks;                                                      // Message data
243401150928         %Subst(P0MSTP:1:5) = '*INFO';                                          // Message type
243501150928         //
243601150928         Exsr YDATEC;
243701150928         //
243801150928       EndSr;
243901990215** Days in Month array DIM.
244001990215312831303130313130313031
