000001888888      *%CSTD===========================================================*
000002888888      ** Application. : SAM        Arcad Sample application            *
000003888888      ** Component. . : HSR200                        Type: RPGLE      *
000004888888      **===============================================================*
000005888888      ** Sub-system . : TRD Trade                                      *
000006888888      ** Function . . : SAL Sales                                      *
000007888888      ** Sub-function :                                                *
000008888888      **%S=============================================================*
000009141015      ** Description of functions:                                     *
000011150422      **                                                               *
000012888888      **                                                               *
000013888888      **                                                               *
000014888888      **%E=============================================================*
000015888888      ** AUTHOR:                          00:00                        *
000016888888      ** MODIFS: 07 JTICKNER   10/15/2014 14:56  V 1.00.P MR 14/   32  *
000017888888      **           My task                                             *
000018888888      **           =====> Type RPG        changed to RPGLE      <===== *
000019888888      **         06 RBERNARDI  10/07/2014 16:44  V 1.00.N MR 14/   26  *
000020888888      **           ARCAD Build CHeck                                   *
000021888888      **         05 RBERNARDI  09/26/2014 18:10  V 1.00.M MR 14/   31  *
000022888888      **           Performance testing (Multiple iProject)             *
000023888888      **         04 MMARREL    09/15/2014 10:36  V 1.00.L MR 14/   30  *
000024888888      **           Rld change                                          *
000025888888      **         03 MMARREL    07/03/2014 11:50  V 1.00.I MR 14/   29  *
000026888888      **           genius                                              *
000027888888      **         02 MMARREL    05/23/2014 10:03  V 1.00.G MR 14/   22  *
000028888888      **           MCH0001 when loading program                        *
000029888888      **         ** RBERNARDI  10/15/2014   :    V 1.00.E MR 14/   22  *
000030888888      **         01 ARCAD_PGMR 07/28/2000 12:13  V 1.00.B MR 14/   22  *
000031888888      *%ECSTD==========================================================*
000032140523      *%EXEC OVRDBF INTFILE EXTFILE
000033150818      * %ATTR TGTRLS(*CURRENT)
003101990122      */TITLE Sales Order Entry / Maintenance / Inquiry
003201990106      *
003301990106      * System        : HSV Control & Tracking
003401990122      * Author        : Bob Lee (Intec Systems)
003501990106      * Date          : January 1999
003601990106      *
003701990106      *================================================================
003801990106      * Indicator usage:
003901990219      *  20 - Order Valid for Despatch
004001990128      *  30 - 45 Input fields- DSPATR.
004101990128      *  62 - Control display/non-display of F10-Update.
004201990210      *  75 - 78 Program mode - Dispatch/Entry/Inquiry/Maintenance
004301990128      *  79 - MSGSFL (SFLCLR ETC...).
004401990106      *  99 - General CHAIN/SETLL result.
004501990106      *
004601990106      *================================================================
004701990106      * Maintenance   :
004801990106      * Fix/Chg Ref. Date       Description.
004901990106      * ------------ ---------- -----------------------------------
005001990106      *================================================================
005301140523      *
005401990222     H DATEDIT(*YMD)
005501990125     FHSLCUSTB  IF   E           K DISK
005601150928     F                                     RENAME(HSFCUST:HSFCUSTB)
005701990125      * Customer Master by Post Code.
005801990125      *
005901140915     FHSLCUSTA  IF   E           K DISK
006001990125      * Customer Master by Customer Account.
006101990106      *
006201990318     F*LTCUSTAIF  E           K        DISK
006301990318     F*           HSFCUST                           KRENAMEALTCUSTF
006401990216      * Customer Master by Customer Account.
006501990216      *
006601990122     FHSLORDPA  IF   E           K DISK
006701990122      * Sales Order Parameters.
006801990114      *
006901990128     FHSLTRACB  UF   E           K DISK
007001990203      * Voucher Tracking by Product/Series/Serial No./Element No.
007101990302      *
007201990302     FHSLEXPAA  UF A E           K DISK    USROPN
007301990302      * Unbanded Order line file by Product/Series/Serial No.
007401990122      *
007501990127     FHSLVCTLA  UF   E           K DISK
007601990122      * Voucher Control.
007701990122      *
007801990223     FHSLVXRFB  IF   E           K DISK
007901990122      * Agency Product Cross-Reference.
008001990122      *
008101990203     FHSLORDHA  UF A E           K DISK
008201990122      * Sales Order Header.
008301990122      *
008401990211     FHSLORDDB  UF A E           K DISK
008501990122      * Sales Order Detail.
008601990122      *
008701990204     FHSLODELA  UF A E           K DISK
008801990122      * Sales Order Delivery Detail.
008901990122      *
009001990125     FHSLSHPOA  IF   E           K DISK
009101990122      * Ship Only.
009201990302      *
009301990128     FHSLINVMA  UF   E           K DISK
009401990122      * Inventory Master.
009501990122      *
009601990125     FHSLWHSEA  IF   E           K DISK
009701990122      * Warehouse Master.
009801990122      *
009901990125     FHSLCOMPA  IF   E           K DISK
010001990122      * Company Master.
010101990122      *
010201990126     FHSLPRODA  IF   E           K DISK
010301990122      * Product Master.
010401990122      *
010501990215     FHSLDISCA  IF   E           K DISK
010601990215      * Customer Discount File
010701990215      *
010801990217BL   FHSPINVT   UF A E           K DISK
010901990122      * Inventory Transactions.
011001990122      *
011101060315BL   FARTICLE   IF   E           K DISK
011201060315      * FOR ARTCILE XREF
011301060315      *
011401990122     FHSS200    CF   E             WORKSTN INFDS(INFDS)
011501000728     F                                     SFILE(HSS200C:RRNX)
011601990106      * Screen file.
011701990106      *================================================================
011801990107      * Arrays.
011901990107      *
012001990215      * Days in Month for date validation.
012101990215     D DIM             S              2  0 DIM(12) CTDATA PERRCD(12)
012201990107      *================================================================
012301990301      * Data Structures.
012401990106      *
012501990106      * Screen Information DS.
012601990106     D INFDS           DS
012701990106     D  KEY                  369    369
012801990127     D  CSRLOC               370    371B 0
012901990106      *
013001000728     D XXXSDS         SDS           429
013101000728     D  XPGMID           *PROC
013201000728     D  XJOBNO               244    253
013301000728     D  XUSRID               254    263
013401990125      *
013501990121      * General DDMMCCYY date format.
013601990121     D                 DS
013701990204     D  DD                     1      2  0 INZ
013801990204     D  MM                     3      4  0 INZ
013901990204     D  CC                     5      6  0 INZ
014001990204     D  YY                     7      8  0 INZ
014101990125     D  DMCY                   1      8  0
014201990128      *
014301990128      * General CCYYMMDD date format.
014401990128     D                 DS
014501990204     D  CCC                    1      2  0 INZ
014601990204     D  YYY                    3      4  0 INZ
014701990204     D  MMM                    5      6  0 INZ
014801990204     D  DDD                    7      8  0 INZ
014901990128     D  CYMD                   1      8  0
015001990106      *
015101990128      * Input order date format.
015201990125     D                 DS
015301990126     D  JDD                    1      2  0 INZ
015401990126     D  JMM                    3      4  0 INZ
015501990126     D  JCC                    5      6  0 INZ
015601990126     D  JYY                    7      8  0 INZ
015701000728     D  XJORDD                 1      8  0
015801990125      *
015901990128      * Output order date format.
016001990128     D                 DS
016101990204     D  WKC                    1      2  0 INZ
016201990204     D  WKY                    3      4  0 INZ
016301990204     D  WKM                    5      6  0 INZ
016401990204     D  WKD                    7      8  0 INZ
016501990128     D  WKORDD                 1      8  0
016601990128      *
016701990106      *----------------------------------------------------------------
016801990106      * Constants.
016901990106      *
017001990106      * Named hexidecimal constants for function keys.
017101990106     D F03             C                   CONST(X'33')
017201990106     D F04             C                   CONST(X'34')
017301990106     D F06             C                   CONST(X'36')
017401990219     D F07             C                   CONST(X'37')
017501990203     D F10             C                   CONST(X'3A')
017601990106     D F11             C                   CONST(X'3B')
017701990113     D F12             C                   CONST(X'3C')
017801990119      *
017901990119      * Zeros to "SETOF" error indicators.
018001000728     D XZEROS          C                   CONST('0000000000000000000')
018101990106      *
018201990106      *================================================================
018301990106      * M A I N L I N E
018401990106      *================================================================
018501990210      *
018601990210      * Dispatch mode
018701000728     C     YMODE         IFEQ      'D'
018801990210     C                   MOVEL     *ON           *IN75
018802150422     C                   MOVEL     *OFF          *IN79
018901990210     C                   ELSE
019001990210     C                   MOVEL     *OFF          *IN75
019101990210     C                   ENDIF
019201060315     C                   READ      ARTICLE                                99
019301990210      *
019401990210      * Entry mode
019501000728     C     YMODE         IFEQ      'E'
019601990210     C                   MOVEL     *ON           *IN76
019701990210     C                   ELSE
019801990210     C                   MOVEL     *OFF          *IN76
019901990210     C                   ENDIF
020001990120      *
020101990203      * Inquiry mode
020201000728     C     YMODE         IFEQ      'I'
020301990203     C                   MOVEL     *ON           *IN77
020401990203     C                   ELSE
020501990203     C                   MOVEL     *OFF          *IN77
020601990203     C                   ENDIF
020701990205      *
020801150422      * Maintenance mode       changesfordemo
020901000728     C     YMODE         IFEQ      'M'
021001990205     C                   MOVEL     *ON           *IN78
021101990205     C                   ELSE
021201990205     C                   MOVEL     *OFF          *IN78
021301990205     C                   ENDIF
021401990205      *
021501990203      * Program mode
021601990226     C     START         TAG
021701000728     C     YMODE         IFEQ      'I'
021801000728     C     YMODE         OREQ      'D'
021901000728     C     YMODE         OREQ      'M'
022001000728     C     YORDNO        IFNE      *BLANKS
022101000728     C                   MOVEL     YORDNO        XJSORD
022201000728     C                   MOVEL     YORDNO        WKORDN            8 0
022301990203     C     WKORDN        CHAIN     HSLORDHA                           99
022401990203     C                   ENDIF
022501990203     C                   ENDIF
022601990203      *
022701000728     C     YMODE         IFEQ      'D'
022801000728     C                   MOVE      JTYPE         XJTYPE
022901000728     C                   MOVE      JCUST         XJCUST
023001990219     C                   Z-ADD     JORDD         WKORDD
023101990219     C                   Z-ADD     WKC           JCC
023201990219     C                   Z-ADD     WKY           JYY
023301990219     C                   Z-ADD     WKM           JMM
023401990219     C                   Z-ADD     WKD           JDD
023501000728     C                   MOVE      JORDR         XJORDR
023601000728     C                   MOVE      JSORD         XJSORD
023701990219     C     JSTAT         IFEQ      'A'
023801990219     C     JSTAT         OREQ      ' '
023901990219     C                   MOVE      *ON           *IN20
024001990219     C                   ELSE
024101990219     C                   MOVE      *OFF          *IN20
024201990219     C                   MOVEL     'HSV2015'     P0MSID
024301000728     C                   EXSR      YSNDMG
024401990219     C                   ENDIF
024501990216     C     JCUST         CHAIN     HSLCUSTA                           13
024601000728     C                   MOVE      EPCDE         XJPCDE
024701000728     C                   MOVE      ENAM1         XENAM1
024801990216     C     JSORD         SETLL     HSLORDDB
024901990216     C     JSORD         READE     HSLORDDB                               99
025001990216     C     *IN99         DOWEQ     *OFF
025101000728     C                   ADD       KQTYN         XVQTY
025201990216     C     JSORD         READE     HSLORDDB                               99
025301990216     C                   ENDDO
025401000728     C                   Z-ADD     KDISP         XJDISP
025501990216     C                   ELSE
025601000728     C                   EXSR      YCLRSC
025701990216     C                   ENDIF
025801990219      *
025901990225      * Dispatch mode.
026001000728XXX  C     YMODE         IFEQ      'D'
026101990225XXX  C     JSORD         CHAIN     HSLODELA                           99
026201990225XXX  C     VNAM1         IFEQ      *BLANKS
026301000728XXX  C                   MOVEL(P)  ENAM1         XXNAM1
026401000728XXX  C                   MOVEL(P)  ENAM2         XXNAM2
026501000728XXX  C                   MOVEL(P)  EADR1         XXADR1
026601000728XXX  C                   MOVEL(P)  EADR2         XXADR2
026701990225XXX  C                   ELSE
026801000728XXX  C                   MOVEL(P)  VNAM1         XXNAM1
026901000728XXX  C                   MOVE      *BLANKS       XXNAM2
027001000728XXX  C                   MOVEL(P)  VADR1         XXADR1
027101000728XXX  C                   MOVEL(P)  VADR2         XXADR2
027201990225XXX  C                   ENDIF
027301990225XXX  C                   ENDIF
027401990225      *
027402150422      *
027501990225      * Dispatch, or Inquiry, or Maintenance mode.
027601000728XXX  C     YMODE         IFEQ      'I'
027701000728XXX  C     YMODE         OREQ      'D'
027801000728XXX  C     YMODE         OREQ      'M'
027901000728XXX  C                   MOVEL     YCUST         XJCUST
028001000728XXX  C                   MOVEL     YTYPE         XJTYPE
028101990225XXX  C                   ENDIF
028201990219     C     HDR           TAG
028301990225XXX  C                   MOVE      *OFF          *IN47
028401990122      * Display screen to receive Customer No. until F03/F10
028501990128     C     KEY           DOUEQ     F03
028601990122     C     KEY           OREQ      F10
028701000728     C     XERROR        ANDEQ     XNO
028801990121      *
028901990302      * Exit if F03 pressed.
029001990302     C     KEY           IFEQ      F03
029101990302     C                   MOVE      *ON           *INLR
029201990302     C                   LEAVE
029301990302     C                   ENDIF
029401990302      *
029501990121      * Display messages.
029601990121     C                   WRITE     MSGCTL
029701990121      *
029801000728     C                   TIME                    XXTME
029901990122     C                   EXFMT     HSS200A
030001990225      *
030101000728ZZZ  C     XJTYPE        CHAIN     HSLORDPA                           99
030201990302ZZZ  C     MSALE         IFEQ      'C'
030301990302ZZZ  C                   MOVE      *ON           *IN30
030401000728ZZZ  C                   MOVE      XYES          XERROR
030501990302ZZZ  C                   MOVEL     'HSV2027'     P0MSID
030601000728ZZZ  C                   EXSR      YSNDMG
030701990302ZZZ  C                   ITER
030801990302ZZZ  C                   ENDIF
030901990302      *
031001000728XXX  C                   CLEAR                   XVQTY
031101990225XXX  C     *IN20         IFEQ      *OFF
031201000728XXX  C     YMODE         ANDEQ     'D'
031301990225XXX  C                   ITER
031401990225XXX  C                   ENDIF
031501990225      *
031601990217BL   C                   Z-ADD     1             RCDNBR
031701990121      *
031801990121      * Clear messages.
031901000728     C                   EXSR      YCLRMG
032001990120      *
032101990120      * Process the various function keys available on the screen.
032201990219      *
032301990219      * Process Despatch if F07 pressed.
032401990226     C     KEY           IFEQ      F07
032501990226      *
032601990226      * Validate that Order Type is a valid Type.
032701000728     C     XJTYPE        CHAIN     HSLORDPA                           99
032801990226     C     *IN99         IFEQ      *ON
032901990226     C                   MOVE      *ON           *IN30
033001000728     C                   MOVE      XYES          XERROR
033101990226     C                   MOVEL     'HSV2001'     P0MSID
033201000728     C                   EXSR      YSNDMG
033301990226     C                   GOTO      START
033401990226     C                   ENDIF
033501990226     C                   ENDIF
033601990219      *
033701000728     C     YMODE         IFEQ      'D'
033801000728     C     WKORDN        ANDNE     XJSORD
033901000728     C                   MOVEL     XJSORD        WKORDN            8 0
034001000728     C     XJSORD        CHAIN     HSLORDHA                           99
034101990219     C     *IN99         IFEQ      *ON
034201990219     C                   MOVE      *OFF          *IN20
034301990219     C                   MOVEL     'HSV2017'     P0MSID
034401000728     C                   EXSR      YSNDMG
034501990219     C                   ELSE
034601000728     C                   MOVE      JTYPE         XJTYPE
034701000728     C                   MOVE      JCUST         XJCUST
034801990219     C                   Z-ADD     JORDD         WKORDD
034901990219     C                   Z-ADD     WKC           JCC
035001990219     C                   Z-ADD     WKY           JYY
035101990219     C                   Z-ADD     WKM           JMM
035201990219     C                   Z-ADD     WKD           JDD
035301000728     C                   MOVE      JORDR         XJORDR
035401000728     C                   MOVE      JSORD         XJSORD
035501990219     C     JSTAT         IFEQ      'A'
035601990219     C     JSTAT         OREQ      ' '
035701990219     C                   MOVE      *ON           *IN20
035801990219     C                   ELSE
035901990219     C                   MOVE      *OFF          *IN20
036001990219     C                   MOVEL     'HSV2015'     P0MSID
036101000728     C                   EXSR      YSNDMG
036201990219     C                   ENDIF
036301990219     C                   ENDIF
036401990219     C     JCUST         CHAIN     HSLCUSTA                           13
036501000728     C                   MOVE      EPCDE         XJPCDE
036601000728     C                   MOVE      ENAM1         XENAM1
036701990219     C     JSORD         SETLL     HSLORDDB
036801990219     C     JSORD         READE     HSLORDDB                               99
036901990219     C     *IN99         DOWEQ     *OFF
037001000728     C                   ADD       KQTYN         XVQTY
037101990219     C     JSORD         READE     HSLORDDB                               99
037201990219     C                   ENDDO
037301000728     C                   Z-ADD     KDISP         XJDISP
037401990222     C                   GOTO      HDR
037501990219     C                   ENDIF
037601990204      *
037701990211      * Program in inquiry, dispatch or maintenance mode
037801000728     C     YMODE         IFEQ      'I'
037901000728     C     YMODE         OREQ      'M'
038001000728     C     YMODE         OREQ      'D'
038101990204      *
038201990204      * Initialise subfile
038301990215     C                   MOVEA     '1001'        *IN(70)
038401990204     C                   WRITE     HSS200B
038501000728     C     XJSORD        IFNE      0
038601000728     C                   Z-ADD     0             RRNX
038701000728     C     XJSORD        SETLL     HSLORDDB
038801990204     C     *IN97         DOUEQ     *ON
038901000728     C     XJSORD        READE     HSLORDDB                               97
039001990204      *
039101990204      * Build subfile from existing order.
039201990204     C     *IN97         IFEQ      *OFF
039301000728     C                   ADD       1             RRNX
039401000728     C     RRNX          CHAIN     HSS200C                            99
039501000728     C                   Z-ADD     KLINE         XOLIN
039601000728     C                   MOVEL     KLTYP         XSELC
039701000728     C                   MOVEL     KPROD         XKPROD
039801000728     C                   MOVEL     KDESC         XNDESC
039901000728     C                   MOVEL     KSERC         XKSERC
040001000728     C                   Z-ADD     KSERNF        XKSERF
040101000728     C                   Z-ADD     KSERNT        XKSERT
040201000728     C                   Z-ADD     KQTYN         XKQTYN
040301000728     C                   Z-ADD     KPRIC         XKPRIC
040401000728     C                   Z-ADD     KVALU         XKVALU
040501000728XXX  C                   MOVE      XKQTYN        XXQTYN
040601990218BL    *
040701990218BL    * Ship Only - set line value to zero.
040801990218BL   C     SHONLY        IFEQ      'Y'
040901000728BL   C     XSELC         ANDEQ     'S'
041001000728BL   C                   Z-ADD     0             XKVALU
041101990218BL   C                   ENDIF
041201990218BL    *
041301000728BL   C*          #KVALU    MULT MVATP     #KVATA
041401990204      *
041501990204      * Extended value
041601000728     C     XSELC         IFEQ      'S'
041701000728     C     XSELC         OREQ      'N'
041801000728     C     XKPRIC        MULT      XKQTYN        XKVALU
041901990218BL    *
042001990218BL    * Ship Only - set line value to zero.
042101990218BL   C     SHONLY        IFEQ      'Y'
042201000728BL   C     XSELC         ANDEQ     'S'
042301000728BL   C                   Z-ADD     0             XKVALU
042401990218BL   C                   ENDIF
042501990218BL    *
042601000728BL   C*          #KVALU    MULT MVATP     #KVATA
042701990215      *
042801990204     C                   ENDIF
042901990204      *
043001990215      * Write subfile record.
043101990215     C     *IN99         IFEQ      *OFF
043201990215     C                   UPDATE    HSS200C
043301990215     C                   ELSE
043401990215     C                   WRITE     HSS200C
043501990215     C                   ENDIF
043601990204     C                   ENDIF
043701990204     C                   ENDDO
043801990204     C                   ENDIF
043901990204     C                   LEAVE
044001990204     C                   ENDIF
044101990215      *
044201990215      * Program mode - Entry
044301000728     C     YMODE         IFEQ      'E'
044401990120      *
044501990120      * Execute search if F04 pressed.
044601990128     C     KEY           IFEQ      F04
044701000728     C                   EXSR      YSERCH
044801990225XXX  C                   ITER
044901000728XXX  C                   EXSR      YCLRMG
045001990128     C                   ENDIF
045101990121      *
045201990122      * Validate header screen fields.
045301990122     C                   EXSR      VALIDH
045401990121      *
045501990122      * Validate ship only requirements.
045601990122     C                   EXSR      SHPONL
045701990106      *
045801990204     C                   ENDIF
045901990225      *
046001990225      * Process Despatch if F07 pressed.
046101990225RT   C     KEY           IFEQ      F07
046201990225      *
046301990225RT   C                   LEAVE
046401990225RT   C                   ENDIF
046501990225      *
046601990122      * End of DO loops for F03/F10 key checks.
046701990128     C                   ENDDO
046801990302     C                   MOVE      *OFF          *IN61
046901990106      *
047001990127      * Clear messages.
047101000728     C                   EXSR      YCLRMG
047201990204      *
047301990204      * Exit if F03 pressed.
047401990204     C     KEY           IFEQ      F03
047501990204      * Exit program.
047601990204     C                   MOVE      *ON           *INLR
047701990204     C                   RETURN
047801990204     C                   ENDIF
047901990127      *
048001990128      *-------------------------------------------------------
048101990215      *
048201990215      * Program mode - Entry
048301990128      * Retrieve order number.
048401000728     C     YMODE         IFEQ      'E'
048501000728     C     *DTAARA       DEFINE    HSAORDERNO    ORDERX            8 0
048601000728     C     *LOCK         IN        ORDERX
048701000728     C                   ADD       1             ORDERX
048801000728     C                   OUT       ORDERX
048901000728     C                   Z-ADD     ORDERX        XJSORD
049001990204     C                   ENDIF
049101990128      *
049201990122      * Display screen to receive Order Details until F10/F12
049301990127     C     DET           TAG
049401990204      *
049501990215      * Program in inquiry, or dispatch, or maintenance mode
049601000728     C     YMODE         IFEQ      'I'
049701000728     C     YMODE         OREQ      'M'
049801000728     C     YMODE         OREQ      'D'
049901990205     C     KEY           OREQ      F12
050001990205     C                   MOVEL     *OFF          *IN73
050101990205     C                   ELSE
050201990205     C                   MOVEL     *ON           *IN73
050301990204     C                   ENDIF
050401990204      *
050501990128     C     KEY           DOUEQ     F10
050601000728     C     XERROR        ANDEQ     XNO
050701990126     C     KEY           OREQ      F12
050801990122      *
050901990122      * Display messages.
051001990122     C                   WRITE     MSGCTL
051101990122      *
051201990211      * Read subfile to accumulate order value.
051301000728     C     RRNX          IFGT      0
051401990211     C                   Z-ADD     1             RRNVAL
051501000728     C                   Z-ADD     0             XKTVAL
051601990211     C     *IN98         DOUEQ     *ON
051701990217BL   C     RRNVAL        OREQ      100
051801000728BL   C     XSELC         OREQ      *BLANK
051901990211     C     RRNVAL        CHAIN     HSS200C                            98
052001000728     C     XSELC         IFNE      *BLANK
052101000728     C     XKPROD        ANDNE     *BLANK
052201990211     C     *IN98         ANDEQ     *OFF
052301000728     C     XSELC         ORNE      *BLANK
052401000728     C     XNDESC        ANDNE     *BLANK
052501990211     C     *IN98         ANDEQ     *OFF
052601000728     C                   ADD       XKVALU        XKTVAL
052701990211     C                   ENDIF
052801990211     C                   ADD       1             RRNVAL
052901990211     C                   ENDDO
053001990211     C                   ENDIF
053101990225      *
053201990225      * Dispatch mode.
053301000728XXX  C     YMODE         IFEQ      'D'
053401000728XXX  C     XJCUST        CHAIN     HSLCUSTA                           99
053501990225XXX   * ...load Customer record into screen 2 fields.
053601000728XXX  C                   MOVEL     ENAM1         XJNAM1                         Name 1
053701000728XXX  C                   MOVEL     ENAM2         XJNAM2                         Name 2
053801000728XXX  C                   MOVEL     EADR1         XJADR1                         Address 1
053901000728XXX  C                   MOVEL     EADR2         XJADR2                         Address 2
054001990225XXX  C                   ENDIF
054101990225      *
054201990211      *
054301990211      * Display footer.
054401990225RT   C     KEY           IFNE      F07
054501990127     C                   WRITE     HSS200E
054601990225RT   C                   ENDIF
054701990204      *
054801000728     C                   TIME                    XXTME
054901990205     C                   MOVEA     '011'         *IN(70)
055001990204      *
055101990225RT   C     KEY           IFNE      F07
055201990127     C                   EXFMT     HSS200B
055301000728XXX  C                   MOVE      XNO           XJUMP1
055401990302      *
055501990302     C     KEY           IFNE      F10
055601000728     C                   EXSR      YDELT
055701990302     C                   ENDIF
055801990302      *
055901990302RT   C                   ENDIF
056001990302      *
056101990127     C                   MOVEL     *OFF          *IN73
056201990302     C                   MOVEL     *OFF          *IN86
056301990122      *
056401990223OWE   * Clear messages (Only if an error has not been repeated)
056501990223      *
056601000728OWE  C     XERROR        IFEQ      XNO
056701990122      * Clear messages.
056801000728     C                   EXSR      YCLRMG
056901990223OWE  C                   ENDIF
057001990122      *
057101990122      * Process the various function keys available on the screen.
057201990302      *
057301990122      * Exit if F12 pressed.
057401990128     C     KEY           IFEQ      F12
057501990127     C                   GOTO      HDR
057601990128     C                   ENDIF
057701990122      *
057801990122      * Execute search if F04 pressed.
057901990128     C     KEY           IFEQ      F04
058001000728     C                   EXSR      YSERSF
058101990126     C                   ITER
058201990128     C                   ENDIF
058301990122      *
058401990122      * Check for agency cross-references.
058501990217BL   C     MXREF         IFEQ      'Y'
058601990122     C                   EXSR      AGXREF
058701990217BL   C                   ENDIF
058801990122      *
058901990223OWE   * Validate order detail screen fields (only re-validate data
059001990223OWE   * if it has been changed. Otherwise re-display error message).
059101000728OWE  C     XERROR        IFEQ      XYES
059201990223OWE  C     RRNS          CHAIN     HSS200C                            98
059301000728OWE  C     XSELC         IFNE      TSELC
059401000728OWE  C     XKPROD        ORNE      TPROD
059501000728OWE  C     XKPRIC        ORNE      TPRIC
059601000728OWE  C     XKQTYN        ORNE      TQTYN
059701000728OWE  C     XNDESC        ORNE      TDESC
059801990223OWE  C                   MOVE      *ON           *IN93
059901990223OWE  C                   ENDIF
060001990223OWE  C                   ENDIF
060101990225      *
060201990223OWE  C     *IN93         IFEQ      *ON
060301000728     C     XERROR        OREQ      XNO
060401990223      *
060501990223      * Validate order detail screen fields.
060601990223     C                   EXSR      VALIDD
060701990223OWE  C                   ENDIF
060801990122      *
060901990122      * Discount retrieval.
061001990122     C                   EXSR      DISCNT
061101990122      *
061201990122      * Stock allocation preview
061301990122      *                 - with banded allocation and manual allocation.
061401990223BL   C*          MSALE     IFEQ 'S'
061501990223     C*                    EXSR ALLOCS
061601990223BL   C*                    ENDIF
061701990122      *
061801990302      * Process Dispatch if F07 pressed.
061901990225RT   C     KEY           IFEQ      F07
062001990225      *
062101990225RT   C                   LEAVE
062201990225RT   C                   ENDIF
062301990225      *
062401990122      * End of DO loops for F10/F12 key checks.
062501990128     C                   ENDDO
062601990122      *
062701990122      *-------------------------------------------------------
062801990122      * Confirm order - prompt for delivery details.
062901990122      *               - file updates when F10 pressed.
063001990128     C     KEY           DOUEQ     F10
063101000728     C     XERROR        ANDEQ     XNO
063201990127     C     KEY           OREQ      F12
063301990127      *
063401990127      * Clear messages.
063501000728     C                   EXSR      YCLRMG
063601990127      *
063701990127      * Process the various function keys available on the screen.
063801990127      *
063901990127      * Exit if F12 pressed.
064001990223OOO  C*          KEY       IFEQ F12
064101990223OOO  C*                    GOTO DET
064201990223OOO  C*                    ENDIF
064301990122      *
064401990122      * Check for minimum order value.
064501990225RT   C     KEY           IFNE      F07
064601990127     C     MORDV         IFGT      0
064701990122     C                   EXSR      MINVAL
064801990127     C                   ENDIF
064901990225      *
065001990225XXX   * Credit limit check.... Warning only.
065101000728XXX  C     XKTVAL        ADD       XJTYSL        TOT              20 5
065201000728XXX  C     TOT           IFGT      XJCLIM
065301990225XXX  C                   MOVE      *ON           *IN46
065401990225XXX  C                   MOVEL     'HSV2019'     P0MSID
065501000728XXX  C                   EXSR      YSNDMG
065601990225XXX  C                   ENDIF
065701990225RT   C                   ENDIF
065801990225      *
065901990122      * Display messages.
066001990122     C                   WRITE     MSGCTL
066101990127      *
066201990128      * Display key text footer.
066301990225XXXM C*                    WRITEHSS200E
066401990225RT   C     KEY           IFNE      F07
066501990225XXXM C                   WRITE     HSS200F
066601990225RT   C                   ENDIF
066701990122      *
066801990128      * Delivery address prompt screen.
066901000728     C                   TIME                    XXTME
067001990204      *
067101990211      * Program in inquiry, dispatch or maintenance mode
067201000728     C     YMODE         IFEQ      'I'
067301000728     C     YMODE         OREQ      'M'
067401000728     C     YMODE         OREQ      'D'
067501990204     C     WKORDN        CHAIN     HSLODELA                           99
067601990204      *
067701990204      * Write fields for order delivery detail record.
067801990204     C     *IN99         IFEQ      *OFF
067901000728     C                   MOVEL     VNAM1         XVNAM1
068001000728     C                   MOVEL     VADR1         XVADR1
068101000728     C                   MOVEL     VADR2         XVADR2
068201000728     C                   MOVEL     VADR3         XVADR3
068301000728     C                   MOVEL     VPCDE         XVPCDE
068401000728     C                   MOVEL     VDIN1         XVDIN1
068501000728     C                   MOVEL     VDIN2         XVDIN2
068601000728     C                   MOVEL     VDIN3         XVDIN3
068701990204     C                   ENDIF
068801990204     C                   ENDIF
068901990204      *
069001990204      * Write order delivery details record.
069101990225RT   C     KEY           IFNE      F07
069201990127     C                   EXFMT     HSS200D
069301990225RT   C                   ENDIF
069401990223      *
069501990223OWE   * Exit if F12 pressed.
069601990223OWE  C     KEY           IFEQ      F12
069701000728     C                   EXSR      YDELT
069801990223OWE  C                   GOTO      DET
069901990223OWE  C                   ENDIF
070001990122      *
070101990122      * Clear messages.
070201990225XXX  C     *IN47         IFEQ      *OFF
070301000728     C                   EXSR      YCLRMG
070401990225XXX  C                   ENDIF
070501990122      *
070601990128      * Update all files, if no errors exist.
070701990201     C     KEY           IFEQ      F10
070801000728     C     XERROR        ANDEQ     XNO
070901990225RT   C     KEY           OREQ      F07
071001000728     C                   Z-ADD     1             RRNX
071101990217     C     *IN98         DOUEQ     *ON
071201000728BL   C     RRNX          OREQ      100
071301000728BL   C     XSELC         OREQ      *BLANK
071401000728     C     RRNX          CHAIN     HSS200C                            98
071501000728     C     XSELC         IFNE      *BLANK
071601000728     C     XKPROD        ANDNE     *BLANK
071701990211     C     *IN98         ANDEQ     *OFF
071801000728     C     XSELC         ORNE      *BLANK
071901000728     C     XNDESC        ANDNE     *BLANK
072001990211     C     *IN98         ANDEQ     *OFF
072101990225      *
072201990225      * Save RRN for current order line.
072301000728     C                   Z-ADD     RRNX          RRNLIN
072401990223      *
072501990225OWE   * Update Voucher Control if in entry mode....
072601000728OWE  C     YMODE         IFEQ      'E'
072701990223BL   C     MSALE         ANDEQ     'S'
072801990223OWE  C                   EXSR      UPPVCT
072901990223OWE  C                   ENDIF
073001990223      *
073101990225      * Re-position to required subfile line
073201000728     C                   Z-ADD     RRNLIN        RRNX
073301000728     C     RRNX          CHAIN     HSS200C                            98
073401990122      *
073501990218BL    * Create/Update order details if in Entry,Maint,or Dispatch mode.
073601000728BL   C     YMODE         IFEQ      'E'
073701000728BL   C     YMODE         OREQ      'D'
073801000728BL   C     YMODE         OREQ      'M'
073901990122     C                   EXSR      UPORDD
074001990218BL   C                   ENDIF
074101990218      *
074201990218BL    * Update voucher tracking if in Entry or Dispatch mode.
074301990218BL    * Stock lines only.
074401000728     C     YMODE         IFEQ      'E'
074501000728     C     XSELC         ANDEQ     'S'
074601000728BL   C     YMODE         OREQ      'D'
074701000728BL   C     XSELC         ANDEQ     'S'
074801990211     C                   EXSR      UPTRAC
074901990217BL   C                   ENDIF
075001990219      *
075101990219BL    * Allocate inventory if in Entry mode.
075201990219BL    * Stock lines only.
075301000728BL   C     YMODE         IFEQ      'E'
075401000728BL   C     XSELC         ANDEQ     'S'
075501990219      * Update inventory allocations.
075601990219     C                   EXSR      UPINVA
075701990219     C                   ENDIF
075801990218      *
075901990219BL    * Sell inventory if in Dispatch mode.
076001990218BL    * Stock lines only.
076101000728BL   C     YMODE         IFEQ      'D'
076201000728BL   C     XSELC         ANDEQ     'S'
076301990219      * Update inventory sales.
076401990219BL   C                   EXSR      UPINVS
076501990211      *
076601990211      * Create inventory sales transaction.
076701990128     C                   EXSR      UPINVT
076801990211     C                   ENDIF
076901990128     C                   ENDIF
077001000728     C                   ADD       1             RRNX
077101990128     C                   ENDDO
077201990211      *
077301990218BL    * Create/Update order header if in Entry,Maint,or Dispatch mode.
077401000728BL   C     YMODE         IFEQ      'E'
077501000728BL   C     YMODE         OREQ      'D'
077601000728BL   C     YMODE         OREQ      'M'
077701990211     C                   EXSR      UPORDH
077801990211      *
077901990218      * Create/update delivery record if in Entry,Maint or Dispat.mode.
078001990211     C                   EXSR      UPODEL
078101990218BL   C                   ENDIF
078201990128      *
078301990218BL    * Ship to all delivery points if in Entry mode.
078401000728BL   C     YMODE         IFEQ      'E'
078501990218BL   C     MALLP         ANDEQ     'Y'
078601990128     C                   EXSR      SHPALL
078701990218BL   C                   ENDIF
078801990128      *
078901990218BL    * Print delivery note if in Entry mode, and charges only not set.
079001000728BL   C     YMODE         IFEQ      'E'
079101990218BL   C     MINVC         ANDNE     'Y'
079201990128     C                   EXSR      PRTDEL
079301990218BL   C                   ENDIF
079401990128      *
079501990218BL    * Print Invoice if in Entry mode, and Immediate print required.
079601000728BL   C     YMODE         IFEQ      'E'
079701990218BL   C     MINVP         ANDEQ     'I'
079801990128     C                   EXSR      PRTINV
079901990217BL   C                   ENDIF
080001990218      *
080101990128     C                   ENDIF
080201990225      * Process Despatch if F07 pressed.
080301990225RT   C     KEY           IFEQ      F07
080401000728     C                   EXSR      YCLRSC
080501990225      *
080601990225RT   C                   LEAVE
080701990225RT   C                   ENDIF
080801990128      *
080901990122      * End of Confirmation.
081001990128     C                   ENDDO
081101990205      *
081201990205      * Return to order details if F12 pressed.
081301990205     C     KEY           IFEQ      F12
081401990205     C                   GOTO      DET
081501990205     C                   ENDIF
081601990205      *
081701990205      * Clear Subfile
081801990205     C                   MOVEA     '1000'        *IN(70)
081901990205     C                   WRITE     HSS200B
082001990302      *
082101990302      * Clear contents of HSPEXPA.
082201000728     C                   EXSR      YDELT
082301990205      *
082401990205      * Return to order header.
082501990205     C                   GOTO      HDR
082601990122      *
082701990106      *****************************************************************
082801990120      *----------------------------------------------------------------
082901000728      * @CLRSC - Clear screen fields.
083001990120      *----------------------------------------------------------------
083101990120      *
083201000728     C     YCLRSC        BEGSR
083301990120      *
083401990217BL    * Clear header screen fields.
083501000728BL   C     YMODE         IFNE      'E'
083601000728     C                   CLEAR                   XJTYPE
083701990217BL   C                   ENDIF
083801000728BL   C     YMODE         IFEQ      'D'
083901000728     C                   CLEAR                   XJSORD
084001000728     C                   CLEAR                   XENAM1
084101000728     C                   CLEAR                   XVQTY
084201990219BL   C                   ENDIF
084301000728     C                   CLEAR                   XJCOMP
084401000728     C                   CLEAR                   XJWHSE
084501000728     C                   CLEAR                   XJPCDE
084601000728     C                   CLEAR                   XJCUST
084701000728     C                   CLEAR                   XJDISP
084801000728     C                   CLEAR                   XJORDD
084901000728     C                   CLEAR                   XJORDR
085001990120      *
085101990217BL    * Clear delivery screen fields.
085201000728BL   C                   CLEAR                   XVNAM1
085301000728BL   C                   CLEAR                   XVADR1
085401000728BL   C                   CLEAR                   XVADR2
085501000728BL   C                   CLEAR                   XVADR3
085601000728BL   C                   CLEAR                   XVPCDE
085701000728BL   C                   CLEAR                   XVDIN1
085801000728BL   C                   CLEAR                   XVDIN2
085901000728BL   C                   CLEAR                   XVDIN3
086001990120     C                   ENDSR
086101990122      *
086201990122      *----------------------------------------------------------------
086301990122      * SHPONL - Validate ship only requirements.
086401990122      *----------------------------------------------------------------
086501990122     C     SHPONL        BEGSR
086601990125      *
086701990125      * Check if a ship only record exists for this customer
086801000728     C     XJCUST        CHAIN     HSLSHPOA                           99
086901990125     C     *IN99         IFEQ      *OFF
087001990125     C                   MOVEL     'Y'           SHONLY            1
087101990218BL   C                   ELSE
087201990218BL   C                   MOVEL     ' '           SHONLY
087301990125     C                   ENDIF
087401990122     C                   ENDSR
087501990122      *
087601990122      *----------------------------------------------------------------
087701990122      * AGXREF - Check for agency cross-references.
087801990122      *----------------------------------------------------------------
087901990122     C     AGXREF        BEGSR
088001990223     C     KEYXRF        CHAIN     HSLVXRFB                           99
088101990126     C     *IN99         IFEQ      *OFF
088201990128     C                   MOVEL     HPROD         KPROD
088301000728     C                   MOVEL     HPROD         XKPROD
088401990126     C                   ENDIF
088501990122     C                   ENDSR
088601990122      *
088701990122      *----------------------------------------------------------------
088801990122      * VALIDD - Validate order detail screen fields.
088901990122      *----------------------------------------------------------------
089001990122     C     VALIDD        BEGSR
089101990126      *
089201990126      * Order Detail validation:
089301990126      *
089401990126      * Reset work values.
089501000728     C*                    Z-ADD0         RRN#
089601990223OWEM C                   Z-ADD     0             RRNS              5 0
089701990223OWE  C                   Z-ADD     1             RRNT              5 0
089801000728     C                   RESET                   XERROR
089901990126     C                   MOVE      *OFF          *IN61                          Hide F10/F11
090001990126      *
090101990126      * Reset error indicators.
090201000728     C                   MOVEA     XZEROS        *IN(30)
090301990126      *
090401990126      * Read all Records from subfile and validate contents.
090501990127     C     *IN99         DOUEQ     *ON                                          ..Do1
090601990223OWE   *
090701990223OWE   * Process the subfile in one of two modes depending on whether
090801990223OWE   * a previous change to the subfile has been made....
090901990223OWE   *
091001990223OWE  C     *IN82         IFEQ      *OFF
091101990223OWE  C                   READC     HSS200C                                99
091201000728OWE  C                   Z-ADD     RRNX          RRNT
091301990223OWE  C                   ADD       1             RRNT
091401990223OWE  C                   ELSE
091501990223OWE  C     RRNT          IFEQ      101
091601990223OWE  C                   LEAVE
091701990223OWE  C                   ENDIF
091801990223OWE  C     RRNT          CHAIN     HSS200C                            99
091901990223OWE  C                   ADD       1             RRNT
092001990223OWE  C                   ENDIF
092101990223      *
092201990223     C*                    READCHSS200C                  99
092301990126      * Retrieve subfile record.
092401990126     C     *IN99         IFEQ      *OFF                                         ...If2
092501000728OWE  C                   MOVE      XKPROD        TPROD1           13
092601000728OWE  C                   MOVE      XKQTYN        TQTYN1           15 0
092701990223OWE  C                   MOVE      *ON           *IN82
092801990126      *
092901990126      * Reset subfile error indicators.
093001990126     C                   MOVEA     '00000000'    *IN(36)
093101990126      *
093201000728     C     XSELC         IFNE      *BLANK                                       ....If3
093301000728     C     XKPROD        ORNE      *BLANK                                       ....If3
093401000728     C     XNDESC        ORNE      *BLANK                                       ....If3
093501000728     C     XKPRIC        ORNE      *ZEROS                                       ....If3
093601000728     C     XKQTYN        ORNE      *ZEROS                                       ....If3
093701000728     C     XKVALU        ORNE      *ZEROS                                       ....If3
093801000728     C     XKVATA        ORNE      *ZEROS                                       ....If3
093901000728     C     XKSERC        ORNE      *BLANKS                                      ....If3
094001000728     C     XKSERF        ORNE      *ZEROS                                       ....If3
094101000728     C     XKSERT        ORNE      *ZEROS                                       ....If3
094201990128      *
094301990128      * Count active subfile records.
094401000728OWE  C*                    ADD  1         RRN#
094501990223OWE  C                   ADD       1             RRNS
094601990126      *
094701990126      * Validate Selection code.
094801000728     C     XSELC         IFNE      'S'
094901000728     C     XSELC         ANDNE     'N'
095001000728     C     XSELC         ANDNE     'T'
095101990127      *
095201990127      * Validate Selection code / Product code / Text combination
095301000728     C     XSELC         OREQ      *BLANK
095401000728     C     XKPROD        ANDNE     *BLANKS
095501000728     C     XSELC         OREQ      *BLANK
095601000728     C     XNDESC        ANDNE     *BLANKS
095701000728     C     XSELC         OREQ      *BLANK
095801000728     C     XKPRIC        ANDNE     0
095901000728     C     XSELC         OREQ      *BLANK
096001000728     C     XKQTYN        ANDNE     0
096101000728     C     XSELC         OREQ      'T'
096201000728     C     XKPROD        ANDNE     *BLANKS
096301000728     C     XSELC         OREQ      'T'
096401000728     C     XKPRIC        ANDNE     0
096501000728     C     XSELC         OREQ      'T'
096601000728     C     XKQTYN        ANDNE     0
096701000728     C     XSELC         OREQ      'T'
096801000728     C     XKSERC        ANDNE     *BLANKS
096901000728     C     XSELC         OREQ      'T'
097001000728     C     XKSERF        ANDNE     0
097101000728     C     XSELC         OREQ      'T'
097201000728     C     XKSERT        ANDNE     0
097301000728     C     XSELC         OREQ      'S'
097401000728     C     XKQTYN        ANDEQ     0
097501000728     C*          #SELC     OREQ 'S'
097601000728     C*          #KPRIC    ANDEQ0
097701000728     C     XSELC         OREQ      'N'
097801000728     C     XKQTYN        ANDEQ     0
097901000728     C     XSELC         OREQ      'N'
098001000728     C     XKPRIC        ANDEQ     0
098101990126     C                   MOVE      *ON           *IN36
098201000728     C                   MOVE      XYES          XERROR
098301990126     C                   MOVEL     'HSV2006'     P0MSID
098401000728     C                   EXSR      YSNDMG
098501990126     C                   ENDIF
098601990218      *
098701990218      * Validate Selection code for Invoice Charge Only order type.
098801000728     C     XSELC         IFEQ      'S'
098901990218     C     MINVC         ANDEQ     'Y'
099001990218     C                   MOVE      *ON           *IN36
099101000728     C                   MOVE      XYES          XERROR
099201990218     C                   MOVEL     'HSV2014'     P0MSID
099301000728     C                   EXSR      YSNDMG
099401990218     C                   ENDIF
099501990225      *
099601000728XXX  C     YMODE         IFEQ      'D'
099701000728XXX  C     XKQTYN        ANDGT     XXQTYN
099801000728XXX  C                   MOVE      XYES          XERROR
099901990225XXX  C                   MOVEL     'HSV2020'     P0MSID
100001000728XXX  C                   EXSR      YSNDMG
100101990225XXX  C                   LEAVE
100201990225XXX  C                   ELSE
100301000728XXX  C                   EXSR      YCLRMG
100401990225XXX  C                   ENDIF
100501990126      *
100601990126      * Validate Product.
100701000728     C     XSELC         IFEQ      'S'
100801000728     C     XKPROD        IFNE      *BLANKS
100901000728     C     XKPROD        CHAIN     HSLPRODA                           99
101001990126     C     *IN99         IFEQ      *ON
101101990126     C                   MOVE      *ON           *IN37
101201000728     C                   MOVE      XYES          XERROR
101301990126     C                   MOVEL     'HSV2007'     P0MSID
101401000728     C                   EXSR      YSNDMG
101501990127     C                   ELSE
101601000728     C                   MOVEL     NDESC         XNDESC
101701000728     C                   Z-ADD     NPRIC         XKPRIC
101801990201     C                   ENDIF
101901990201     C                   ENDIF
102001990201     C                   ENDIF
102101990127      *
102201990127      * Reverse price for Credit
102301990127     C     MSALE         IFEQ      'C'
102401000728     C                   Z-SUB     XKPRIC        XKPRIC
102501990127     C                   ENDIF
102601990127      *
102701990127      * Extended value
102801000728     C     XSELC         IFEQ      'S'
102901000728     C     XSELC         OREQ      'N'
103001000728     C     XKPRIC        MULT      XKQTYN        XKVALU
103101990218BL    *
103201000728BL   C*          #KVALU    MULT MVATP     #KVATA
103301990126     C                   ENDIF
103401990223      *
103501990223OWE   * Save Price, Value and Description field contents....
103601000728OWE  C                   MOVE(P)   XKPRIC        TKPRIC            9 2
103701000728OWE  C                   MOVE(P)   XKVALU        TKVALU            9 2
103801000728OWE  C                   MOVE(P)   XNDESC        TNDESC           19
103901990223      *
104001990211      * Check quantity against allocated serial numbers.
104101000728OOO  C*          #KQTYN    IFNE 0
104201000728OOO  C*          #KSERF    ANDNE0
104301000728OOO  C*          #KSERT    ANDNE0
104401000728OOO  C*          #KSERT    SUB  #KSERF    WKQTYN
104501990223OOO  C*                    ADD  1         WKQTYN
104601000728OOO  C*          #KQTYN    IFNE WKQTYN
104701990223OOO  C*                    MOVEA'1011'    *IN,40
104801000728OOO  C*                    MOVE #YES      #ERROR
104901990223OOO  C*                    MOVEL'HSV2013' P0MSID
105001000728OOO  C*                    EXSR @SNDMG
105101990223OOO  C*                    ENDIF
105201990223OOO  C*                    ENDIF
105301990127      *
105401990128      * Check voucher control if not yet allocated
105501000728     C     XSELC         IFEQ      'S'
105601000728     C     XKQTYN        ANDGT     0
105701000728OOO  C*          #KSERC    IFEQ *BLANKS
105801000728OOO  C*          #KSERF    ANDEQ0
105901000728OOO  C*          #KSERT    ANDEQ0
106001990128     C                   MOVEL     'U'           WKVCTL
106101990127     C                   EXSR      UPVCTL
106201990128     C                   ENDIF
106301990223OOO  C*                    ENDIF
106401990126      *
106501990126      * Update subfile record with DSPATR settings and set SFLRCDNBR.
106601000728     C                   Z-ADD     RRNX          RCDNBR
106701000728OWE  C                   MOVE      TKPRIC        XKPRIC
106801000728OWE  C                   MOVE      TKVALU        XKVALU
106901000728OWE  C                   MOVE      TNDESC        XNDESC
107001990127     C                   UPDATE    HSS200C                                      SFL
107101990126     C                   MOVEA     '00000000'    *IN(36)
107201990126      *
107301990126      * If errors encountered in subfile then exit subfile validation.
107401000728     C     XERROR        IFEQ      XYES
107501000728OWE  C                   MOVEL(P)  XSELC         TSELC             1
107601000728OWE  C                   MOVEL(P)  XKPROD        TPROD            13
107701000728OWE  C                   MOVEL(P)  XKPRIC        TPRIC             9 2
107801000728OWE  C                   MOVEL(P)  XKQTYN        TQTYN             9 0
107901000728OWE  C                   MOVEL(P)  XNDESC        TDESC            19
108001000728OOO  C*                    Z-ADDRRN#      RRNS    50
108101990126     C                   LEAVE
108201990126     C                   ENDIF
108301990126      *
108401990126      * End of non-blank subfile check.
108501990126     C                   ENDIF                                                  ....EndIf3
108601990126      *
108701990126      * End of Subfile CHAIN check.
108801990126     C                   ENDIF                                                  ...EndIf2
108901990126      *
109001990128      * End of loop for next subfile record.
109101990126     C                   ENDDO                                                  ..EndDo1
109201990128      *
109301990217      * Save last RRN number used.
109401000728BL   C*                    Z-ADDRRN#      SAVRRN
109501990126      *
109601990126      * If no errors found...
109701000728     C     XERROR        IFEQ      XNO
109801990126      * ...display "Data valid.Press F10 to update" message...
109901990126     C                   MOVEL     'HSV9006'     P0MSID
110001000728     C                   EXSR      YSNDMG
110101990126      * ...activate F10 key (*IN61=*ON).
110201990126     C                   MOVE      *ON           *IN61
110301990126     C                   ENDIF
110401000728XXX  C     XJUMP1        IFEQ      XYES
110501990303XXX  C     *IN52         ANDEQ     *ON
110601990303     C                   CALL      'HSR342'
110701990303     C                   ENDIF
110801990303XXX  C                   MOVE      *OFF          *IN52
110901990122     C                   ENDSR
111001990122      *
111101990122      *----------------------------------------------------------------
111201990122      * DISCNT - Discount retrieval.
111301990122      *----------------------------------------------------------------
111401990216      *
111501990122     C     DISCNT        BEGSR
111601990216      *
111701990216      * If customer discount is not entered on header screen either
111801990216      * caluclate from HSPDISC file keyed on Order Value or default
111901990216      * according to Customer Type.
112001990216      *
112101000728     C     XJDISP        IFEQ      0
112201990216      *
112301990216      * Setup key list for HSPDISC
112401990216      *
112501000728     C                   Z-ADD     XKTVAL        PFAMT
112601990216      *
112701990216      * SETLL on HSLDISCA
112801990216      *
112901990216     C     DSCKEY        SETLL     HSLDISCA                               99
113001990216      *
113101990216      * If record not found READP
113201990216      *
113301990216     C     *IN99         IFEQ      *OFF
113401990215     C                   READP     HSLDISCA                               99
113501990216      *
113601990216      * If not BOF
113701990216      *
113801990216     C     *IN99         IFEQ      *OFF
113901990223BL   C     PCTYP         ANDEQ     ECTYP
114001990215     C                   Z-ADD     PDISC         KDISP
114101990216      *
114201990216      * Else calculate discount according to Customer Type
114301990216      *
114401990215     C                   ELSE
114501990216      *
114601990215     C                   SELECT
114701990216      *
114801990216      * If Customer Type is '001' - Z-ADD 10 to discount
114901990216      *
115001990215     C     ECTYP         WHENEQ    '001'
115101990215     C                   Z-ADD     10            KDISP
115201990216      *
115301990216      * If Customer Type is '002' - Z-ADD 20 to discount
115401990216      *
115501990215     C     ECTYP         WHENEQ    '002'
115601990215     C                   Z-ADD     20            KDISP
115701990216      *
115801990215     C                   ENDSL
115901990216      *
116001990215     C                   ENDIF
116101990216      *
116201990216      * Record found on SETLL
116301990216      *
116401990216     C                   ELSE
116501990216      *
116601990216     C                   Z-ADD     PDISC         KDISP
116701990216      *
116801990216     C                   ENDIF
116901990216      *
117001000728      * #JDISP not equal to 0
117101990216      *
117201990215     C                   ELSE
117301000728     C                   Z-ADD     XJDISP        KDISP
117401990216      *
117501990215     C                   ENDIF
117601990216      *
117701990122     C                   ENDSR
117801990122      *
117901990122      *----------------------------------------------------------------
118001990122      * Check for minimum order value.
118101990122      *----------------------------------------------------------------
118201990122     C     MINVAL        BEGSR
118301990128     C                   Z-ADD     0             WKTOTV
118401990225     C                   Z-ADD     1             RRNP
118501990127      *
118601990127      * Accumulate order total value
118701990127     C     *IN99         DOUEQ     *ON
118801990225BL   C     RRNP          OREQ      100
118901000728BL   C     XSELC         OREQ      *BLANK
119001990225     C     RRNP          CHAIN     HSS200C                            99
119101990127     C     *IN99         IFEQ      *OFF
119201000728     C                   ADD       XKVALU        WKTOTV
119301990127     C                   ENDIF
119401990225     C                   ADD       1             RRNP
119501990127     C                   ENDDO
119601990127      *
119701990127      * Compare order total value and minimum order value
119801990128     C     WKTOTV        IFLT      MORDV
119901000728     C                   MOVE      XYES          XERROR
120001990201     C                   MOVEL     'HSV2011'     P0MSID
120101000728     C                   EXSR      YSNDMG
120201990201     C                   ENDIF
120301990225     C                   Z-ADD     1             RRNP
120401000728     C                   Z-ADD     1             RRNX
120501990122     C                   ENDSR
120601990122      *
120701990122      *----------------------------------------------------------------
120801990122      * Ship to all delivery points.
120901990122      *----------------------------------------------------------------
121001990122     C     SHPALL        BEGSR
121101990216     C*
121201990216     C* SETLL on HSLCUSTA with Customer Number
121301990216     C*
121401000728     C     XJCUST        SETLL     HSLCUSTA
121501990216     C*
121601990216     C* READE on HSLCUSTA with Customer Number
121701990216     C*
121801000728     C     XJCUST        READE     HSLCUSTA                               99
121901990216     C*
122001990216     C* If not EOF
122101990216     C*
122201990216     C     *IN99         DOWEQ     *OFF
122301990216     C*
122401990216     C* If ECGRP not equal to blanks
122501990216     C*
122601990216     C     ECGRP         IFNE      *BLANKS
122701990216     C*
122801990216     C* CHAIN to Customer File for Delivery Name and Address
122901990216     C*
123001990318     C*          ECGRP     CHAINALTCUSTF             13
123101990216     C*
123201990318     C*          *IN13     IFEQ *OFF
123301990216     C*
123401990216     C* Write Order Header Record
123501990216     C*
123601990216     C                   EXSR      UPORDH
123701990216     C*
123801990216     C* Set up Delivery Name and Address
123901990216     C*
124001000728     C                   MOVEL     ENAM1         XVNAM1
124101000728     C                   MOVEL     EADR1         XVADR1
124201000728     C                   MOVEL     EADR2         XVADR2
124301000728     C                   MOVEL     EADR3         XVADR3
124401000728     C                   MOVEL     EPCDE         XVPCDE
124501990216     C*
124601990216     C* Write Order Delivery Record
124701990216     C*
124801990216     C                   EXSR      UPODEL
124901990216     C*
125001990216     C* Write Order Detail Record
125101990216     C*
125201990216     C                   EXSR      UPORDD
125301990216     C*
125401990216     C* ECGRP equal to blanks
125501990216     C*
125601990318     C*                    ENDIF
125701990216     C*
125801990216     C* Customer Record not found
125901990216     C*
126001990216     C                   ENDIF
126101990216     C*
126201990216     C* Increment order number
126301990216     C*
126401000728     C     *LOCK         IN        ORDERX
126501000728     C                   ADD       1             ORDERX
126601000728     C                   OUT       ORDERX
126701000728     C                   Z-ADD     ORDERX        XJSORD
126801990216     C*
126901990216     C* READE on HSLCUSTA with Customer Number
127001990216     C*
127101000728     C     XJCUST        READE     HSLCUSTA                               99
127201990216     C*
127301990216     C                   ENDDO
127401990216     C*
127501990216     C* EOF on HSLCUSTA
127601990216     C*
127701990122     C                   ENDSR
127801990122      *
127901990122      *----------------------------------------------------------------
128001990122      * Update voucher control.
128101990122      *----------------------------------------------------------------
128201990302     C     UPVCTL        BEGSR
128301990128      *
128401990302     C                   MOVE      *ON           *IN85
128501990302      * Save order line values
128601990302      *
128701990301     C                   Z-ADD     0             XQUAN             9 0
128801000728     C                   MOVE      XNO           XJUMP             1
128901990128      * Clear flag for successful range allocation.
129001990128     C                   MOVEL     *BLANK        WKRANG
129101990301      *
129201990301      * Clear flag for first tracking record found.
129301000728     C                   MOVEL     XNO           XFIRST            1
129401990127      *
129501990127      * Get Serial number range.
129601990128     C                   MOVEL     *BLANKS       WKSERC
129701990128     C     *IN92         DOUEQ     *ON
129801990128     C     WKRANG        OREQ      'Y'
129901990223      *
130001990223OWE   * Work back through the subfile checking for duplicate
130101990223OWE   * product codes.... If found validate data under DOUB subroutine.
130201990223      *
130301000728OWE  C                   MOVE      RRNX          RRNXX             5 0
130401000728OWE  C     RRNX          DOUEQ     0
130501000728OWE  C                   SUB       1             RRNX
130601000728OWE  C     RRNX          IFEQ      0
130701990223OWE  C                   LEAVE
130801990223OWE  C                   ENDIF
130901000728OWE  C     RRNX          CHAIN     HSS200C                            90
131001000728OWE  C     XKPROD        IFEQ      TPROD1
131101000728OWE  C                   MOVE      RRNXX         RRNX
131201990223OWE  C                   EXSR      DOUB
131301990223OWE  C                   MOVE      *ON           *IN81
131401990223OWE  C                   LEAVE
131501990223OWE  C                   ENDIF
131601990223OWE  C                   ENDDO
131701990223      *
131801990223OWE   * Reset subfile position.....
131901000728OWE  C                   MOVE      RRNXX         RRNX
132001000728OWE  C     RRNX          CHAIN     HSS200C                            90
132101990223      *
132201990223      * Exit from subroutine if DOUB sr has been processed....
132301990223      *
132401990223OWE  C     *IN81         IFEQ      *ON
132501000728OWE  C                   MOVE      XKSERF        XKSERF
132601000728OWE  C                   MOVE      XKSERC        XKSERC
132701000728OWE  C                   MOVE      XKSERT        XKSERT
132801990223OWE  C                   MOVE      *OFF          *IN81
132901990223OWE  C                   LEAVE
133001990223OWE  C                   ENDIF
133101990223      *
133201990128     C     VCHKEY        SETLL     HSLVCTLA
133301000728     C     XKPROD        READE     HSLVCTLA                               92
133401990301      *
133501990301      * Move pointer file values into temporary fields....
133601990301      *
133701990301     C                   MOVE      BPROD         OPROD            13
133801990302     C                   MOVE      BSERCC        OSERC             3
133901990302     C                   MOVE      BSERNN        OSERN             9 0
134001990302     C                   Z-ADD     BSERNN        WKSERN
134101990302     C                   MOVE      BSERCC        WKSERC
134201000728     C                   Z-ADD     BSERNN        XXSERF            9 0
134301000728     C********             SUB  1         ##SERF
134401990301      *
134501990301      *
134601990127     C     *IN92         IFEQ      *OFF
134701990128      *
134801990301      * Scan voucher tracking file for first available voucher....
134901990301      *
135001000728     C                   MOVE      BSERCC        XKSERC
135101000728     C                   MOVE      OSERN         XKSERF
135201990301      *
135301990301     C     *IN94         DOUEQ     *ON
135401000728     C     XQUAN         OREQ      XKQTYN
135501990301      *
135601990303     C     *IN85         IFEQ      *ON
135701990302     C     TRCKEY        SETLL     HSLTRACB
135801990303     C                   MOVE      *OFF          *IN85
135901990303     C                   ENDIF
136001990302      *
136101000728     C     XKPROD        READE     HSLTRACB                               94
136201990301      *
136301990301     C     *IN94         IFEQ      *ON
136401990301     C                   LEAVE
136501990301     C                   ENDIF
136601990301      *
136701990301     C     ASERC         IFNE      WKSERC
136801990301     C     ASERN         ORNE      WKSERN
136901990302     C     AALLD         ORNE      *ZEROS
137001990303     C                   ADD       1             DSERN
137101990303      *
137201990303     C     *IN87         IFEQ      *OFF
137301990303     C     XXSERN        ADD       1             XXRES             9 0
137401990303PPP  C*          XXRES     IFNE ASERN
137501000728PPP  C*                    MOVE ASERN     ##SERF
137601990303PPP  C*                    ELSE
137701000728     C                   MOVE      ASERN         XXSERF
137801000728     C                   ADD       1             XXSERF
137901990303     C                   ADD       1             WKSERN
138001990303RRR  C                   MOVE      *ON           *IN85
138101000728RRR  C                   ADD       1             XKSERF
138201990303PPP  C*                    ENDIF
138301990303     C                   ELSE
138401990303      *
138501990303      * No previous error so add to HSPEXPA.....
138601990303     C                   MOVE(P)   WKSERC        XXSERC            3
138701990303     C                   MOVE(P)   WKSERN        XXSERN            9 0
138801990302     C                   SUB       1             WKSERN
138901000728     C                   MOVE      XYES          XJUMP
139001000728XXX  C                   MOVE      XYES          XJUMP1            1
139101990303      *
139201990303     C****       *IN87     IFEQ *ON
139301000728     C                   MOVE      XXSERF        USERNS
139401990301     C                   MOVE      WKSERN        USERNE
139501990301     C                   MOVE      WKSERC        USERCC
139601000728     C                   MOVE      XKPROD        UPROD
139701990302     C                   OPEN      HSLEXPAA
139801990302     C                   WRITE     HSFEXPA
139901990302     C                   CLOSE     HSLEXPAA
140001990303     C*****                ENDIF
140101990303      *
140201000728     C                   MOVE      ASERN         XXSERF
140301990303     C                   ADD       1             DSERN
140401990303     C     DSERN         IFNE      ASERN
140501990303     C     ASERN         SUB       DSERN         DIF               9 0
140601000728     C                   ADD       DIF           XXSERF
140701990303     C                   ENDIF
140801990303      *
140901000728     C                   ADD       1             XKSERF
141001990302     C                   ADD       2             WKSERN
141101990302     C                   MOVE      *ON           *IN85
141201990302     C                   MOVE      *OFF          *IN87
141301990302      *
141401990303XXX  C     ASERC         IFNE      WKSERC
141501990303XXX  C                   MOVE      ASERC         WKSERC
141601990303XXX  C                   MOVE      ASERN         WKSERN
141701000728XXX  C                   MOVE      WKSERC        XKSERC
141801000728XXX  C                   MOVE      WKSERN        XKSERF
141901000728XXX  C                   MOVE      WKSERN        XXSERF
142001990303XXX  C                   MOVE      *ON           *IN85
142101990303XXX  C                   ENDIF
142201990303      *
142301990301     C                   ITER
142401990301     C                   ENDIF
142501990303      *
142601990303     C     ASERC         IFNE      WKSERC
142701990303     C                   MOVE      ASERC         WKSERC
142801990303     C                   MOVE      ASERN         WKSERN
142901000728     C                   MOVE      WKSERC        XKSERC
143001000728XXX  C                   MOVE      WKSERN        XKSERF
143101000728XXX  C                   MOVE      WKSERN        XXSERF
143201990303     C                   MOVE      *ON           *IN85
143301990303     C                   ENDIF
143401990303      *
143501990303     C                   ENDIF
143601990301      *
143701990303      *
143801990302     C     AALLD         IFEQ      *ZEROS
143901990302     C***        *IN87     IFEQ *OFF
144001000728     C***                  ADD  1         ##SERF
144101990302     C***                  ENDIF
144201990302     C                   MOVE      *ON           *IN87
144301990301     C                   ADD       1             XQUAN
144401000728     C                   MOVE      XYES          XFIRST
144501990302     C                   MOVE      ASERC         WKSERC
144601990303     C                   MOVE(P)   ASERN         DSERN             9 0
144701990301     C                   ADD       1             WKSERN
144801000728     C                   ADD       1             XKSERF
144901990303     C                   MOVE      *ON           *IN85
145001990301     C                   ITER
145101990301     C                   ELSE
145201990303     C                   ITER
145301990301     C                   ENDIF
145401990301      *
145501990301     C                   ENDDO
145601990301      *
145701000728     C     XFIRST        IFEQ      XNO
145801000728     C                   MOVE      XYES          XERROR
145901990301     C                   MOVEL     'HSV2024'     P0MSID
146001000728     C                   EXSR      YSNDMG
146101000728     C                   CLEAR                   XKSERC
146201000728     C                   CLEAR                   XKSERT
146301000728     C                   CLEAR                   XKSERF
146401990301     C                   LEAVE
146501990301     C                   ENDIF
146601990128      *
146701000728     C     XQUAN         IFNE      XKQTYN
146801000728     C                   MOVE      XYES          XERROR
146901990301     C                   MOVEL     'HSV2025'     P0MSID
147001000728     C                   EXSR      YSNDMG
147101000728     C                   CLEAR                   XKSERC
147201000728     C                   CLEAR                   XKSERT
147301000728     C                   CLEAR                   XKSERF
147401990303     C*****                MOVE *ON       *IN52
147501990301     C                   LEAVE
147601990301     C                   ENDIF
147701990301      *
147801990303     C                   MOVE      *ON           *IN52
147901990303      *
148001000728     C     XJUMP         IFEQ      XYES
148101000728     C***                  MOVE #YES      #ERROR
148201990301     C                   MOVEL     'HSV2026'     P0MSID
148301000728     C                   EXSR      YSNDMG
148401990302      *
148501990302     C                   SUB       1             WKSERN
148601990303XXX  C                   MOVEL     'Y'           WKRANG
148701990302      *
148801000728     C*****                MOVE XXSERC    #KSERC
148901000728     C*****                MOVE XXSERN    #KSERF
149001990303     C*****      TRCKEY    CHAINHSLTRACB             99
149101990303     C*****      *IN99     IFEQ *OFF
149201000728     C*****                ADD  1         ##SERF
149301990303     C*****                ENDIF
149401990302      *
149501000728     C                   MOVE      XXSERF        USERNS
149601990302     C                   MOVE      WKSERN        USERNE
149701990302     C                   MOVE      WKSERC        USERCC
149801990302     C                   OPEN      HSLEXPAA
149901990302     C                   WRITE     HSFEXPA
150001990302     C                   CLOSE     HSLEXPAA
150101990302      *
150201000728     C                   CLEAR                   XKSERC
150301000728     C                   CLEAR                   XKSERT
150401000728     C                   CLEAR                   XKSERF
150501000728     C                   EXSR      YJUMP
150601990302     C                   MOVE      *ON           *IN86
150701990302     C                   MOVE      *ON           *IN61
150801990301     C                   LEAVE
150901990301     C                   ENDIF
151001990301      *
151101990128      * Series code found.
151201000728     C                   MOVE      BSERCC        XKSERC
151301990127      *
151401000728     C                   Z-ADD     OSERN         XKSERF
151501990302     C                   SUB       1             WKSERN
151601000728     C                   Z-ADD     WKSERN        XKSERT
151701990128      *
151801990128      * Flag successful range allocation.
151901990128     C                   MOVEL     'Y'           WKRANG
152001990128      *
152101990128      * Update if required.
152201990127     C                   ENDIF
152301990128     C                   ENDDO
152401990127      *
152501990128      * Unsuccessful range allocation.
152601990128     C     WKRANG        IFNE      'Y'
152701990128     C                   MOVEA     '111'         *IN(41)
152801000728XXX  C****                 MOVE #YES      #ERROR
152901990128     C                   MOVEL     'HSV2012'     P0MSID
153001000728     C                   EXSR      YSNDMG
153101990128     C                   ENDIF
153201990128      *
153301990122     C                   ENDSR
153401990302      *
153501990302      *----------------------------------------------------------------
153601990302      * Display contents of HSLEXPAA
153701990302      *----------------------------------------------------------------
153801990302      *
153901000728     C     YJUMP         BEGSR
154001990302     C                   ENDSR
154101990122      *
154201990302      *
154301990302      *----------------------------------------------------------------
154401990302      * Delete contents of HSLEXPAA
154501990302      *----------------------------------------------------------------
154601990302      *
154701000728     C     YDELT         BEGSR
154801990302     C                   CALL      'HSC200A'
154901990302     C                   ENDSR
155001990302      *
155101990223      *----------------------------------------------------------------
155201990223      * Repeat of Product Code in a single order
155301990223      *----------------------------------------------------------------
155401990223      *
155501990223OWE  C     DOUB          BEGSR
155601990223      *
155701990223      * Get Serial number range.
155801990223OWE  C                   MOVEL     *BLANKS       WKSERC
155901990223OWE  C     *IN92         DOUEQ     *ON
156001990223OWE  C     WKRANG        OREQ      'Y'
156101990223      *
156201990223OWE  C     VCHKEY        SETLL     HSLVCTLA
156301000728OWE  C     XKPROD        READE     HSLVCTLA                               92
156401990223OWE  C     *IN92         IFEQ      *OFF
156501990223      *
156601990223      * Get available series code.
156701000728OWEM C     BSERNN        ADD       TQTYN1        XXSERN            9 0
156801990302OWE  C*          ##SERN    IFGT BSERNE
156901990302OWE  C*                    MOVELBSERCN    WKSERC
157001990223OWE  C                   ITER
157101990223OWE  C                   ELSE
157201990223      *
157301990223      * Work back through the subfile searching for duplicate
157401990223      * product code/series code combination records......
157501990223      *
157601000728OWE  C                   MOVE(P)   RRNX          RRNXX             5 0
157701000728OWE  C     RRNX          DOUEQ     0
157801000728OWE  C                   SUB       1             RRNX
157901000728OWE  C     RRNX          IFEQ      0
158001990223OWE  C                   MOVE      *ON           *IN83
158101990223OWE  C                   LEAVE
158201990223OWE  C                   ENDIF
158301000728OWE  C     RRNX          CHAIN     HSS200C                            90
158401000728OWE  C     XKSERC        IFEQ      BSERCC
158501000728OWE  C     XKSERT        ADD       TQTYN1        RES               9 0
158601990302OWE  C*          RES       IFLE BSERNE
158701000728OWE  C                   MOVE(P)   XKSERC        KKSERC            3
158801000728OWE  C                   MOVE(P)   XKSERT        KKSERT            9 0
158901990223OWE  C                   LEAVE
159001990223OWE  C                   ELSE
159101990223OWE  C                   MOVE      *ON           *IN84
159201990223OWE  C                   LEAVE
159301990302OWE  C                   ENDIF
159401990302OWE  C*                    ENDIF
159501990223OWE  C                   ENDDO
159601990223      *
159701990223      * Reset the subfile pointer position.....
159801000728OWE  C                   MOVE(P)   RRNXX         RRNX
159901000728OWE  C     RRNX          CHAIN     HSS200C                            90
160001990223      *
160101990223OWE  C     *IN84         IFEQ      *OFF
160201990223OWE  C     *IN83         ANDEQ     *OFF
160301990223OWE   * Series code found.
160401000728OWE  C                   MOVE(P)   KKSERC        XKSERC            3
160501990223OWE   *
160601990223OWE   * Set To serial number for the order.
160701000728OWE  C                   MOVE(P)   RES           XKSERT            9 0
160801990223OWE   *
160901990223OWE   * Set From Serial Number for the order.
161001000728OWE  C     KKSERT        ADD       1             XKSERF            9 0
161101990223OWE   *
161201990223OWE   * Set Next Serial Number for the voucher control.
161301990223OWE  C                   ADD       TQTYN1        BSERNN
161401990223OWE   *
161501990223OWE   * Flag successful range allocation.
161601990223OWE  C                   MOVEL     'Y'           WKRANG
161701990223OWE  C                   ITER
161801990223OWE  C                   ENDIF
161901990223      *
162001990223OWE  C     *IN83         IFEQ      *ON
162101990223OWE  C     *IN84         ANDEQ     *OFF
162201990223OWE  C                   MOVE      *OFF          *IN83
162301990223      *
162401990223OWE   * Series code found.
162501000728OWE  C                   MOVE      BSERCC        XKSERC            3
162601990223OWE   *
162701990223OWE   * Set To serial number for the order.
162801000728OWE  C     BSERNN        ADD       TQTYN1        XKSERT            9 0
162901000728OWE  C                   SUB       1             XKSERT
163001990223OWE   *
163101990223OWE   * Set From Serial Number for the order.
163201000728OWE  C                   Z-ADD     BSERNN        XKSERF
163301990223OWE   *
163401990223OWE   * Set Next Serial Number for the voucher control.
163501990223OWE  C                   ADD       TQTYN1        BSERNN
163601990223OWE   *
163701990223OWE   * Flag successful range allocation.
163801990223OWE  C                   MOVEL     'Y'           WKRANG
163901990223OWE  C                   ITER
164001990223OWE  C                   ENDIF
164101990223OWE  C                   MOVE      *OFF          *IN84
164201990302OWE  C*                    MOVELBSERCN    WKSERC
164301990223      *
164401990302OWE  C*                    ENDIF
164501990223OWE  C                   ENDIF
164601990223OWE  C                   ENDDO
164701990223OWE  C                   ENDSR
164801990122      *----------------------------------------------------------------
164901990122      * Update voucher tracking.
165001990122      *----------------------------------------------------------------
165101990122     C     UPTRAC        BEGSR
165201990128      *
165301990128      * Reverse order date before update.
165401000728BL   C     YMODE         IFEQ      'E'
165501990215     C                   Z-ADD     JDD           WKD
165601990215     C                   Z-ADD     JMM           WKM
165701990215     C                   Z-ADD     JCC           WKC
165801990215     C                   Z-ADD     JYY           WKY
165901990215     C                   Z-ADD     WKORDD        ADFIS
166001990217BL   C                   ENDIF
166101990128      *
166201990128      * Locate voucher record.
166301990128     C     TRCKEY        SETLL     HSLTRACB
166401000728     C     XKPROD        DOUNE     APROD
166501990128     C     *IN99         OREQ      *ON
166601990128     C                   READ      HSLTRACB                               99
166701990128     C     *IN99         IFEQ      *OFF
166801990128      *
166901990128      * Exit if product code or series code does not match.
167001000728     C     XKPROD        IFNE      APROD
167101000728     C     XKSERC        ORNE      ASERC
167201990128     C                   LEAVE
167301990128     C                   ENDIF
167401990128      *
167501990128      * Update vouchers in the serial number range.
167601000728     C     XKSERF        IFLE      ASERN
167701000728     C     XKSERT        ANDGE     ASERN
167801000728BL   C     YMODE         IFEQ      'D'
167901000728BL   C                   MOVEL     XJCUST        ACUST
168001990217BL   C                   Z-ADD     0             ADSPB
168101990217BL   C                   ELSE
168201990217      *
168301000728     C                   Z-ADD     XJSORD        ASORD
168401990215     C                   Z-ADD     WKORDD        ADFIS
168501990128     C                   UPDATE    HSFTRAC
168601990217BL   C                   ENDIF
168701990128     C                   ENDIF
168801990128     C                   ENDIF
168901990128     C                   ENDDO
169001990122     C                   ENDSR
169101990122      *
169201990122      *----------------------------------------------------------------
169301990122      * Update inventory allocations.
169401990122      *----------------------------------------------------------------
169501990122     C     UPINVA        BEGSR
169601990128      *
169701990128      * Update stock quantities.
169801990205     C     IVMKEY        CHAIN     HSLINVMA                           99
169901990128     C     *IN99         IFEQ      *OFF
170001990128      *
170101990128      * Increase allocated quantity and reduce available quantity.
170201000728     C                   ADD       XKQTYN        DQTYR
170301000728     C                   SUB       XKQTYN        DQTYF
170401990128     C                   UPDATE    HSFINVM
170501990128     C                   ENDIF
170601990122     C                   ENDSR
170701990219      *
170801990219      *----------------------------------------------------------------
170901990219      * Update inventory sales.
171001990219      *----------------------------------------------------------------
171101990219BL   C     UPINVS        BEGSR
171201990219BL    *
171301990219BL    * Update stock quantities.
171401990219BL   C     IVMKEY        CHAIN     HSLINVMA                           99
171501990219BL   C     *IN99         IFEQ      *OFF
171601990219BL    *
171701990219BL    * Reduce allocated quantity and reduce on-hand quantity.
171801000728BL   C                   SUB       XKQTYN        DQTYR
171901000728BL   C                   SUB       XKQTYN        DQTYO
172001990219BL   C                   UPDATE    HSFINVM
172101990219BL   C                   ENDIF
172201990219BL   C                   ENDSR
172301990219      *
172401990122      *----------------------------------------------------------------
172501990122      * Print delivery note.
172601990122      *----------------------------------------------------------------
172701990122     C     PRTDEL        BEGSR
172801000728BL   C                   MOVEL     XJSORD        ORDPRM
172901990217BL   C                   CALL      'HSR230'
173001990217BL   C                   PARM                    ORDPRM
173101990122     C                   ENDSR
173201990122      *
173301990122      *----------------------------------------------------------------
173401990122      * Print invoice.
173501990122      *----------------------------------------------------------------
173601990122     C     PRTINV        BEGSR
173701000728BL   C                   MOVEL     XJSORD        ORDPRM
173801990217BL   C                   CALL      'HSR220'
173901990217BL   C                   PARM                    ORDPRM
174001990122     C                   ENDSR
174101990122      *
174201990122      *----------------------------------------------------------------
174301990122      * Create order details.
174401990122      *----------------------------------------------------------------
174501990122     C     UPORDD        BEGSR
174601990215      *
174701990215      * Order line already exists
174801990215     C                   MOVEL     ' '           UPDAT
174901000728     C     XOLIN         IFGT      0
175001990215     C     KEYOLN        CHAIN     HSLORDDB                           98
175101000728     C                   Z-ADD     XOLIN         KLINE
175201990215     C                   ENDIF
175301990128      *
175401990128      * Write fields for order detail record.
175501000728     C                   MOVEL     XSELC         KLTYP
175601000728     C                   MOVEL     XJCOMP        KCOMP
175701000728     C                   MOVEL     XJTYPE        KTYPE
175801000728     C                   Z-ADD     XJSORD        KSORD
175901000728     C                   Z-ADD     RRNX          KLINE
176001000728     C                   MOVEL     XJCUST        KCUST
176101000728     C                   MOVEL     XKPROD        KPROD
176201000728     C                   MOVEL     XKSERC        KSERC
176301000728     C                   Z-ADD     XKSERF        KSERNF
176401990128     C                   Z-ADD     0             KELEMF
176501000728     C                   Z-ADD     XKSERT        KSERNT
176601990128     C                   Z-ADD     0             KELEMT
176701000728     C                   Z-ADD     XKQTYN        KQTYN
176801990128     C                   Z-ADD     NCOST         KCOST
176901000728     C                   Z-ADD     XKPRIC        KPRIC
177001000728     C                   Z-ADD     XKVALU        KVALU
177101990208      *
177201990218BL    * Obtain VAT% from Order Type record.
177301000728BL   C*          #KVALU    MULT .175      KVATA
177401000728BL   C*          #KVALU    MULT MVATP     KVATA
177501990223BL   C*          KVATA     DIV  100       KVATA     H
177601990128     C                   Z-ADD     CYMD          KCRTD
177701000728     C                   Z-ADD     XXTME         KCRTT
177801000728     C                   MOVEL     XNDESC        KDESC
177901000728     C                   MOVEL     XJOBNO        KCRTS
178001000728     C                   MOVEL     XUSRID        KCRTU
178101000728     C                   MOVEL     XPGMID        KCRTP
178201990128     C                   MOVEL     *BLANK        KDELT
178301990215      *
178401990215      * Update order detail record.
178501000728     C     XOLIN         IFGT      0
178601990211     C     *IN98         IFEQ      *OFF
178701990211     C                   MOVEL     'Y'           UPDAT
178801990211     C                   UPDATE    HSFORDD
178901990211     C                   ENDIF
179001990211     C                   ELSE
179101990215      *
179201990128      * Write order detail record.
179301990128     C                   WRITE     HSFORDD
179401990211     C                   ENDIF
179501990122     C                   ENDSR
179601990122      *
179701990122      *----------------------------------------------------------------
179801990122      * Create order header.
179901990122      *----------------------------------------------------------------
180001990122     C     UPORDH        BEGSR
180101990215      *
180201990215      * Program mode - Maintenance, or Dispatch
180301000728     C     YMODE         IFEQ      'M'
180401000728     C     YMODE         OREQ      'D'
180501990215      *
180601990215      * Access order header record.
180701000728     C     XJSORD        CHAIN     HSLORDHA                           99
180801990215     C                   ENDIF
180901990128      *
181001990128      * Write fields for order header record.
181101000728     C                   MOVEL     XJCOMP        JCOMP
181201000728     C                   MOVEL     XJCUST        JCUST
181301990128     C                   MOVEL     *BLANKS       JCUSB
181401000728     C                   MOVEL     XJORDR        JORDR
181501000728     C                   MOVEL     XJTYPE        JTYPE
181601000728     C                   Z-ADD     XJSORD        JSORD
181701990128     C                   Z-ADD     WKORDD        JORDD
181801990128     C                   MOVEL     *BLANKS       JINVN
181901990128     C                   Z-ADD     0             JINVD
182001990128     C                   MOVEL     *BLANKS       JDELN
182101990128     C                   Z-ADD     0             JDELD
182201990128     C                   Z-ADD     CYMD          JCRTD
182301000728     C                   Z-ADD     XXTME         JCRTT
182401000728     C                   MOVEL     XJOBNO        JCRTS
182501000728     C                   MOVEL     XUSRID        JCRTU
182601000728     C                   MOVEL     XPGMID        JCRTP
182701990128     C                   MOVEL     *BLANK        JDELT
182801990128      *
182901990215      * Program mode - Entry
183001000728     C     YMODE         IFEQ      'E'
183101990211      *
183201990128      * Write order header record.
183301990217BL   C                   MOVEL     'A'           JSTAT
183401990217     C                   WRITE     HSFORDH
183501990211     C                   ENDIF
183601990211      *
183701990215      * Program mode - Maintenance, or Dispatch
183801000728     C     YMODE         IFEQ      'M'
183901000728     C     YMODE         OREQ      'D'
184001000728BL   C     YMODE         IFEQ      'D'
184101990225BL   C                   Z-ADD     *DATE         JDELD
184201990217BL   C                   MOVEL     'D'           JSTAT
184301990217BL   C                   ENDIF
184401990211      *
184501990211      * Update order header record.
184601990211     C     *IN99         IFEQ      *OFF
184701990211     C                   UPDATE    HSFORDH
184801990211     C                   ENDIF
184901990211     C                   ENDIF
185001990122     C                   ENDSR
185101990122      *
185201990128      *----------------------------------------------------------------
185301990128      * Create order delivery details.
185401990128     C     UPODEL        BEGSR
185501990215      *
185601990215      * Program mode - Maintenance, or Dispatch
185701000728     C     YMODE         IFEQ      'M'
185801000728     C     YMODE         OREQ      'D'
185901990215      *
186001000728     C     XJSORD        CHAIN     HSFODEL                            99
186101990215     C                   ENDIF
186201990128      *
186301990128      * Write fields for order delivery detail record.
186401000728     C                   MOVEL     XJCOMP        VCOMP
186501000728     C                   MOVEL     XJTYPE        VTYPE
186601000728     C                   Z-ADD     XJSORD        VSORD
186701000728     C                   MOVEL     XVNAM1        VNAM1
186801000728     C                   MOVEL     XVADR1        VADR1
186901000728     C                   MOVEL     XVADR2        VADR2
187001000728     C                   MOVEL     XVADR3        VADR3
187101000728     C                   MOVEL     XVPCDE        VPCDE
187201000728     C                   MOVEL     XVDIN1        VDIN1
187301000728     C                   MOVEL     XVDIN2        VDIN2
187401000728     C                   MOVEL     XVDIN3        VDIN3
187501990128     C                   MOVEL     *BLANKS       VDELT
187601990128      *
187701990215      * Program mode - Entry
187801000728     C     YMODE         IFEQ      'E'
187901990211      *
188001990211      * Write order delivery details record.
188101990211     C                   WRITE     HSFODEL
188201990211     C                   ENDIF
188301990211      *
188401990215      * Program mode - Maintenance, or Dispatch
188501000728     C     YMODE         IFEQ      'M'
188601000728     C     YMODE         OREQ      'D'
188701990211      *
188801990211      * Update order delivery details record.
188901990211     C     *IN99         IFEQ      *OFF
189001990211     C                   UPDATE    HSFODEL
189101990211     C                   ENDIF
189201990211     C                   ENDIF
189301990211      *
189401990128     C                   ENDSR
189501990128      *----------------------------------------------------------------
189601990128      * Create inventory sales transaction.
189701990128      *----------------------------------------------------------------
189801990128     C     UPINVT        BEGSR
189901990128      *
190001990128      * Write fields for inventory sales transaction record.
190101000728     C                   MOVEL     XJCOMP        CCOMP
190201000728     C                   MOVEL     XJWHSE        CWHSE
190301000728     C                   MOVEL     XKPROD        CPROD
190401990128     C                   MOVEL     *BLANKS       CSUBCF
190501990128     C                   MOVEL     *BLANKS       CSUBCT
190601990128     C                   MOVEL     *BLANKS       CVTYP
190701000728     C                   MOVEL     XKSERC        CSERC
190801000728     C                   Z-ADD     XKSERF        CSERNF
190901990128     C                   Z-ADD     0             CELEMF
191001000728     C                   Z-ADD     XKSERT        CSERNT
191101990128     C                   Z-ADD     0             CELEMT
191201000728     C                   Z-ADD     XKQTYN        CQTYN
191301990128     C                   Z-ADD     0             CBATC
191401000728BL   C                   MOVEL(P)  XJSORD        CDELN
191501990128     C                   MOVEL     *BLANKS       CREAS
191601990128     C                   Z-ADD     CYMD          CTDAT
191701990218BL   C                   MOVEL     MTTYP         CTYPE
191801990128     C                   MOVEL     *BLANKS       CSUPP
191901000728     C                   MOVEL     XJCUST        CCUST
192001990128     C                   MOVEL     *BLANKS       CAREA
192101990128     C                   MOVEL     *BLANKS       CAISL
192201990128     C                   MOVEL     *BLANKS       CBAYR
192301990128     C                   MOVEL     *BLANKS       CLEVL
192401990128     C                   MOVEL     *BLANKS       CINVN
192501990128     C                   Z-ADD     CYMD          CCRTD
192601000728     C                   Z-ADD     XXTME         CCRTT
192701000728     C                   MOVEL     XJOBNO        CCRTS
192801000728     C                   MOVEL     XUSRID        CCRTU
192901000728     C                   MOVEL     XPGMID        CCRTP
193001990128     C                   MOVEL     *BLANK        CDELT
193101990128      *
193201990128      * Write inventory sales transaction record.
193301990128     C                   WRITE     HSFINVT
193401990128     C                   ENDSR
193501990128      *
193601990107      *----------------------------------------------------------------
193701990122      * VALIDH - Validate header screen.
193801990107      *----------------------------------------------------------------
193901990107      *
194001990122     C     VALIDH        BEGSR
194101990108      *
194201990111      * Screen Header validation:
194301990114      *
194401990125      * Reset work values.
194501000728     C                   RESET                   XERROR
194601990125     C                   MOVE      *OFF          *IN61                          Hide F10/F11
194701990125      *
194801990125      * Reset error indicators.
194901000728     C                   MOVEA     XZEROS        *IN(30)
195001990125      *
195101990125      * Validate that Order Type is a valid Type.
195201000728     C     XJTYPE        CHAIN     HSLORDPA                           99
195301990125     C     *IN99         IFEQ      *ON
195401990125     C                   MOVE      *ON           *IN30
195501000728     C                   MOVE      XYES          XERROR
195601990125     C                   MOVEL     'HSV2001'     P0MSID
195701000728     C                   EXSR      YSNDMG
195801990125     C                   ENDIF
195901990125      *
196001990125      * Validate that Company is valid.
196101000728     C     XJCOMP        IFNE      *BLANKS
196201000728     C     XJCOMP        CHAIN     HSLCOMPA                           99
196301990125     C     *IN99         IFEQ      *ON
196401990125     C                   MOVE      *ON           *IN31
196501000728     C                   MOVE      XYES          XERROR
196601990125     C                   MOVEL     'HSV2002'     P0MSID
196701000728     C                   EXSR      YSNDMG
196801990125     C                   ENDIF
196901990125     C                   ENDIF
197001990125      *
197101990125      * Validate that Warehouse is valid.
197201000728     C     XJWHSE        IFNE      *BLANKS
197301000728     C     XJWHSE        CHAIN     HSLWHSEA                           99
197401990125     C     *IN99         IFEQ      *ON
197501990125     C                   MOVE      *ON           *IN32
197601000728     C                   MOVE      XYES          XERROR
197701990125     C                   MOVEL     'HSV0006'     P0MSID
197801000728     C                   EXSR      YSNDMG
197901990125     C                   ENDIF
198001990125     C                   ENDIF
198101990125      *
198201990125      * Validate Post Code
198301000728XXX  C     XJCUST        IFEQ      *BLANKS
198401000728     C     XJPCDE        IFNE      *BLANKS
198501000728     C     XJPCDE        CHAIN     HSLCUSTB                           99
198601990125     C     *IN99         IFEQ      *ON
198701990125     C                   MOVE      *ON           *IN33
198801000728     C                   MOVE      XYES          XERROR
198901990125     C                   MOVEL     'HSV2003'     P0MSID
199001000728     C                   EXSR      YSNDMG
199101990125     C                   ENDIF
199201990125      *
199301990125      * If Customer is found
199401990125     C     *IN99         IFEQ      *OFF
199501990125      * ...load Customer record into screen fields.
199601000728XXXM C                   MOVEL     ENAM1         XJNAM1                         Name 1
199701000728XXXM C                   MOVEL     ENAM2         XJNAM2                         Name 2
199801000728XXXM C                   MOVEL     EADR1         XJADR1                         Address 1
199901000728XXXM C                   MOVEL     EADR2         XJADR2                         Address 2
200001000728XXXM C                   MOVE      ECUST         XJCUST                         Cust No.
200101000728XXX  C                   MOVE      ECLIM         XJCLIM           15 0          Credit Limit
200201000728XXX  C                   MOVE      ETYSL         XJTYSL           20 5          Last Year Sales
200301990225XXX  C                   ENDIF
200401990125      *
200501990125     C                   ENDIF
200601990126     C                   ENDIF
200701990125      *
200801990125      * Validate Customer Number
200901000728XXXD C*          #JCUST    IFNE *BLANKS
201001000728     C     XJCUST        CHAIN     HSLCUSTA                           99
201101990125     C     *IN99         IFEQ      *ON
201201990125     C                   MOVE      *ON           *IN34
201301000728     C                   MOVE      XYES          XERROR
201401990125     C                   MOVEL     'HSV2004'     P0MSID
201501000728     C                   EXSR      YSNDMG
201601990125     C                   ENDIF
201701990125      *
201801990125      * If Customer is found
201901990125     C     *IN99         IFEQ      *OFF
202001990125      * ...load Customer record into screen fields.
202101000728XXXM C                   MOVEL     ENAM1         XJNAM1                         Name 1
202201000728XXXM C                   MOVEL     ENAM2         XJNAM2                         Name 2
202301000728XXXM C                   MOVEL     EADR1         XJADR1                         Address 1
202401000728XXXM C                   MOVEL     EADR2         XJADR2                         Address 2
202501000728XXXM C                   MOVE      EPCDE         XJPCDE                         Post Code
202601000728XXX  C                   MOVE      ECLIM         XJCLIM           15 0          Credit Limit
202701000728XXX  C                   MOVE      ETYSL         XJTYSL           20 5          Last Year Sales
202801990225XXX   *
202901990225XXX   * Check customer's credit rating allows order entry......
203001990225XXX  C     ECRAT         IFEQ      '01 '
203101990225XXX  C                   MOVE      *ON           *IN34
203201000728XXX  C                   MOVE      XYES          XERROR
203301990225XXX  C                   MOVEL     'HSV2018'     P0MSID
203401000728XXX  C                   EXSR      YSNDMG
203501990225XXX  C                   ENDIF
203601990205      *
203701990205     C                   ENDIF
203801990225XXXD C*                    ENDIF
203901990205      *
204001990205      * Maximum discount is 40%
204101000728     C     XJDISP        IFGT      40
204201990205     C                   MOVE      *ON           *IN36
204301000728     C                   MOVE      XYES          XERROR
204401990205     C                   MOVEL     'HSV0142'     P0MSID
204501000728     C                   EXSR      YSNDMG
204601990205     C                   ENDIF
204701990215      *
204801990128      * Check order date
204901000728     C     XJORDD        IFEQ      0
205001000728     C                   EXSR      YDATEC
205101990125     C                   ELSE
205201990215      *
205301990215      * a) Check for leap year and adjust number of days in February
205401990215      *    in Days in Month array.
205501990215     C     JYY           DIV       4             REM               4 0
205601990215     C     REM           IFEQ      0
205701990215     C                   MOVEL     'Y'           LEAP              1
205801990215     C                   ELSE
205901990215     C                   MOVEL     ' '           LEAP
206001990215     C                   ENDIF
206101990215     C                   SELECT
206201990215     C     LEAP          WHENEQ    ' '
206301990215     C                   MOVEA     28            DIM(2)
206401990215     C     LEAP          WHENEQ    'Y'
206501990215     C                   MOVEA     29            DIM(2)
206601990215     C                   ENDSL
206701990126      * Day
206801990126     C     JDD           IFGT      31
206901990126     C     JDD           ORLT      01
207001990126      * Month
207101990125     C     JMM           ORGT      12
207201990126     C     JMM           ORLT      01
207301990215      *
207401990215      * If date error found...
207501990215     C                   MOVE      *ON           *IN35
207601000728     C                   MOVE      XYES          XERROR
207701990215     C                   MOVEL     'HSV2005'     P0MSID
207801000728     C                   EXSR      YSNDMG
207901990215     C                   ENDIF
208001990215      *
208101990215      * Validate Day within month.
208201990215     C                   Z-ADD     JMM           M                 2 0
208301990215     C     JDD           IFLT      1
208401990215     C     JMM           ORGE      1
208501990215     C     JMM           ANDLE     12
208601990215     C     JDD           ANDGT     DIM(M)
208701990128      *
208801990128      * If date error found...
208901990125     C                   MOVE      *ON           *IN35
209001000728     C                   MOVE      XYES          XERROR
209101990125     C                   MOVEL     'HSV2005'     P0MSID
209201000728     C                   EXSR      YSNDMG
209301990125     C                   ENDIF
209401990125     C                   ENDIF
209501990125      *
209601990128      * If no errors found...
209701000728     C     XERROR        IFEQ      XNO
209801990125      * ...display "Data valid.Press F10 to update" message...
209901990125     C                   MOVEL     'HSV9006'     P0MSID
210001000728     C                   EXSR      YSNDMG
210101990125      * ...activate F10 key (*IN61=*ON).
210201990302     C                   MOVE      *ON           *IN61
210301990125     C                   ENDIF
210401990125      *
210501990107     C                   ENDSR
210601990125      *
210701990125      *----------------------------------------------------------------
210801000728      * @DATEC - Date Check Routine
210901990125      *----------------------------------------------------------------
211001990125      *
211101000728     C     YDATEC        BEGSR
211201990125      *
211301990128      * Convert six-digit system date to eight digits, with century.
211401990125     C                   MOVEL     UDAY          DD
211501990125     C                   MOVEL     UMONTH        MM
211601990125     C                   MOVEL     UYEAR         YY
211701990125     C     YY            IFGT      80
211801990125     C                   Z-ADD     19            CC
211901990125     C                   ELSE
212001990125     C                   Z-ADD     20            CC
212101990125     C                   ENDIF
212201990223     C                   MOVEL     CC            CCYY              4 0
212301990223     C                   MOVE      YY            CCYY
212401990128      *
212501990128      * Set default date for order entry.
212601000728     C     XJORDD        IFEQ      0
212701000728     C                   Z-ADD     DMCY          XJORDD
212801990125     C                   ENDIF
212901990128      *
213001990128      * Set date for transaction audit field.
213101990128     C                   Z-ADD     DD            DDD
213201990128     C                   Z-ADD     MM            MMM
213301990128     C                   Z-ADD     CC            CCC
213401990128     C                   Z-ADD     YY            YYY
213501990125     C                   ENDSR
213601990125      *
213701990115      *----------------------------------------------------------------
213801000728      * @SERCH - F4 prompt control.
213901990115      *----------------------------------------------------------------
214001990115      *
214101000728     C     YSERCH        BEGSR
214201990115      *
214301990115      * Check that cursor is in a valid field for prompting.
214401990126     C     CSRRCD        IFEQ      'HSS200A'
214501000728     C     CSRFLD        ANDEQ     'XJCUST'
214601990125     C     CSRRCD        OREQ      'HSS200A'
214701000728     C     CSRFLD        ANDEQ     'XJTYPE'
214801990126     C     CSRRCD        OREQ      'HSS200A'
214901000728     C     CSRFLD        ANDEQ     'XJCOMP'
215001990125     C     CSRRCD        OREQ      'HSS200A'
215101000728     C     CSRFLD        ANDEQ     'XJWHSE'
215201990126     C     CSRRCD        OREQ      'HSS200A'
215301000728     C     CSRFLD        ANDEQ     'XJPCDE'
215401990127     C     CSRRCD        OREQ      'HSS200C'
215501000728     C     CSRFLD        ANDEQ     'XKPROD'
215601990126      *
215701990119      * Move appropriate data to parameter fields depending upon search
215801990119      * field chosen.
215901990119     C                   SELECT
216001990119      *
216101990119      * Customer No.
216201000728     C     CSRFLD        WHENEQ    'XJCUST'
216301000728     C                   MOVEL(P)  'HSLCUSTA'    FILEY
216401000728     C                   MOVEL(P)  'ENAM1'       NAMEY
216501000728     C                   MOVEL(P)  'ECUST'       NUMBRY
216601990125      *
216701990125      * Post Code
216801000728     C     CSRFLD        WHENEQ    'XJPCDE'
216901000728     C                   MOVEL(P)  'HSLCUSTB'    FILEY
217001000728     C                   MOVEL(P)  'ENAM1'       NAMEY
217101000728     C                   MOVEL(P)  'EPCDE'       NUMBRY
217201990119      *
217301990125      * Order Type.
217401000728     C     CSRFLD        WHENEQ    'XJTYPE'
217501000728     C                   MOVEL(P)  'HSLORDPA'    FILEY
217601000728     C                   MOVEL(P)  'MODES'       NAMEY
217701000728     C                   MOVEL(P)  'MOTYP'       NUMBRY
217801990119      *
217901990125      * Company Code
218001000728     C     CSRFLD        WHENEQ    'XJCOMP'
218101000728     C                   MOVEL(P)  'HSLCOMPA'    FILEY
218201000728     C                   MOVEL(P)  'WODES'       NAMEY
218301000728     C                   MOVEL(P)  'WCOMP'       NUMBRY
218401990126      *
218501990126      * Warehouse Code
218601000728     C     CSRFLD        WHENEQ    'XJWHSE'
218701000728     C                   MOVEL(P)  'HSLWHSEA'    FILEY
218801000728     C                   MOVEL(P)  'PODES'       NAMEY
218901000728     C                   MOVEL(P)  'PWHSE'       NUMBRY
219001990125      *
219101990126      * Product Code
219201000728     C     CSRFLD        WHENEQ    'XKPROD'
219301000728     C                   MOVEL(P)  'HSLPRODA'    FILEY
219401000728     C                   MOVEL(P)  'NDESC'       NAMEY
219501000728     C                   MOVEL(P)  'NPROD'       NUMBRY
219601990125      *
219701990119     C                   ENDSL
219801990115      *
219901990115      * Call system window program to retrieve data.  If Return Code is
220001990115      * *OFF then load retrieved data into screen fields.
220101000728     C                   Z-ADD     10            LINY
220201000728     C                   Z-ADD     8             COLY
220301990115     C                   CALL      'HSR341'      PL341
220401990119      *
220501990119      * If Return Code is *OFF then load retrieved data into
220601990119      * appropriate screen fields.
220701000728     C     YRTNC         IFEQ      *OFF                                         ..If2
220801990119      *
220901990119     C                   SELECT
221001990119      *
221101990119      * Customer No.
221201000728     C     CSRFLD        WHENEQ    'XJCUST'
221301000728     C                   MOVEL(P)  YNUMBR        XJCUST
221401990125      *
221501990125      * Post Code
221601000728     C     CSRFLD        WHENEQ    'XJPCDE'
221701000728     C                   MOVEL(P)  YNUMBR        XJPCDE
221801990119      *
221901990119      * Customer Type.
222001000728     C     CSRFLD        WHENEQ    'XJTYPE'
222101000728     C                   MOVEL(P)  YNUMBR        XJTYPE
222201990125      *
222301990125      * Company Code
222401000728     C     CSRFLD        WHENEQ    'XJCOMP'
222501000728     C                   MOVEL(P)  YNUMBR        XJCOMP
222601990125      *
222701990125      * Warehouse Code
222801000728     C     CSRFLD        WHENEQ    'XJWHSE'
222901000728     C                   MOVEL(P)  YNUMBR        XJWHSE
223001990126      *
223101990126      * Product Code
223201000728     C     CSRFLD        WHENEQ    'XKPROD'
223301000728     C                   MOVEL(P)  YNUMBR        XKPROD
223401990119      *
223501990119     C                   ENDSL
223601990121     C                   ENDIF                                                  ..EndIf2
223701990115      *
223801990119      * otherwise cursor is in wrong format/field so display message.
223901990121     C                   ELSE                                                   .ElseIf1
224001990115     C                   MOVEL     'HSV9009'     P0MSID
224101000728     C                   EXSR      YSNDMG
224201990119     C                   ENDIF                                                  .EndIf1
224301990115      *
224401990115     C                   ENDSR
224501990106      *
224601990127      *----------------------------------------------------------------
224701000728      * @SERSF - F4 prompt control for order detail subfile.
224801990127      *----------------------------------------------------------------
224901990127      *
225001000728     C     YSERSF        BEGSR
225101990127      * Clear row / column control.
225201990127     C                   Z-ADD     0             CSRROW
225301990127     C                   Z-ADD     0             CSRCOL
225401990127      *
225501990127      * Retrieve the current cursor position.
225601990127     C     CSRLOC        DIV       256           ROW               2 0
225701990127     C                   MVR                     COL               2 0
225801990127     C                   Z-ADD     ROW           CSRROW
225901990127     C                   Z-ADD     COL           CSRCOL
226001990127      *
226101990127      * Execute search.
226201000728     C                   EXSR      YSERCH
226301990127      *
226401990127      * Flag subfile record to return value.
226501990127     C     CSRRRN        CHAIN     HSS200C                            99
226601990127     C     *IN99         IFEQ      *OFF
226701990127     C                   MOVEL     *ON           *IN37
226801000728XXX  C     YNUMBR        IFNE      *BLANKS
226901000728     C                   MOVEL(P)  YNUMBR        XKPROD
227001990225XXX  C                   ENDIF
227101990127     C                   UPDATE    HSS200C
227201990127     C                   MOVEL     *OFF          *IN37
227301990127     C                   ENDIF
227401990127     C                   ENDSR
227501990127      *
227601990106      *----------------------------------------------------------------
227701000728      * @SNDMG - Send message to this program's MSGQ.
227801990106      *----------------------------------------------------------------
227901990106      *
228001000728     C     YSNDMG        BEGSR
228101990106      *
228201990107     C                   CALL      'SNDMSGC'
228301990106     C                   PARM                    P0PGMQ                         Program queue
228401990106     C                   PARM                    P0PGRL                         Rel queue
228501990106     C                   PARM                    P0MSID                         Message ID
228601990106     C                   PARM                    P0MSGF                         Message file
228701990106     C                   PARM                    P0MSDA                         Message data
228801990106     C                   PARM                    P0MSTP                         Message type
228901990106      *
229001990106     C                   ENDSR
229101990106      *
229201990106      *----------------------------------------------------------------
229301000728      * @CLRMG - Clear message(s) from this program's MSGQ.
229401990106      *----------------------------------------------------------------
229501990106      *
229601000728     C     YCLRMG        BEGSR
229701990106      *
229801990107     C                   CALL      'RMVMSGC'
229901990106      *
230001990106     C                   ENDSR
230101990106      *
230201990223      *----------------------------------------------------------------
230301990223      * *UPPVCT- Update the voucher control
230401990223      *----------------------------------------------------------------
230501990223      *
230601990223     C     UPPVCT        BEGSR
230701990225     C                   Z-ADD     1             RRNQ
230801990225     C     RRNQ          CHAIN     HSS200C                            97
230901990223     C     *IN97         DOWEQ     *OFF
231001990223      *
231101990225     C                   ADD       1             RRNQ
231201000728     C     XSELC         IFNE      *BLANK
231301000728     C     XKPROD        ORNE      *BLANK
231401000728     C     XNDESC        ORNE      *BLANK
231501000728     C     XKPRIC        ORNE      *ZEROS
231601000728     C     XKQTYN        ORNE      *ZEROS
231701000728     C     XKVALU        ORNE      *ZEROS
231801000728     C     XKVATA        ORNE      *ZEROS
231901000728     C     XKSERC        ORNE      *BLANKS
232001000728     C     XKSERF        ORNE      *ZEROS
232101000728     C     XKSERT        ORNE      *ZEROS
232201000728     C                   MOVE      XKSERC        WKSERC
232301000728     C                   MOVE      XKSERT        TEMP              9 0
232401990223     C                   ADD       1             TEMP
232501990223     C     VCHKEY        SETLL     HSLVCTLA
232601000728     C     XKPROD        READE     HSLVCTLA                               92
232701990223     C                   MOVE      TEMP          BSERNN
232801990223     C                   UPDATE    HSFVCTL
232901990223     C                   ENDIF
233001990223      *
233101990225     C     RRNQ          IFEQ      100
233201990223     C                   LEAVE
233301990223     C                   ENDIF
233401990225     C     RRNQ          CHAIN     HSS200C                            97
233501990223     C                   ENDDO
233601990223     C                   ENDSR
233701990223      *
233801990106      *----------------------------------------------------------------
233901990106      * *INZSR - Initialization.
234001990106      *----------------------------------------------------------------
234101990106      *
234201990106     C     *INZSR        BEGSR
234301990217BL    *
234401990217BL    * Dummy read to open file.
234501990217BL   C                   READ      HSPINVT                                99
234601990222BL   C                   UPDATE    HSFINVT
234701990302     C                   OPEN      HSLEXPAA
234801990302BL   C                   READ      HSLEXPAA                               99
234901990302     C                   CLOSE     HSLEXPAA
235001990127      *
235101990106      * Key lists.
235201990128      * Key List for Voucher Control.
235301990127     C     VCHKEY        KLIST
235401000728     C                   KFLD                    XKPROD
235501990128     C                   KFLD                    WKSERC
235601990223      *
235701990223      * Key List for Voucher Cross-Reference.
235801990223     C     KEYXRF        KLIST
235901990223     C                   KFLD                    CCYY
236001000728     C                   KFLD                    XJCUST
236101000728     C                   KFLD                    XKPROD
236201990205      *
236301990211      * Key List for Sales Order.
236401990211     C     KEYOLN        KLIST
236501000728     C                   KFLD                    XJSORD
236601000728     C                   KFLD                    XOLIN
236701990211      *
236801990205      * Key List for Inventory Masterfile.
236901990205     C     IVMKEY        KLIST
237001000728     C                   KFLD                    XKPROD
237101990205     C                   KFLD                    WKSUBC
237201990205     C                   MOVE      *BLANKS       WKSUBC
237301990115      *
237401990128      * Key List for Voucher Tracking.
237501990128     C     TRCKEY        KLIST
237601000728     C                   KFLD                    XKPROD
237701000728     C                   KFLD                    XKSERC
237801000728     C                   KFLD                    XKSERF
237901990215      *
238001990301      * Key List for Customer Discount File.
238101990215     C     DSCKEY        KLIST
238201990215     C                   KFLD                    ECTYP
238301990215     C                   KFLD                    PFAMT
238401990128      *
238501990115      * Parameter Lists.
238601990203      * Entry parameter list.
238701990203     C     *ENTRY        PLIST
238801000728     C                   PARM                    YMODE             1            Mode
238901000728     C                   PARM                    YORDNO            8            Sales Order No.
239001000728     C                   PARM                    YTYPE             3            Order Type
239101000728     C                   PARM                    YCUST             8            Customer No.
239201990203      *
239301990115      * List for Call to HSR341 - Search program.
239401990115     C     PL341         PLIST
239501000728     C                   PARM                    YRTNC             1
239601000728     C                   PARM                    YNUMBR           15
239701000728     C                   PARM                    FILEY            10
239801000728     C                   PARM                    NAMEY             6
239901000728     C                   PARM                    NUMBRY            6
240001000728     C                   PARM                    LINY              3 0
240101000728     C                   PARM                    COLY              3 0
240201990127      *
240301990127      * Field definitions
240401000728     C     *LIKE         DEFINE    XKVALU        WKTOTV
240501000728     C     *LIKE         DEFINE    XKSERC        WKSERC
240601990128     C     *LIKE         DEFINE    BSERNN        WKSERN
240701000728     C     *LIKE         DEFINE    XKQTYN        WKQTYN
240801990211     C     *LIKE         DEFINE    DSUBC         WKSUBC
240901000728     C     *LIKE         DEFINE    XNO           WKRANG
241001000728     C     *LIKE         DEFINE    XNO           WKVCTL
241101000728     C     *LIKE         DEFINE    XNO           UPDAT
241201990106      *
241301990106      * Variable declarations.
241401000728     C                   MOVE      '0'           XNO               1
241501000728     C                   MOVE      '1'           XYES              1
241601000728     C                   MOVE      XNO           XERROR            1
241701000728     C                   MOVE      XNO           XUPDAT            1
241801000728     C                   MOVE      XNO           XDELET            1
241901990217BL   C                   MOVEL     *BLANKS       ORDPRM            8
242001990126     C                   Z-ADD     1             RCDNBR
242101000728     C                   Z-ADD     0             RRNX              5 0
242201990211     C                   Z-ADD     0             RRNVAL            5 0
242301990225     C                   Z-ADD     0             RRNLIN            5 0
242401990225     C                   Z-ADD     0             RRNQ              5 0
242501990225     C                   Z-ADD     0             RRNP              5 0
242601990106      *
242701990106      * Prepare message subfile.
242801990106     C                   MOVE      *ON           *IN79
242901000728     C                   MOVE      XPGMID        P0PGMQ           10            Program queu
243001990111     C                   MOVEL     '*PRV'        P0PGRL            5            Rel queue
243101990106     C                   MOVE      *BLANKS       P0MSID            7            Message ID
243201990106     C                   MOVEL     'HSM001'      P0MSGF           10            Message file
243301990106     C                   MOVE      *BLANKS       P0MSDA          132            Message data
243401990106     C                   MOVEL     '*INFO'       P0MSTP            7            Message type
243501990204      *
243601000728     C                   EXSR      YDATEC
243701990106      *
243801990106     C                   ENDSR
243901990215** Days in Month array DIM.
244001990215312831303130313130313031
