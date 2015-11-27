000001888888      *%CSTD===========================================================*
000002888888      ** Application. : SAM        Arcad Sample Application            *
000003888888      ** Component. . : HSR200                        Type: RPG        *
000004888888      **===============================================================*
000005888888      ** Sub-system . :                                                *
000006888888      ** Function . . :                                                *
000007888888      ** Sub-function :                                                *
000008888888      **%S=============================================================*
000009888888      ** Description of functions:                                     *
000010888888      **                                                               *
000011888888      **                                                               *
000012888888      **                                                               *
000013888888      **%E=============================================================*
000014888888      ** AUTHOR:                          00:00                        *
000015888888      ** MODIFS: 01 ARCAD_PGMR 06/26/2015 11:13  01.00.01    00/       *
000016888888      *%ECSTD==========================================================*
001800990122      */TITLE Sales Order Entry / Maintenance / Inquiry
001900990106      *
002000990106      * System        : HSV Control & Tracking
002100990122      * Author        : Bob Lee (Intec Systems)
002200990106      * Date          : January 1999
002300990106      *
002400990106      *================================================================
002500990106      * Indicator usage:
002600990219      *  20 - Order Valid for Despatch
002700990128      *  30 - 45 Input fields- DSPATR.
002800990128      *  62 - Control display/non-display of F10-Update.
002900990210      *  75 - 78 Program mode - Dispatch/Entry/Inquiry/Maintenance
003000990128      *  79 - MSGSFL (SFLCLR ETC...).
003100990106      *  99 - General CHAIN/SETLL result.
003200990106      *
003300990106      *================================================================
003400990106      * Maintenance   :
003500990106      * Fix/Chg Ref. Date       Description.
003600990106      * ------------ ---------- -----------------------------------
003700990106      *================================================================
003701140523      *%EXEC OVRDBF INTFILE EXTFILE
003702140523      *%ATTR TGTRLS(V7R1M0)
003703140523      *
003800990222     H            Y
003900990125     FHSLCUSTBIF  E           K        DISK
004000140523     F            HSFCUST                           KRENAMEHSFCUSTB
004100990125      * Customer Master by Post Code.
004200990125      *
004300990122     FHSLCUSTAIF  E           K        DISK
004400990125      * Customer Master by Customer Account.
004500990106      *
004600990318     F*LTCUSTAIF  E           K        DISK
004700990318     F*           HSFCUST                           KRENAMEALTCUSTF
004800990216      * Customer Master by Customer Account.
004900990216      *
005000990122     FHSLORDPAIF  E           K        DISK
005100990122      * Sales Order Parameters.
005200990114      *
005300990128     FHSLTRACBUF  E           K        DISK
005400990203      * Voucher Tracking by Product/Series/Serial No./Element No.
005500990302      *
005600990302     FHSLEXPAAUF  E           K        DISK                      A    UC
005700990302      * Unbanded Order line file by Product/Series/Serial No.
005800990122      *
005900990127     FHSLVCTLAUF  E           K        DISK
006000990122      * Voucher Control.
006100990122      *
006200990223     FHSLVXRFBIF  E           K        DISK
006300990122      * Agency Product Cross-Reference.
006400990122      *
006500990203     FHSLORDHAUF  E           K        DISK                      A
006600990122      * Sales Order Header.
006700990122      *
006800990211     FHSLORDDBUF  E           K        DISK                      A
006900990122      * Sales Order Detail.
007000990122      *
007100990204     FHSLODELAUF  E           K        DISK                      A
007200990122      * Sales Order Delivery Detail.
007300990122      *
007400990125     FHSLSHPOAIF  E           K        DISK
007500990122      * Ship Only.
007600990302      *
007700990128     FHSLINVMAUF  E           K        DISK
007800990122      * Inventory Master.
007900990122      *
008000990125     FHSLWHSEAIF  E           K        DISK
008100990122      * Warehouse Master.
008200990122      *
008300990125     FHSLCOMPAIF  E           K        DISK
008400990122      * Company Master.
008500990122      *
008600990126     FHSLPRODAIF  E           K        DISK
008700990122      * Product Master.
008800990122      *
008900990215     FHSLDISCAIF  E           K        DISK
009000990215      * Customer Discount File
009100990215      *
009200990217BL   FHSPINVT UF  E           K        DISK                      A
009300990122      * Inventory Transactions.
009400990122      *
009500060315BL   FARTICLE IF  E           K        DISK
009600060315      * FOR ARTCILE XREF
009700060315      *
009800990122     FHSS200  CF  E                    WORKSTN      KINFDS INFDS
009900000728     F                                        RRNX  KSFILE HSS200C
010000990106      * Screen file.
010100990106      *================================================================
010200990107      * Arrays.
010300990107      *
010400990215      * Days in Month for date validation.
010500990215     E                    DIM    12  12  2 0
010600990107      *================================================================
010700990301      * Data Structures.
010800990106      *
010900990106      * Screen Information DS.
011000990106     IINFDS       DS
011100990106     I                                      369 369 KEY
011200990127     I                                    B 370 3710CSRLOC
011300990106      *
011400000728     IXXXSDS     SDS                            429
011500000728     I                                     *PROGRAM XPGMID
011600000728     I                                      244 253 XJOBNO
011700000728     I                                      254 263 XUSRID
011800990125      *
011900990121      * General DDMMCCYY date format.
012000990121     I            DS
012100990204     I I                                      1   20DD
012200990204     I I                                      3   40MM
012300990204     I I                                      5   60CC
012400990204     I I                                      7   80YY
012500990125     I                                        1   80DMCY
012600990128      *
012700990128      * General CCYYMMDD date format.
012800990128     I            DS
012900990204     I I                                      1   20CCC
013000990204     I I                                      3   40YYY
013100990204     I I                                      5   60MMM
013200990204     I I                                      7   80DDD
013300990128     I                                        1   80CYMD
013400990106      *
013500990128      * Input order date format.
013600990125     I            DS
013700990126     I I                                      1   20JDD
013800990126     I I                                      3   40JMM
013900990126     I I                                      5   60JCC
014000990126     I I                                      7   80JYY
014100000728     I                                        1   80XJORDD
014200990125      *
014300990128      * Output order date format.
014400990128     I            DS
014500990204     I I                                      1   20WKC
014600990204     I I                                      3   40WKY
014700990204     I I                                      5   60WKM
014800990204     I I                                      7   80WKD
014900990128     I                                        1   80WKORDD
015000990128      *
015100990106      *----------------------------------------------------------------
015200990106      * Constants.
015300990106      *
015400990106      * Named hexidecimal constants for function keys.
015500990106     I              X'33'                 C         F03
015600990106     I              X'34'                 C         F04
015700990106     I              X'36'                 C         F06
015800990219     I              X'37'                 C         F07
015900990203     I              X'3A'                 C         F10
016000990106     I              X'3B'                 C         F11
016100990113     I              X'3C'                 C         F12
016200990119      *
016300990119      * Zeros to "SETOF" error indicators.
016400000728     I              '0000000000000000000' C         XZEROS
016500990106      *
016600990106      *================================================================
016700990106      * M A I N L I N E
016800990106      *================================================================
016900990210      *
017000990210      * Dispatch mode
017100000728     C           YMODE     IFEQ 'D'
017200990210     C                     MOVEL*ON       *IN75
017300990210     C                     ELSE
017400990210     C                     MOVEL*OFF      *IN75
017500990210     C                     ENDIF
017600060315     C                     READ ARTICLE                  99
017700990210      *
017800990210      * Entry mode
017900000728     C           YMODE     IFEQ 'E'
018000990210     C                     MOVEL*ON       *IN76
018100990210     C                     ELSE
018200990210     C                     MOVEL*OFF      *IN76
018300990210     C                     ENDIF
018400990120      *
018500990203      * Inquiry mode
018600000728     C           YMODE     IFEQ 'I'
018700990203     C                     MOVEL*ON       *IN77
018800990203     C                     ELSE
018900990203     C                     MOVEL*OFF      *IN77
019000990203     C                     ENDIF
019100990205      *
019200990205      * Maintenance mode
019300000728     C           YMODE     IFEQ 'M'
019400990205     C                     MOVEL*ON       *IN78
019500990205     C                     ELSE
019600990205     C                     MOVEL*OFF      *IN78
019700990205     C                     ENDIF
019800990205      *
019900990203      * Program mode
020000990226     C           START     TAG
020100000728     C           YMODE     IFEQ 'I'
020200000728     C           YMODE     OREQ 'D'
020300000728     C           YMODE     OREQ 'M'
020400000728     C           YORDNO    IFNE *BLANKS
020500000728     C                     MOVELYORDNO    XJSORD
020600000728     C                     MOVELYORDNO    WKORDN  80
020700990203     C           WKORDN    CHAINHSLORDHA             99
020800990203     C                     ENDIF
020900990203     C                     ENDIF
021000990203      *
021100000728     C           YMODE     IFEQ 'D'
021200000728     C                     MOVE JTYPE     XJTYPE
021300000728     C                     MOVE JCUST     XJCUST
021400990219     C                     Z-ADDJORDD     WKORDD
021500990219     C                     Z-ADDWKC       JCC
021600990219     C                     Z-ADDWKY       JYY
021700990219     C                     Z-ADDWKM       JMM
021800990219     C                     Z-ADDWKD       JDD
021900000728     C                     MOVE JORDR     XJORDR
022000000728     C                     MOVE JSORD     XJSORD
022100990219     C           JSTAT     IFEQ 'A'
022200990219     C           JSTAT     OREQ ' '
022300990219     C                     MOVE *ON       *IN20
022400990219     C                     ELSE
022500990219     C                     MOVE *OFF      *IN20
022600990219     C                     MOVEL'HSV2015' P0MSID
022700000728     C                     EXSR YSNDMG
022800990219     C                     ENDIF
022900990216     C           JCUST     CHAINHSLCUSTA             13
023000000728     C                     MOVE EPCDE     XJPCDE
023100000728     C                     MOVE ENAM1     XENAM1
023200990216     C           JSORD     SETLLHSLORDDB
023300990216     C           JSORD     READEHSLORDDB                 99
023400990216     C           *IN99     DOWEQ*OFF
023500000728     C                     ADD  KQTYN     XVQTY
023600990216     C           JSORD     READEHSLORDDB                 99
023700990216     C                     ENDDO
023800000728     C                     Z-ADDKDISP     XJDISP
023900990216     C                     ELSE
024000000728     C                     EXSR YCLRSC
024100990216     C                     ENDIF
024200990219      *
024300990225      * Dispatch mode.
024400000728XXX  C           YMODE     IFEQ 'D'
024500990225XXX  C           JSORD     CHAINHSLODELA             99
024600990225XXX  C           VNAM1     IFEQ *BLANKS
024700000728XXX  C                     MOVELENAM1     XXNAM1    P
024800000728XXX  C                     MOVELENAM2     XXNAM2    P
024900000728XXX  C                     MOVELEADR1     XXADR1    P
025000000728XXX  C                     MOVELEADR2     XXADR2    P
025100990225XXX  C                     ELSE
025200000728XXX  C                     MOVELVNAM1     XXNAM1    P
025300000728XXX  C                     MOVE *BLANKS   XXNAM2
025400000728XXX  C                     MOVELVADR1     XXADR1    P
025500000728XXX  C                     MOVELVADR2     XXADR2    P
025600990225XXX  C                     ENDIF
025700990225XXX  C                     ENDIF
025800990225      *
025900990225      * Dispatch, or Inquiry, or Maintenance mode.
026000000728XXX  C           YMODE     IFEQ 'I'
026100000728XXX  C           YMODE     OREQ 'D'
026200000728XXX  C           YMODE     OREQ 'M'
026300000728XXX  C                     MOVELYCUST     XJCUST
026400000728XXX  C                     MOVELYTYPE     XJTYPE
026500990225XXX  C                     ENDIF
026600990219     C           HDR       TAG
026700990225XXX  C                     MOVE *OFF      *IN47
026800990122      * Display screen to receive Customer No. until F03/F10
026900990128     C           KEY       DOUEQF03
027000990122     C           KEY       OREQ F10
027100000728     C           XERROR    ANDEQXNO
027200990121      *
027300990302      * Exit if F03 pressed.
027400990302     C           KEY       IFEQ F03
027500990302     C                     MOVE *ON       *INLR
027600990302     C                     LEAVE
027700990302     C                     ENDIF
027800990302      *
027900990121      * Display messages.
028000990121     C                     WRITEMSGCTL
028100990121      *
028200000728     C                     TIME           XXTME
028300990122     C                     EXFMTHSS200A
028400990225      *
028500000728ZZZ  C           XJTYPE    CHAINHSLORDPA             99
028600990302ZZZ  C           MSALE     IFEQ 'C'
028700990302ZZZ  C                     MOVE *ON       *IN30
028800000728ZZZ  C                     MOVE XYES      XERROR
028900990302ZZZ  C                     MOVEL'HSV2027' P0MSID
029000000728ZZZ  C                     EXSR YSNDMG
029100990302ZZZ  C                     ITER
029200990302ZZZ  C                     ENDIF
029300990302      *
029400000728XXX  C                     CLEARXVQTY
029500990225XXX  C           *IN20     IFEQ *OFF
029600000728XXX  C           YMODE     ANDEQ'D'
029700990225XXX  C                     ITER
029800990225XXX  C                     ENDIF
029900990225      *
030000990217BL   C                     Z-ADD1         RCDNBR
030100990121      *
030200990121      * Clear messages.
030300000728     C                     EXSR YCLRMG
030400990120      *
030500990120      * Process the various function keys available on the screen.
030600990219      *
030700990219      * Process Despatch if F07 pressed.
030800990226     C           KEY       IFEQ F07
030900990226      *
031000990226      * Validate that Order Type is a valid Type.
031100000728     C           XJTYPE    CHAINHSLORDPA             99
031200990226     C           *IN99     IFEQ *ON
031300990226     C                     MOVE *ON       *IN30
031400000728     C                     MOVE XYES      XERROR
031500990226     C                     MOVEL'HSV2001' P0MSID
031600000728     C                     EXSR YSNDMG
031700990226     C                     GOTO START
031800990226     C                     ENDIF
031900990226     C                     ENDIF
032000990219      *
032100000728     C           YMODE     IFEQ 'D'
032200000728     C           WKORDN    ANDNEXJSORD
032300000728     C                     MOVELXJSORD    WKORDN  80
032400000728     C           XJSORD    CHAINHSLORDHA             99
032500990219     C           *IN99     IFEQ *ON
032600990219     C                     MOVE *OFF      *IN20
032700990219     C                     MOVEL'HSV2017' P0MSID
032800000728     C                     EXSR YSNDMG
032900990219     C                     ELSE
033000000728     C                     MOVE JTYPE     XJTYPE
033100000728     C                     MOVE JCUST     XJCUST
033200990219     C                     Z-ADDJORDD     WKORDD
033300990219     C                     Z-ADDWKC       JCC
033400990219     C                     Z-ADDWKY       JYY
033500990219     C                     Z-ADDWKM       JMM
033600990219     C                     Z-ADDWKD       JDD
033700000728     C                     MOVE JORDR     XJORDR
033800000728     C                     MOVE JSORD     XJSORD
033900990219     C           JSTAT     IFEQ 'A'
034000990219     C           JSTAT     OREQ ' '
034100990219     C                     MOVE *ON       *IN20
034200990219     C                     ELSE
034300990219     C                     MOVE *OFF      *IN20
034400990219     C                     MOVEL'HSV2015' P0MSID
034500000728     C                     EXSR YSNDMG
034600990219     C                     ENDIF
034700990219     C                     ENDIF
034800990219     C           JCUST     CHAINHSLCUSTA             13
034900000728     C                     MOVE EPCDE     XJPCDE
035000000728     C                     MOVE ENAM1     XENAM1
035100990219     C           JSORD     SETLLHSLORDDB
035200990219     C           JSORD     READEHSLORDDB                 99
035300990219     C           *IN99     DOWEQ*OFF
035400000728     C                     ADD  KQTYN     XVQTY
035500990219     C           JSORD     READEHSLORDDB                 99
035600990219     C                     ENDDO
035700000728     C                     Z-ADDKDISP     XJDISP
035800990222     C                     GOTO HDR
035900990219     C                     ENDIF
036000990204      *
036100990211      * Program in inquiry, dispatch or maintenance mode
036200000728     C           YMODE     IFEQ 'I'
036300000728     C           YMODE     OREQ 'M'
036400000728     C           YMODE     OREQ 'D'
036500990204      *
036600990204      * Initialise subfile
036700990215     C                     MOVEA'1001'    *IN,70
036800990204     C                     WRITEHSS200B
036900000728     C           XJSORD    IFNE 0
037000000728     C                     Z-ADD0         RRNX
037100000728     C           XJSORD    SETLLHSLORDDB
037200990204     C           *IN97     DOUEQ*ON
037300000728     C           XJSORD    READEHSLORDDB                 97
037400990204      *
037500990204      * Build subfile from existing order.
037600990204     C           *IN97     IFEQ *OFF
037700000728     C                     ADD  1         RRNX
037800000728     C           RRNX      CHAINHSS200C              99
037900000728     C                     Z-ADDKLINE     XOLIN
038000000728     C                     MOVELKLTYP     XSELC
038100000728     C                     MOVELKPROD     XKPROD
038200000728     C                     MOVELKDESC     XNDESC
038300000728     C                     MOVELKSERC     XKSERC
038400000728     C                     Z-ADDKSERNF    XKSERF
038500000728     C                     Z-ADDKSERNT    XKSERT
038600000728     C                     Z-ADDKQTYN     XKQTYN
038700000728     C                     Z-ADDKPRIC     XKPRIC
038800000728     C                     Z-ADDKVALU     XKVALU
038900000728XXX  C                     MOVE XKQTYN    XXQTYN
039000990218BL    *
039100990218BL    * Ship Only - set line value to zero.
039200990218BL   C           SHONLY    IFEQ 'Y'
039300000728BL   C           XSELC     ANDEQ'S'
039400000728BL   C                     Z-ADD0         XKVALU
039500990218BL   C                     ENDIF
039600990218BL    *
039700000728BL   C*          £KVALU    MULT MVATP     £KVATA
039800990204      *
039900990204      * Extended value
040000000728     C           XSELC     IFEQ 'S'
040100000728     C           XSELC     OREQ 'N'
040200000728     C           XKPRIC    MULT XKQTYN    XKVALU
040300990218BL    *
040400990218BL    * Ship Only - set line value to zero.
040500990218BL   C           SHONLY    IFEQ 'Y'
040600000728BL   C           XSELC     ANDEQ'S'
040700000728BL   C                     Z-ADD0         XKVALU
040800990218BL   C                     ENDIF
040900990218BL    *
041000000728BL   C*          £KVALU    MULT MVATP     £KVATA
041100990215      *
041200990204     C                     ENDIF
041300990204      *
041400990215      * Write subfile record.
041500990215     C           *IN99     IFEQ *OFF
041600990215     C                     UPDATHSS200C
041700990215     C                     ELSE
041800990215     C                     WRITEHSS200C
041900990215     C                     ENDIF
042000990204     C                     ENDIF
042100990204     C                     ENDDO
042200990204     C                     ENDIF
042300990204     C                     LEAVE
042400990204     C                     ENDIF
042500990215      *
042600990215      * Program mode - Entry
042700000728     C           YMODE     IFEQ 'E'
042800990120      *
042900990120      * Execute search if F04 pressed.
043000990128     C           KEY       IFEQ F04
043100000728     C                     EXSR YSERCH
043200990225XXX  C                     ITER
043300000728XXX  C                     EXSR YCLRMG
043400990128     C                     ENDIF
043500990121      *
043600990122      * Validate header screen fields.
043700990122     C                     EXSR VALIDH
043800990121      *
043900990122      * Validate ship only requirements.
044000990122     C                     EXSR SHPONL
044100990106      *
044200990204     C                     ENDIF
044300990225      *
044400990225      * Process Despatch if F07 pressed.
044500990225RT   C           KEY       IFEQ F07
044600990225      *
044700990225RT   C                     LEAVE
044800990225RT   C                     ENDIF
044900990225      *
045000990122      * End of DO loops for F03/F10 key checks.
045100990128     C                     ENDDO
045200990302     C                     MOVE *OFF      *IN61
045300990106      *
045400990127      * Clear messages.
045500000728     C                     EXSR YCLRMG
045600990204      *
045700990204      * Exit if F03 pressed.
045800990204     C           KEY       IFEQ F03
045900990204      * Exit program.
046000990204     C                     MOVE *ON       *INLR
046100990204     C                     RETRN
046200990204     C                     ENDIF
046300990127      *
046400990128      *-------------------------------------------------------
046500990215      *
046600990215      * Program mode - Entry
046700990128      * Retrieve order number.
046800000728     C           YMODE     IFEQ 'E'
046900000728     C           *NAMVAR   DEFN HSAORDERNOORDERX  80
047000000728     C           *LOCK     IN   ORDERX
047100000728     C                     ADD  1         ORDERX
047200000728     C                     OUT  ORDERX
047300000728     C                     Z-ADDORDERX    XJSORD
047400990204     C                     ENDIF
047500990128      *
047600990122      * Display screen to receive Order Details until F10/F12
047700990127     C           DET       TAG
047800990204      *
047900990215      * Program in inquiry, or dispatch, or maintenance mode
048000000728     C           YMODE     IFEQ 'I'
048100000728     C           YMODE     OREQ 'M'
048200000728     C           YMODE     OREQ 'D'
048300990205     C           KEY       OREQ F12
048400990205     C                     MOVEL*OFF      *IN73
048500990205     C                     ELSE
048600990205     C                     MOVEL*ON       *IN73
048700990204     C                     ENDIF
048800990204      *
048900990128     C           KEY       DOUEQF10
049000000728     C           XERROR    ANDEQXNO
049100990126     C           KEY       OREQ F12
049200990122      *
049300990122      * Display messages.
049400990122     C                     WRITEMSGCTL
049500990122      *
049600990211      * Read subfile to accumulate order value.
049700000728     C           RRNX      IFGT 0
049800990211     C                     Z-ADD1         RRNVAL
049900000728     C                     Z-ADD0         XKTVAL
050000990211     C           *IN98     DOUEQ*ON
050100990217BL   C           RRNVAL    OREQ 100
050200000728BL   C           XSELC     OREQ *BLANK
050300990211     C           RRNVAL    CHAINHSS200C              98
050400000728     C           XSELC     IFNE *BLANK
050500000728     C           XKPROD    ANDNE*BLANK
050600990211     C           *IN98     ANDEQ*OFF
050700000728     C           XSELC     ORNE *BLANK
050800000728     C           XNDESC    ANDNE*BLANK
050900990211     C           *IN98     ANDEQ*OFF
051000000728     C                     ADD  XKVALU    XKTVAL
051100990211     C                     ENDIF
051200990211     C                     ADD  1         RRNVAL
051300990211     C                     ENDDO
051400990211     C                     ENDIF
051500990225      *
051600990225      * Dispatch mode.
051700000728XXX  C           YMODE     IFEQ 'D'
051800000728XXX  C           XJCUST    CHAINHSLCUSTA             99
051900990225XXX   * ...load Customer record into screen 2 fields.
052000000728XXX  C                     MOVELENAM1     XJNAM1           Name 1
052100000728XXX  C                     MOVELENAM2     XJNAM2           Name 2
052200000728XXX  C                     MOVELEADR1     XJADR1           Address 1
052300000728XXX  C                     MOVELEADR2     XJADR2           Address 2
052400990225XXX  C                     ENDIF
052500990225      *
052600990211      *
052700990211      * Display footer.
052800990225RT   C           KEY       IFNE F07
052900990127     C                     WRITEHSS200E
053000990225RT   C                     ENDIF
053100990204      *
053200000728     C                     TIME           XXTME
053300990205     C                     MOVEA'011'     *IN,70
053400990204      *
053500990225RT   C           KEY       IFNE F07
053600990127     C                     EXFMTHSS200B
053700000728XXX  C                     MOVE XNO       XJUMP1
053800990302      *
053900990302     C           KEY       IFNE F10
054000000728     C                     EXSR YDELT
054100990302     C                     ENDIF
054200990302      *
054300990302RT   C                     ENDIF
054400990302      *
054500990127     C                     MOVEL*OFF      *IN73
054600990302     C                     MOVEL*OFF      *IN86
054700990122      *
054800990223OWE   * Clear messages (Only if an error has not been repeated)
054900990223      *
055000000728OWE  C           XERROR    IFEQ XNO
055100990122      * Clear messages.
055200000728     C                     EXSR YCLRMG
055300990223OWE  C                     ENDIF
055400990122      *
055500990122      * Process the various function keys available on the screen.
055600990302      *
055700990122      * Exit if F12 pressed.
055800990128     C           KEY       IFEQ F12
055900990127     C                     GOTO HDR
056000990128     C                     ENDIF
056100990122      *
056200990122      * Execute search if F04 pressed.
056300990128     C           KEY       IFEQ F04
056400000728     C                     EXSR YSERSF
056500990126     C                     ITER
056600990128     C                     ENDIF
056700990122      *
056800990122      * Check for agency cross-references.
056900990217BL   C           MXREF     IFEQ 'Y'
057000990122     C                     EXSR AGXREF
057100990217BL   C                     ENDIF
057200990122      *
057300990223OWE   * Validate order detail screen fields (only re-validate data
057400990223OWE   * if it has been changed. Otherwise re-display error message).
057500000728OWE  C           XERROR    IFEQ XYES
057600990223OWE  C           RRNS      CHAINHSS200C              98
057700000728OWE  C           XSELC     IFNE TSELC
057800000728OWE  C           XKPROD    ORNE TPROD
057900000728OWE  C           XKPRIC    ORNE TPRIC
058000000728OWE  C           XKQTYN    ORNE TQTYN
058100000728OWE  C           XNDESC    ORNE TDESC
058200990223OWE  C                     MOVE *ON       *IN93
058300990223OWE  C                     ENDIF
058400990223OWE  C                     ENDIF
058500990225      *
058600990223OWE  C           *IN93     IFEQ *ON
058700000728     C           XERROR    OREQ XNO
058800990223      *
058900990223      * Validate order detail screen fields.
059000990223     C                     EXSR VALIDD
059100990223OWE  C                     ENDIF
059200990122      *
059300990122      * Discount retrieval.
059400990122     C                     EXSR DISCNT
059500990122      *
059600990122      * Stock allocation preview
059700990122      *                 - with banded allocation and manual allocation.
059800990223BL   C*          MSALE     IFEQ 'S'
059900990223     C*                    EXSR ALLOCS
060000990223BL   C*                    ENDIF
060100990122      *
060200990302      * Process Dispatch if F07 pressed.
060300990225RT   C           KEY       IFEQ F07
060400990225      *
060500990225RT   C                     LEAVE
060600990225RT   C                     ENDIF
060700990225      *
060800990122      * End of DO loops for F10/F12 key checks.
060900990128     C                     ENDDO
061000990122      *
061100990122      *-------------------------------------------------------
061200990122      * Confirm order - prompt for delivery details.
061300990122      *               - file updates when F10 pressed.
061400990128     C           KEY       DOUEQF10
061500000728     C           XERROR    ANDEQXNO
061600990127     C           KEY       OREQ F12
061700990127      *
061800990127      * Clear messages.
061900000728     C                     EXSR YCLRMG
062000990127      *
062100990127      * Process the various function keys available on the screen.
062200990127      *
062300990127      * Exit if F12 pressed.
062400990223OOO  C*          KEY       IFEQ F12
062500990223OOO  C*                    GOTO DET
062600990223OOO  C*                    ENDIF
062700990122      *
062800990122      * Check for minimum order value.
062900990225RT   C           KEY       IFNE F07
063000990127     C           MORDV     IFGT 0
063100990122     C                     EXSR MINVAL
063200990127     C                     ENDIF
063300990225      *
063400990225XXX   * Credit limit check.... Warning only.
063500000728XXX  C           XKTVAL    ADD  XJTYSL    TOT    205
063600000728XXX  C           TOT       IFGT XJCLIM
063700990225XXX  C                     MOVE *ON       *IN46
063800990225XXX  C                     MOVEL'HSV2019' P0MSID
063900000728XXX  C                     EXSR YSNDMG
064000990225XXX  C                     ENDIF
064100990225RT   C                     ENDIF
064200990225      *
064300990122      * Display messages.
064400990122     C                     WRITEMSGCTL
064500990127      *
064600990128      * Display key text footer.
064700990225XXXM C*                    WRITEHSS200E
064800990225RT   C           KEY       IFNE F07
064900990225XXXM C                     WRITEHSS200F
065000990225RT   C                     ENDIF
065100990122      *
065200990128      * Delivery address prompt screen.
065300000728     C                     TIME           XXTME
065400990204      *
065500990211      * Program in inquiry, dispatch or maintenance mode
065600000728     C           YMODE     IFEQ 'I'
065700000728     C           YMODE     OREQ 'M'
065800000728     C           YMODE     OREQ 'D'
065900990204     C           WKORDN    CHAINHSLODELA             99
066000990204      *
066100990204      * Write fields for order delivery detail record.
066200990204     C           *IN99     IFEQ *OFF
066300000728     C                     MOVELVNAM1     XVNAM1
066400000728     C                     MOVELVADR1     XVADR1
066500000728     C                     MOVELVADR2     XVADR2
066600000728     C                     MOVELVADR3     XVADR3
066700000728     C                     MOVELVPCDE     XVPCDE
066800000728     C                     MOVELVDIN1     XVDIN1
066900000728     C                     MOVELVDIN2     XVDIN2
067000000728     C                     MOVELVDIN3     XVDIN3
067100990204     C                     ENDIF
067200990204     C                     ENDIF
067300990204      *
067400990204      * Write order delivery details record.
067500990225RT   C           KEY       IFNE F07
067600990127     C                     EXFMTHSS200D
067700990225RT   C                     ENDIF
067800990223      *
067900990223OWE   * Exit if F12 pressed.
068000990223OWE  C           KEY       IFEQ F12
068100000728     C                     EXSR YDELT
068200990223OWE  C                     GOTO DET
068300990223OWE  C                     ENDIF
068400990122      *
068500990122      * Clear messages.
068600990225XXX  C           *IN47     IFEQ *OFF
068700000728     C                     EXSR YCLRMG
068800990225XXX  C                     ENDIF
068900990122      *
069000990128      * Update all files, if no errors exist.
069100990201     C           KEY       IFEQ F10
069200000728     C           XERROR    ANDEQXNO
069300990225RT   C           KEY       OREQ F07
069400000728     C                     Z-ADD1         RRNX
069500990217     C           *IN98     DOUEQ*ON
069600000728BL   C           RRNX      OREQ 100
069700000728BL   C           XSELC     OREQ *BLANK
069800000728     C           RRNX      CHAINHSS200C              98
069900000728     C           XSELC     IFNE *BLANK
070000000728     C           XKPROD    ANDNE*BLANK
070100990211     C           *IN98     ANDEQ*OFF
070200000728     C           XSELC     ORNE *BLANK
070300000728     C           XNDESC    ANDNE*BLANK
070400990211     C           *IN98     ANDEQ*OFF
070500990225      *
070600990225      * Save RRN for current order line.
070700000728     C                     Z-ADDRRNX      RRNLIN
070800990223      *
070900990225OWE   * Update Voucher Control if in entry mode....
071000000728OWE  C           YMODE     IFEQ 'E'
071100990223BL   C           MSALE     ANDEQ'S'
071200990223OWE  C                     EXSR UPPVCT
071300990223OWE  C                     ENDIF
071400990223      *
071500990225      * Re-position to required subfile line
071600000728     C                     Z-ADDRRNLIN    RRNX
071700000728     C           RRNX      CHAINHSS200C              98
071800990122      *
071900990218BL    * Create/Update order details if in Entry,Maint,or Dispatch mode.
072000000728BL   C           YMODE     IFEQ 'E'
072100000728BL   C           YMODE     OREQ 'D'
072200000728BL   C           YMODE     OREQ 'M'
072300990122     C                     EXSR UPORDD
072400990218BL   C                     ENDIF
072500990218      *
072600990218BL    * Update voucher tracking if in Entry or Dispatch mode.
072700990218BL    * Stock lines only.
072800000728     C           YMODE     IFEQ 'E'
072900000728     C           XSELC     ANDEQ'S'
073000000728BL   C           YMODE     OREQ 'D'
073100000728BL   C           XSELC     ANDEQ'S'
073200990211     C                     EXSR UPTRAC
073300990217BL   C                     ENDIF
073400990219      *
073500990219BL    * Allocate inventory if in Entry mode.
073600990219BL    * Stock lines only.
073700000728BL   C           YMODE     IFEQ 'E'
073800000728BL   C           XSELC     ANDEQ'S'
073900990219      * Update inventory allocations.
074000990219     C                     EXSR UPINVA
074100990219     C                     ENDIF
074200990218      *
074300990219BL    * Sell inventory if in Dispatch mode.
074400990218BL    * Stock lines only.
074500000728BL   C           YMODE     IFEQ 'D'
074600000728BL   C           XSELC     ANDEQ'S'
074700990219      * Update inventory sales.
074800990219BL   C                     EXSR UPINVS
074900990211      *
075000990211      * Create inventory sales transaction.
075100990128     C                     EXSR UPINVT
075200990211     C                     ENDIF
075300990128     C                     ENDIF
075400000728     C                     ADD  1         RRNX
075500990128     C                     ENDDO
075600990211      *
075700990218BL    * Create/Update order header if in Entry,Maint,or Dispatch mode.
075800000728BL   C           YMODE     IFEQ 'E'
075900000728BL   C           YMODE     OREQ 'D'
076000000728BL   C           YMODE     OREQ 'M'
076100990211     C                     EXSR UPORDH
076200990211      *
076300990218      * Create/update delivery record if in Entry,Maint or Dispat.mode.
076400990211     C                     EXSR UPODEL
076500990218BL   C                     ENDIF
076600990128      *
076700990218BL    * Ship to all delivery points if in Entry mode.
076800000728BL   C           YMODE     IFEQ 'E'
076900990218BL   C           MALLP     ANDEQ'Y'
077000990128     C                     EXSR SHPALL
077100990218BL   C                     ENDIF
077200990128      *
077300990218BL    * Print delivery note if in Entry mode, and charges only not set.
077400000728BL   C           YMODE     IFEQ 'E'
077500990218BL   C           MINVC     ANDNE'Y'
077600990128     C                     EXSR PRTDEL
077700990218BL   C                     ENDIF
077800990128      *
077900990218BL    * Print Invoice if in Entry mode, and Immediate print required.
078000000728BL   C           YMODE     IFEQ 'E'
078100990218BL   C           MINVP     ANDEQ'I'
078200990128     C                     EXSR PRTINV
078300990217BL   C                     ENDIF
078400990218      *
078500990128     C                     ENDIF
078600990225      * Process Despatch if F07 pressed.
078700990225RT   C           KEY       IFEQ F07
078800000728     C                     EXSR YCLRSC
078900990225      *
079000990225RT   C                     LEAVE
079100990225RT   C                     ENDIF
079200990128      *
079300990122      * End of Confirmation.
079400990128     C                     ENDDO
079500990205      *
079600990205      * Return to order details if F12 pressed.
079700990205     C           KEY       IFEQ F12
079800990205     C                     GOTO DET
079900990205     C                     ENDIF
080000990205      *
080100990205      * Clear Subfile
080200990205     C                     MOVEA'1000'    *IN,70
080300990205     C                     WRITEHSS200B
080400990302      *
080500990302      * Clear contents of HSPEXPA.
080600000728     C                     EXSR YDELT
080700990205      *
080800990205      * Return to order header.
080900990205     C                     GOTO HDR
081000990122      *
081100990106      *****************************************************************
081200990120      *----------------------------------------------------------------
081300000728      * ‡CLRSC - Clear screen fields.
081400990120      *----------------------------------------------------------------
081500990120      *
081600000728     C           YCLRSC    BEGSR
081700990120      *
081800990217BL    * Clear header screen fields.
081900000728BL   C           YMODE     IFNE 'E'
082000000728     C                     CLEARXJTYPE
082100990217BL   C                     ENDIF
082200000728BL   C           YMODE     IFEQ 'D'
082300000728     C                     CLEARXJSORD
082400000728     C                     CLEARXENAM1
082500000728     C                     CLEARXVQTY
082600990219BL   C                     ENDIF
082700000728     C                     CLEARXJCOMP
082800000728     C                     CLEARXJWHSE
082900000728     C                     CLEARXJPCDE
083000000728     C                     CLEARXJCUST
083100000728     C                     CLEARXJDISP
083200000728     C                     CLEARXJORDD
083300000728     C                     CLEARXJORDR
083400990120      *
083500990217BL    * Clear delivery screen fields.
083600000728BL   C                     CLEARXVNAM1
083700000728BL   C                     CLEARXVADR1
083800000728BL   C                     CLEARXVADR2
083900000728BL   C                     CLEARXVADR3
084000000728BL   C                     CLEARXVPCDE
084100000728BL   C                     CLEARXVDIN1
084200000728BL   C                     CLEARXVDIN2
084300000728BL   C                     CLEARXVDIN3
084400990120     C                     ENDSR
084500990122      *
084600990122      *----------------------------------------------------------------
084700990122      * SHPONL - Validate ship only requirements.
084800990122      *----------------------------------------------------------------
084900990122     C           SHPONL    BEGSR
085000990125      *
085100990125      * Check if a ship only record exists for this customer
085200000728     C           XJCUST    CHAINHSLSHPOA             99
085300990125     C           *IN99     IFEQ *OFF
085400990125     C                     MOVEL'Y'       SHONLY  1
085500990218BL   C                     ELSE
085600990218BL   C                     MOVEL' '       SHONLY
085700990125     C                     ENDIF
085800990122     C                     ENDSR
085900990122      *
086000990122      *----------------------------------------------------------------
086100990122      * AGXREF - Check for agency cross-references.
086200990122      *----------------------------------------------------------------
086300990122     C           AGXREF    BEGSR
086400990223     C           KEYXRF    CHAINHSLVXRFB             99
086500990126     C           *IN99     IFEQ *OFF
086600990128     C                     MOVELHPROD     KPROD
086700000728     C                     MOVELHPROD     XKPROD
086800990126     C                     ENDIF
086900990122     C                     ENDSR
087000990122      *
087100990122      *----------------------------------------------------------------
087200990122      * VALIDD - Validate order detail screen fields.
087300990122      *----------------------------------------------------------------
087400990122     C           VALIDD    BEGSR
087500990126      *
087600990126      * Order Detail validation:
087700990126      *
087800990126      * Reset work values.
087900000728     C*                    Z-ADD0         RRN£
088000990223OWEM C                     Z-ADD0         RRNS    50
088100990223OWE  C                     Z-ADD1         RRNT    50
088200000728     C                     RESETXERROR
088300990126     C                     MOVE *OFF      *IN61            Hide F10/F11
088400990126      *
088500990126      * Reset error indicators.
088600000728     C                     MOVEAXZEROS    *IN,30
088700990126      *
088800990126      * Read all Records from subfile and validate contents.
088900990127     C           *IN99     DOUEQ*ON                        ..Do1
089000990223OWE   *
089100990223OWE   * Process the subfile in one of two modes depending on whether
089200990223OWE   * a previous change to the subfile has been made....
089300990223OWE   *
089400990223OWE  C           *IN82     IFEQ *OFF
089500990223OWE  C                     READCHSS200C                  99
089600000728OWE  C                     Z-ADDRRNX      RRNT
089700990223OWE  C                     ADD  1         RRNT
089800990223OWE  C                     ELSE
089900990223OWE  C           RRNT      IFEQ 101
090000990223OWE  C                     LEAVE
090100990223OWE  C                     ENDIF
090200990223OWE  C           RRNT      CHAINHSS200C              99
090300990223OWE  C                     ADD  1         RRNT
090400990223OWE  C                     ENDIF
090500990223      *
090600990223     C*                    READCHSS200C                  99
090700990126      * Retrieve subfile record.
090800990126     C           *IN99     IFEQ *OFF                       ...If2
090900000728OWE  C                     MOVE XKPROD    TPROD1 13
091000000728OWE  C                     MOVE XKQTYN    TQTYN1 150
091100990223OWE  C                     MOVE *ON       *IN82
091200990126      *
091300990126      * Reset subfile error indicators.
091400990126     C                     MOVEA'00000000'*IN,36
091500990126      *
091600000728     C           XSELC     IFNE *BLANK                     ....If3
091700000728     C           XKPROD    ORNE *BLANK                     ....If3
091800000728     C           XNDESC    ORNE *BLANK                     ....If3
091900000728     C           XKPRIC    ORNE *ZEROS                     ....If3
092000000728     C           XKQTYN    ORNE *ZEROS                     ....If3
092100000728     C           XKVALU    ORNE *ZEROS                     ....If3
092200000728     C           XKVATA    ORNE *ZEROS                     ....If3
092300000728     C           XKSERC    ORNE *BLANKS                    ....If3
092400000728     C           XKSERF    ORNE *ZEROS                     ....If3
092500000728     C           XKSERT    ORNE *ZEROS                     ....If3
092600990128      *
092700990128      * Count active subfile records.
092800000728OWE  C*                    ADD  1         RRN£
092900990223OWE  C                     ADD  1         RRNS
093000990126      *
093100990126      * Validate Selection code.
093200000728     C           XSELC     IFNE 'S'
093300000728     C           XSELC     ANDNE'N'
093400000728     C           XSELC     ANDNE'T'
093500990127      *
093600990127      * Validate Selection code / Product code / Text combination
093700000728     C           XSELC     OREQ *BLANK
093800000728     C           XKPROD    ANDNE*BLANKS
093900000728     C           XSELC     OREQ *BLANK
094000000728     C           XNDESC    ANDNE*BLANKS
094100000728     C           XSELC     OREQ *BLANK
094200000728     C           XKPRIC    ANDNE0
094300000728     C           XSELC     OREQ *BLANK
094400000728     C           XKQTYN    ANDNE0
094500000728     C           XSELC     OREQ 'T'
094600000728     C           XKPROD    ANDNE*BLANKS
094700000728     C           XSELC     OREQ 'T'
094800000728     C           XKPRIC    ANDNE0
094900000728     C           XSELC     OREQ 'T'
095000000728     C           XKQTYN    ANDNE0
095100000728     C           XSELC     OREQ 'T'
095200000728     C           XKSERC    ANDNE*BLANKS
095300000728     C           XSELC     OREQ 'T'
095400000728     C           XKSERF    ANDNE0
095500000728     C           XSELC     OREQ 'T'
095600000728     C           XKSERT    ANDNE0
095700000728     C           XSELC     OREQ 'S'
095800000728     C           XKQTYN    ANDEQ0
095900000728     C*          £SELC     OREQ 'S'
096000000728     C*          £KPRIC    ANDEQ0
096100000728     C           XSELC     OREQ 'N'
096200000728     C           XKQTYN    ANDEQ0
096300000728     C           XSELC     OREQ 'N'
096400000728     C           XKPRIC    ANDEQ0
096500990126     C                     MOVE *ON       *IN36
096600000728     C                     MOVE XYES      XERROR
096700990126     C                     MOVEL'HSV2006' P0MSID
096800000728     C                     EXSR YSNDMG
096900990126     C                     ENDIF
097000990218      *
097100990218      * Validate Selection code for Invoice Charge Only order type.
097200000728     C           XSELC     IFEQ 'S'
097300990218     C           MINVC     ANDEQ'Y'
097400990218     C                     MOVE *ON       *IN36
097500000728     C                     MOVE XYES      XERROR
097600990218     C                     MOVEL'HSV2014' P0MSID
097700000728     C                     EXSR YSNDMG
097800990218     C                     ENDIF
097900990225      *
098000000728XXX  C           YMODE     IFEQ 'D'
098100000728XXX  C           XKQTYN    ANDGTXXQTYN
098200000728XXX  C                     MOVE XYES      XERROR
098300990225XXX  C                     MOVEL'HSV2020' P0MSID
098400000728XXX  C                     EXSR YSNDMG
098500990225XXX  C                     LEAVE
098600990225XXX  C                     ELSE
098700000728XXX  C                     EXSR YCLRMG
098800990225XXX  C                     ENDIF
098900990126      *
099000990126      * Validate Product.
099100000728     C           XSELC     IFEQ 'S'
099200000728     C           XKPROD    IFNE *BLANKS
099300000728     C           XKPROD    CHAINHSLPRODA             99
099400990126     C           *IN99     IFEQ *ON
099500990126     C                     MOVE *ON       *IN37
099600000728     C                     MOVE XYES      XERROR
099700990126     C                     MOVEL'HSV2007' P0MSID
099800000728     C                     EXSR YSNDMG
099900990127     C                     ELSE
100000000728     C                     MOVELNDESC     XNDESC
100100000728     C                     Z-ADDNPRIC     XKPRIC
100200990201     C                     ENDIF
100300990201     C                     ENDIF
100400990201     C                     ENDIF
100500990127      *
100600990127      * Reverse price for Credit
100700990127     C           MSALE     IFEQ 'C'
100800000728     C                     Z-SUBXKPRIC    XKPRIC
100900990127     C                     ENDIF
101000990127      *
101100990127      * Extended value
101200000728     C           XSELC     IFEQ 'S'
101300000728     C           XSELC     OREQ 'N'
101400000728     C           XKPRIC    MULT XKQTYN    XKVALU
101500990218BL    *
101600000728BL   C*          £KVALU    MULT MVATP     £KVATA
101700990126     C                     ENDIF
101800990223      *
101900990223OWE   * Save Price, Value and Description field contents....
102000000728OWE  C                     MOVE XKPRIC    TKPRIC  92P
102100000728OWE  C                     MOVE XKVALU    TKVALU  92P
102200000728OWE  C                     MOVE XNDESC    TNDESC 19 P
102300990223      *
102400990211      * Check quantity against allocated serial numbers.
102500000728OOO  C*          £KQTYN    IFNE 0
102600000728OOO  C*          £KSERF    ANDNE0
102700000728OOO  C*          £KSERT    ANDNE0
102800000728OOO  C*          £KSERT    SUB  £KSERF    WKQTYN
102900990223OOO  C*                    ADD  1         WKQTYN
103000000728OOO  C*          £KQTYN    IFNE WKQTYN
103100990223OOO  C*                    MOVEA'1011'    *IN,40
103200000728OOO  C*                    MOVE £YES      £ERROR
103300990223OOO  C*                    MOVEL'HSV2013' P0MSID
103400000728OOO  C*                    EXSR ‡SNDMG
103500990223OOO  C*                    ENDIF
103600990223OOO  C*                    ENDIF
103700990127      *
103800990128      * Check voucher control if not yet allocated
103900000728     C           XSELC     IFEQ 'S'
104000000728     C           XKQTYN    ANDGT0
104100000728OOO  C*          £KSERC    IFEQ *BLANKS
104200000728OOO  C*          £KSERF    ANDEQ0
104300000728OOO  C*          £KSERT    ANDEQ0
104400990128     C                     MOVEL'U'       WKVCTL
104500990127     C                     EXSR UPVCTL
104600990128     C                     ENDIF
104700990223OOO  C*                    ENDIF
104800990126      *
104900990126      * Update subfile record with DSPATR settings and set SFLRCDNBR.
105000000728     C                     Z-ADDRRNX      RCDNBR
105100000728OWE  C                     MOVE TKPRIC    XKPRIC
105200000728OWE  C                     MOVE TKVALU    XKVALU
105300000728OWE  C                     MOVE TNDESC    XNDESC
105400990127     C                     UPDATHSS200C                    SFL
105500990126     C                     MOVEA'00000000'*IN,36
105600990126      *
105700990126      * If errors encountered in subfile then exit subfile validation.
105800000728     C           XERROR    IFEQ XYES
105900000728OWE  C                     MOVELXSELC     TSELC   1 P
106000000728OWE  C                     MOVELXKPROD    TPROD  13 P
106100000728OWE  C                     MOVELXKPRIC    TPRIC   92P
106200000728OWE  C                     MOVELXKQTYN    TQTYN   90P
106300000728OWE  C                     MOVELXNDESC    TDESC  19 P
106400000728OOO  C*                    Z-ADDRRN£      RRNS    50
106500990126     C                     LEAVE
106600990126     C                     ENDIF
106700990126      *
106800990126      * End of non-blank subfile check.
106900990126     C                     ENDIF                           ....EndIf3
107000990126      *
107100990126      * End of Subfile CHAIN check.
107200990126     C                     ENDIF                           ...EndIf2
107300990126      *
107400990128      * End of loop for next subfile record.
107500990126     C                     ENDDO                           ..EndDo1
107600990128      *
107700990217      * Save last RRN number used.
107800000728BL   C*                    Z-ADDRRN£      SAVRRN
107900990126      *
108000990126      * If no errors found...
108100000728     C           XERROR    IFEQ XNO
108200990126      * ...display "Data valid.Press F10 to update" message...
108300990126     C                     MOVEL'HSV9006' P0MSID
108400000728     C                     EXSR YSNDMG
108500990126      * ...activate F10 key (*IN61=*ON).
108600990126     C                     MOVE *ON       *IN61
108700990126     C                     ENDIF
108800000728XXX  C           XJUMP1    IFEQ XYES
108900990303XXX  C           *IN52     ANDEQ*ON
109000990303     C                     CALL 'HSR342'
109100990303     C                     ENDIF
109200990303XXX  C                     MOVE *OFF      *IN52
109300990122     C                     ENDSR
109400990122      *
109500990122      *----------------------------------------------------------------
109600990122      * DISCNT - Discount retrieval.
109700990122      *----------------------------------------------------------------
109800990216      *
109900990122     C           DISCNT    BEGSR
110000990216      *
110100990216      * If customer discount is not entered on header screen either
110200990216      * caluclate from HSPDISC file keyed on Order Value or default
110300990216      * according to Customer Type.
110400990216      *
110500000728     C           XJDISP    IFEQ 0
110600990216      *
110700990216      * Setup key list for HSPDISC
110800990216      *
110900000728     C                     Z-ADDXKTVAL    PFAMT
111000990216      *
111100990216      * SETLL on HSLDISCA
111200990216      *
111300990216     C           DSCKEY    SETLLHSLDISCA                 99
111400990216      *
111500990216      * If record not found READP
111600990216      *
111700990216     C           *IN99     IFEQ *OFF
111800990215     C                     READPHSLDISCA                 99
111900990216      *
112000990216      * If not BOF
112100990216      *
112200990216     C           *IN99     IFEQ *OFF
112300990223BL   C           PCTYP     ANDEQECTYP
112400990215     C                     Z-ADDPDISC     KDISP
112500990216      *
112600990216      * Else calculate discount according to Customer Type
112700990216      *
112800990215     C                     ELSE
112900990216      *
113000990215     C                     SELEC
113100990216      *
113200990216      * If Customer Type is '001' - Z-ADD 10 to discount
113300990216      *
113400990215     C           ECTYP     WHEQ '001'
113500990215     C                     Z-ADD10        KDISP
113600990216      *
113700990216      * If Customer Type is '002' - Z-ADD 20 to discount
113800990216      *
113900990215     C           ECTYP     WHEQ '002'
114000990215     C                     Z-ADD20        KDISP
114100990216      *
114200990215     C                     ENDSL
114300990216      *
114400990215     C                     ENDIF
114500990216      *
114600990216      * Record found on SETLL
114700990216      *
114800990216     C                     ELSE
114900990216      *
115000990216     C                     Z-ADDPDISC     KDISP
115100990216      *
115200990216     C                     ENDIF
115300990216      *
115400000728      * £JDISP not equal to 0
115500990216      *
115600990215     C                     ELSE
115700000728     C                     Z-ADDXJDISP    KDISP
115800990216      *
115900990215     C                     ENDIF
116000990216      *
116100990122     C                     ENDSR
116200990122      *
116300990122      *----------------------------------------------------------------
116400990122      * Check for minimum order value.
116500990122      *----------------------------------------------------------------
116600990122     C           MINVAL    BEGSR
116700990128     C                     Z-ADD0         WKTOTV
116800990225     C                     Z-ADD1         RRNP
116900990127      *
117000990127      * Accumulate order total value
117100990127     C           *IN99     DOUEQ*ON
117200990225BL   C           RRNP      OREQ 100
117300000728BL   C           XSELC     OREQ *BLANK
117400990225     C           RRNP      CHAINHSS200C              99
117500990127     C           *IN99     IFEQ *OFF
117600000728     C                     ADD  XKVALU    WKTOTV
117700990127     C                     ENDIF
117800990225     C                     ADD  1         RRNP
117900990127     C                     ENDDO
118000990127      *
118100990127      * Compare order total value and minimum order value
118200990128     C           WKTOTV    IFLT MORDV
118300000728     C                     MOVE XYES      XERROR
118400990201     C                     MOVEL'HSV2011' P0MSID
118500000728     C                     EXSR YSNDMG
118600990201     C                     ENDIF
118700990225     C                     Z-ADD1         RRNP
118800000728     C                     Z-ADD1         RRNX
118900990122     C                     ENDSR
119000990122      *
119100990122      *----------------------------------------------------------------
119200990122      * Ship to all delivery points.
119300990122      *----------------------------------------------------------------
119400990122     C           SHPALL    BEGSR
119500990216     C*
119600990216     C* SETLL on HSLCUSTA with Customer Number
119700990216     C*
119800000728     C           XJCUST    SETLLHSLCUSTA
119900990216     C*
120000990216     C* READE on HSLCUSTA with Customer Number
120100990216     C*
120200000728     C           XJCUST    READEHSLCUSTA                 99
120300990216     C*
120400990216     C* If not EOF
120500990216     C*
120600990216     C           *IN99     DOWEQ*OFF
120700990216     C*
120800990216     C* If ECGRP not equal to blanks
120900990216     C*
121000990216     C           ECGRP     IFNE *BLANKS
121100990216     C*
121200990216     C* CHAIN to Customer File for Delivery Name and Address
121300990216     C*
121400990318     C*          ECGRP     CHAINALTCUSTF             13
121500990216     C*
121600990318     C*          *IN13     IFEQ *OFF
121700990216     C*
121800990216     C* Write Order Header Record
121900990216     C*
122000990216     C                     EXSR UPORDH
122100990216     C*
122200990216     C* Set up Delivery Name and Address
122300990216     C*
122400000728     C                     MOVELENAM1     XVNAM1
122500000728     C                     MOVELEADR1     XVADR1
122600000728     C                     MOVELEADR2     XVADR2
122700000728     C                     MOVELEADR3     XVADR3
122800000728     C                     MOVELEPCDE     XVPCDE
122900990216     C*
123000990216     C* Write Order Delivery Record
123100990216     C*
123200990216     C                     EXSR UPODEL
123300990216     C*
123400990216     C* Write Order Detail Record
123500990216     C*
123600990216     C                     EXSR UPORDD
123700990216     C*
123800990216     C* ECGRP equal to blanks
123900990216     C*
124000990318     C*                    ENDIF
124100990216     C*
124200990216     C* Customer Record not found
124300990216     C*
124400990216     C                     ENDIF
124500990216     C*
124600990216     C* Increment order number
124700990216     C*
124800000728     C           *LOCK     IN   ORDERX
124900000728     C                     ADD  1         ORDERX
125000000728     C                     OUT  ORDERX
125100000728     C                     Z-ADDORDERX    XJSORD
125200990216     C*
125300990216     C* READE on HSLCUSTA with Customer Number
125400990216     C*
125500000728     C           XJCUST    READEHSLCUSTA                 99
125600990216     C*
125700990216     C                     ENDDO
125800990216     C*
125900990216     C* EOF on HSLCUSTA
126000990216     C*
126100990122     C                     ENDSR
126200990122      *
126300990122      *----------------------------------------------------------------
126400990122      * Update voucher control.
126500990122      *----------------------------------------------------------------
126600990302     C           UPVCTL    BEGSR
126700990128      *
126800990302     C                     MOVE *ON       *IN85
126900990302      * Save order line values
127000990302      *
127100990301     C                     Z-ADD0         XQUAN   90
127200000728     C                     MOVE XNO       XJUMP   1
127300990128      * Clear flag for successful range allocation.
127400990128     C                     MOVEL*BLANK    WKRANG
127500990301      *
127600990301      * Clear flag for first tracking record found.
127700000728     C                     MOVELXNO       XFIRST  1
127800990127      *
127900990127      * Get Serial number range.
128000990128     C                     MOVEL*BLANKS   WKSERC
128100990128     C           *IN92     DOUEQ*ON
128200990128     C           WKRANG    OREQ 'Y'
128300990223      *
128400990223OWE   * Work back through the subfile checking for duplicate
128500990223OWE   * product codes.... If found validate data under DOUB subroutine.
128600990223      *
128700000728OWE  C                     MOVE RRNX      RRNXX   50
128800000728OWE  C           RRNX      DOUEQ0
128900000728OWE  C                     SUB  1         RRNX
129000000728OWE  C           RRNX      IFEQ 0
129100990223OWE  C                     LEAVE
129200990223OWE  C                     ENDIF
129300000728OWE  C           RRNX      CHAINHSS200C              90
129400000728OWE  C           XKPROD    IFEQ TPROD1
129500000728OWE  C                     MOVE RRNXX     RRNX
129600990223OWE  C                     EXSR DOUB
129700990223OWE  C                     MOVE *ON       *IN81
129800990223OWE  C                     LEAVE
129900990223OWE  C                     ENDIF
130000990223OWE  C                     ENDDO
130100990223      *
130200990223OWE   * Reset subfile position.....
130300000728OWE  C                     MOVE RRNXX     RRNX
130400000728OWE  C           RRNX      CHAINHSS200C              90
130500990223      *
130600990223      * Exit from subroutine if DOUB sr has been processed....
130700990223      *
130800990223OWE  C           *IN81     IFEQ *ON
130900000728OWE  C                     MOVE XKSERF    XKSERF
131000000728OWE  C                     MOVE XKSERC    XKSERC
131100000728OWE  C                     MOVE XKSERT    XKSERT
131200990223OWE  C                     MOVE *OFF      *IN81
131300990223OWE  C                     LEAVE
131400990223OWE  C                     ENDIF
131500990223      *
131600990128     C           VCHKEY    SETLLHSLVCTLA
131700000728     C           XKPROD    READEHSLVCTLA                 92
131800990301      *
131900990301      * Move pointer file values into temporary fields....
132000990301      *
132100990301     C                     MOVE BPROD     OPROD  13
132200990302     C                     MOVE BSERCC    OSERC   3
132300990302     C                     MOVE BSERNN    OSERN   90
132400990302     C                     Z-ADDBSERNN    WKSERN
132500990302     C                     MOVE BSERCC    WKSERC
132600000728     C                     Z-ADDBSERNN    XXSERF  90
132700000728     C********             SUB  1         ££SERF
132800990301      *
132900990301      *
133000990127     C           *IN92     IFEQ *OFF
133100990128      *
133200990301      * Scan voucher tracking file for first available voucher....
133300990301      *
133400000728     C                     MOVE BSERCC    XKSERC
133500000728     C                     MOVE OSERN     XKSERF
133600990301      *
133700990301     C           *IN94     DOUEQ*ON
133800000728     C           XQUAN     OREQ XKQTYN
133900990301      *
134000990303     C           *IN85     IFEQ *ON
134100990302     C           TRCKEY    SETLLHSLTRACB
134200990303     C                     MOVE *OFF      *IN85
134300990303     C                     ENDIF
134400990302      *
134500000728     C           XKPROD    READEHSLTRACB                 94
134600990301      *
134700990301     C           *IN94     IFEQ *ON
134800990301     C                     LEAVE
134900990301     C                     ENDIF
135000990301      *
135100990301     C           ASERC     IFNE WKSERC
135200990301     C           ASERN     ORNE WKSERN
135300990302     C           AALLD     ORNE *ZEROS
135400990303     C                     ADD  1         DSERN
135500990303      *
135600990303     C           *IN87     IFEQ *OFF
135700990303     C           XXSERN    ADD  1         XXRES   90
135800990303PPP  C*          XXRES     IFNE ASERN
135900000728PPP  C*                    MOVE ASERN     ££SERF
136000990303PPP  C*                    ELSE
136100000728     C                     MOVE ASERN     XXSERF
136200000728     C                     ADD  1         XXSERF
136300990303     C                     ADD  1         WKSERN
136400990303RRR  C                     MOVE *ON       *IN85
136500000728RRR  C                     ADD  1         XKSERF
136600990303PPP  C*                    ENDIF
136700990303     C                     ELSE
136800990303      *
136900990303      * No previous error so add to HSPEXPA.....
137000990303     C                     MOVE WKSERC    XXSERC  3 P
137100990303     C                     MOVE WKSERN    XXSERN  90P
137200990302     C                     SUB  1         WKSERN
137300000728     C                     MOVE XYES      XJUMP
137400000728XXX  C                     MOVE XYES      XJUMP1  1
137500990303      *
137600990303     C****       *IN87     IFEQ *ON
137700000728     C                     MOVE XXSERF    USERNS
137800990301     C                     MOVE WKSERN    USERNE
137900990301     C                     MOVE WKSERC    USERCC
138000000728     C                     MOVE XKPROD    UPROD
138100990302     C                     OPEN HSLEXPAA
138200990302     C                     WRITEHSFEXPA
138300990302     C                     CLOSEHSLEXPAA
138400990303     C*****                ENDIF
138500990303      *
138600000728     C                     MOVE ASERN     XXSERF
138700990303     C                     ADD  1         DSERN
138800990303     C           DSERN     IFNE ASERN
138900990303     C           ASERN     SUB  DSERN     DIF     90
139000000728     C                     ADD  DIF       XXSERF
139100990303     C                     ENDIF
139200990303      *
139300000728     C                     ADD  1         XKSERF
139400990302     C                     ADD  2         WKSERN
139500990302     C                     MOVE *ON       *IN85
139600990302     C                     MOVE *OFF      *IN87
139700990302      *
139800990303XXX  C           ASERC     IFNE WKSERC
139900990303XXX  C                     MOVE ASERC     WKSERC
140000990303XXX  C                     MOVE ASERN     WKSERN
140100000728XXX  C                     MOVE WKSERC    XKSERC
140200000728XXX  C                     MOVE WKSERN    XKSERF
140300000728XXX  C                     MOVE WKSERN    XXSERF
140400990303XXX  C                     MOVE *ON       *IN85
140500990303XXX  C                     ENDIF
140600990303      *
140700990301     C                     ITER
140800990301     C                     ENDIF
140900990303      *
141000990303     C           ASERC     IFNE WKSERC
141100990303     C                     MOVE ASERC     WKSERC
141200990303     C                     MOVE ASERN     WKSERN
141300000728     C                     MOVE WKSERC    XKSERC
141400000728XXX  C                     MOVE WKSERN    XKSERF
141500000728XXX  C                     MOVE WKSERN    XXSERF
141600990303     C                     MOVE *ON       *IN85
141700990303     C                     ENDIF
141800990303      *
141900990303     C                     ENDIF
142000990301      *
142100990303      *
142200990302     C           AALLD     IFEQ *ZEROS
142300990302     C***        *IN87     IFEQ *OFF
142400000728     C***                  ADD  1         ££SERF
142500990302     C***                  ENDIF
142600990302     C                     MOVE *ON       *IN87
142700990301     C                     ADD  1         XQUAN
142800000728     C                     MOVE XYES      XFIRST
142900990302     C                     MOVE ASERC     WKSERC
143000990303     C                     MOVE ASERN     DSERN   90P
143100990301     C                     ADD  1         WKSERN
143200000728     C                     ADD  1         XKSERF
143300990303     C                     MOVE *ON       *IN85
143400990301     C                     ITER
143500990301     C                     ELSE
143600990303     C                     ITER
143700990301     C                     ENDIF
143800990301      *
143900990301     C                     ENDDO
144000990301      *
144100000728     C           XFIRST    IFEQ XNO
144200000728     C                     MOVE XYES      XERROR
144300990301     C                     MOVEL'HSV2024' P0MSID
144400000728     C                     EXSR YSNDMG
144500000728     C                     CLEARXKSERC
144600000728     C                     CLEARXKSERT
144700000728     C                     CLEARXKSERF
144800990301     C                     LEAVE
144900990301     C                     ENDIF
145000990128      *
145100000728     C           XQUAN     IFNE XKQTYN
145200000728     C                     MOVE XYES      XERROR
145300990301     C                     MOVEL'HSV2025' P0MSID
145400000728     C                     EXSR YSNDMG
145500000728     C                     CLEARXKSERC
145600000728     C                     CLEARXKSERT
145700000728     C                     CLEARXKSERF
145800990303     C*****                MOVE *ON       *IN52
145900990301     C                     LEAVE
146000990301     C                     ENDIF
146100990301      *
146200990303     C                     MOVE *ON       *IN52
146300990303      *
146400000728     C           XJUMP     IFEQ XYES
146500000728     C***                  MOVE £YES      £ERROR
146600990301     C                     MOVEL'HSV2026' P0MSID
146700000728     C                     EXSR YSNDMG
146800990302      *
146900990302     C                     SUB  1         WKSERN
147000990303XXX  C                     MOVEL'Y'       WKRANG
147100990302      *
147200000728     C*****                MOVE XXSERC    £KSERC
147300000728     C*****                MOVE XXSERN    £KSERF
147400990303     C*****      TRCKEY    CHAINHSLTRACB             99
147500990303     C*****      *IN99     IFEQ *OFF
147600000728     C*****                ADD  1         ££SERF
147700990303     C*****                ENDIF
147800990302      *
147900000728     C                     MOVE XXSERF    USERNS
148000990302     C                     MOVE WKSERN    USERNE
148100990302     C                     MOVE WKSERC    USERCC
148200990302     C                     OPEN HSLEXPAA
148300990302     C                     WRITEHSFEXPA
148400990302     C                     CLOSEHSLEXPAA
148500990302      *
148600000728     C                     CLEARXKSERC
148700000728     C                     CLEARXKSERT
148800000728     C                     CLEARXKSERF
148900000728     C                     EXSR YJUMP
149000990302     C                     MOVE *ON       *IN86
149100990302     C                     MOVE *ON       *IN61
149200990301     C                     LEAVE
149300990301     C                     ENDIF
149400990301      *
149500990128      * Series code found.
149600000728     C                     MOVE BSERCC    XKSERC
149700990127      *
149800000728     C                     Z-ADDOSERN     XKSERF
149900990302     C                     SUB  1         WKSERN
150000000728     C                     Z-ADDWKSERN    XKSERT
150100990128      *
150200990128      * Flag successful range allocation.
150300990128     C                     MOVEL'Y'       WKRANG
150400990128      *
150500990128      * Update if required.
150600990127     C                     ENDIF
150700990128     C                     ENDDO
150800990127      *
150900990128      * Unsuccessful range allocation.
151000990128     C           WKRANG    IFNE 'Y'
151100990128     C                     MOVEA'111'     *IN,41
151200000728XXX  C****                 MOVE £YES      £ERROR
151300990128     C                     MOVEL'HSV2012' P0MSID
151400000728     C                     EXSR YSNDMG
151500990128     C                     ENDIF
151600990128      *
151700990122     C                     ENDSR
151800990302      *
151900990302      *----------------------------------------------------------------
152000990302      * Display contents of HSLEXPAA
152100990302      *----------------------------------------------------------------
152200990302      *
152300000728     C           YJUMP     BEGSR
152400990302     C                     ENDSR
152500990122      *
152600990302      *
152700990302      *----------------------------------------------------------------
152800990302      * Delete contents of HSLEXPAA
152900990302      *----------------------------------------------------------------
153000990302      *
153100000728     C           YDELT     BEGSR
153200990302     C                     CALL 'HSC200A'
153300990302     C                     ENDSR
153400990302      *
153500990223      *----------------------------------------------------------------
153600990223      * Repeat of Product Code in a single order
153700990223      *----------------------------------------------------------------
153800990223      *
153900990223OWE  C           DOUB      BEGSR
154000990223      *
154100990223      * Get Serial number range.
154200990223OWE  C                     MOVEL*BLANKS   WKSERC
154300990223OWE  C           *IN92     DOUEQ*ON
154400990223OWE  C           WKRANG    OREQ 'Y'
154500990223      *
154600990223OWE  C           VCHKEY    SETLLHSLVCTLA
154700000728OWE  C           XKPROD    READEHSLVCTLA                 92
154800990223OWE  C           *IN92     IFEQ *OFF
154900990223      *
155000990223      * Get available series code.
155100000728OWEM C           BSERNN    ADD  TQTYN1    XXSERN  90
155200990302OWE  C*          ££SERN    IFGT BSERNE
155300990302OWE  C*                    MOVELBSERCN    WKSERC
155400990223OWE  C                     ITER
155500990223OWE  C                     ELSE
155600990223      *
155700990223      * Work back through the subfile searching for duplicate
155800990223      * product code/series code combination records......
155900990223      *
156000000728OWE  C                     MOVE RRNX      RRNXX   50P
156100000728OWE  C           RRNX      DOUEQ0
156200000728OWE  C                     SUB  1         RRNX
156300000728OWE  C           RRNX      IFEQ 0
156400990223OWE  C                     MOVE *ON       *IN83
156500990223OWE  C                     LEAVE
156600990223OWE  C                     ENDIF
156700000728OWE  C           RRNX      CHAINHSS200C              90
156800000728OWE  C           XKSERC    IFEQ BSERCC
156900000728OWE  C           XKSERT    ADD  TQTYN1    RES     90
157000990302OWE  C*          RES       IFLE BSERNE
157100000728OWE  C                     MOVE XKSERC    KKSERC  3 P
157200000728OWE  C                     MOVE XKSERT    KKSERT  90P
157300990223OWE  C                     LEAVE
157400990223OWE  C                     ELSE
157500990223OWE  C                     MOVE *ON       *IN84
157600990223OWE  C                     LEAVE
157700990302OWE  C                     ENDIF
157800990302OWE  C*                    ENDIF
157900990223OWE  C                     ENDDO
158000990223      *
158100990223      * Reset the subfile pointer position.....
158200000728OWE  C                     MOVE RRNXX     RRNX      P
158300000728OWE  C           RRNX      CHAINHSS200C              90
158400990223      *
158500990223OWE  C           *IN84     IFEQ *OFF
158600990223OWE  C           *IN83     ANDEQ*OFF
158700990223OWE   * Series code found.
158800000728OWE  C                     MOVE KKSERC    XKSERC  3 P
158900990223OWE   *
159000990223OWE   * Set To serial number for the order.
159100000728OWE  C                     MOVE RES       XKSERT  90P
159200990223OWE   *
159300990223OWE   * Set From Serial Number for the order.
159400000728OWE  C           KKSERT    ADD  1         XKSERF  90
159500990223OWE   *
159600990223OWE   * Set Next Serial Number for the voucher control.
159700990223OWE  C                     ADD  TQTYN1    BSERNN
159800990223OWE   *
159900990223OWE   * Flag successful range allocation.
160000990223OWE  C                     MOVEL'Y'       WKRANG
160100990223OWE  C                     ITER
160200990223OWE  C                     ENDIF
160300990223      *
160400990223OWE  C           *IN83     IFEQ *ON
160500990223OWE  C           *IN84     ANDEQ*OFF
160600990223OWE  C                     MOVE *OFF      *IN83
160700990223      *
160800990223OWE   * Series code found.
160900000728OWE  C                     MOVE BSERCC    XKSERC  3
161000990223OWE   *
161100990223OWE   * Set To serial number for the order.
161200000728OWE  C           BSERNN    ADD  TQTYN1    XKSERT  90
161300000728OWE  C                     SUB  1         XKSERT
161400990223OWE   *
161500990223OWE   * Set From Serial Number for the order.
161600000728OWE  C                     Z-ADDBSERNN    XKSERF
161700990223OWE   *
161800990223OWE   * Set Next Serial Number for the voucher control.
161900990223OWE  C                     ADD  TQTYN1    BSERNN
162000990223OWE   *
162100990223OWE   * Flag successful range allocation.
162200990223OWE  C                     MOVEL'Y'       WKRANG
162300990223OWE  C                     ITER
162400990223OWE  C                     ENDIF
162500990223OWE  C                     MOVE *OFF      *IN84
162600990302OWE  C*                    MOVELBSERCN    WKSERC
162700990223      *
162800990302OWE  C*                    ENDIF
162900990223OWE  C                     ENDIF
163000990223OWE  C                     ENDDO
163100990223OWE  C                     ENDSR
163200990122      *----------------------------------------------------------------
163300990122      * Update voucher tracking.
163400990122      *----------------------------------------------------------------
163500990122     C           UPTRAC    BEGSR
163600990128      *
163700990128      * Reverse order date before update.
163800000728BL   C           YMODE     IFEQ 'E'
163900990215     C                     Z-ADDJDD       WKD
164000990215     C                     Z-ADDJMM       WKM
164100990215     C                     Z-ADDJCC       WKC
164200990215     C                     Z-ADDJYY       WKY
164300990215     C                     Z-ADDWKORDD    ADFIS
164400990217BL   C                     ENDIF
164500990128      *
164600990128      * Locate voucher record.
164700990128     C           TRCKEY    SETLLHSLTRACB
164800000728     C           XKPROD    DOUNEAPROD
164900990128     C           *IN99     OREQ *ON
165000990128     C                     READ HSLTRACB                 99
165100990128     C           *IN99     IFEQ *OFF
165200990128      *
165300990128      * Exit if product code or series code does not match.
165400000728     C           XKPROD    IFNE APROD
165500000728     C           XKSERC    ORNE ASERC
165600990128     C                     LEAVE
165700990128     C                     ENDIF
165800990128      *
165900990128      * Update vouchers in the serial number range.
166000000728     C           XKSERF    IFLE ASERN
166100000728     C           XKSERT    ANDGEASERN
166200000728BL   C           YMODE     IFEQ 'D'
166300000728BL   C                     MOVELXJCUST    ACUST
166400990217BL   C                     Z-ADD0         ADSPB
166500990217BL   C                     ELSE
166600990217      *
166700000728     C                     Z-ADDXJSORD    ASORD
166800990215     C                     Z-ADDWKORDD    ADFIS
166900990128     C                     UPDATHSFTRAC
167000990217BL   C                     ENDIF
167100990128     C                     ENDIF
167200990128     C                     ENDIF
167300990128     C                     ENDDO
167400990122     C                     ENDSR
167500990122      *
167600990122      *----------------------------------------------------------------
167700990122      * Update inventory allocations.
167800990122      *----------------------------------------------------------------
167900990122     C           UPINVA    BEGSR
168000990128      *
168100990128      * Update stock quantities.
168200990205     C           IVMKEY    CHAINHSLINVMA             99
168300990128     C           *IN99     IFEQ *OFF
168400990128      *
168500990128      * Increase allocated quantity and reduce available quantity.
168600000728     C                     ADD  XKQTYN    DQTYR
168700000728     C                     SUB  XKQTYN    DQTYF
168800990128     C                     UPDATHSFINVM
168900990128     C                     ENDIF
169000990122     C                     ENDSR
169100990219      *
169200990219      *----------------------------------------------------------------
169300990219      * Update inventory sales.
169400990219      *----------------------------------------------------------------
169500990219BL   C           UPINVS    BEGSR
169600990219BL    *
169700990219BL    * Update stock quantities.
169800990219BL   C           IVMKEY    CHAINHSLINVMA             99
169900990219BL   C           *IN99     IFEQ *OFF
170000990219BL    *
170100990219BL    * Reduce allocated quantity and reduce on-hand quantity.
170200000728BL   C                     SUB  XKQTYN    DQTYR
170300000728BL   C                     SUB  XKQTYN    DQTYO
170400990219BL   C                     UPDATHSFINVM
170500990219BL   C                     ENDIF
170600990219BL   C                     ENDSR
170700990219      *
170800990122      *----------------------------------------------------------------
170900990122      * Print delivery note.
171000990122      *----------------------------------------------------------------
171100990122     C           PRTDEL    BEGSR
171200000728BL   C                     MOVELXJSORD    ORDPRM
171300990217BL   C                     CALL 'HSR230'
171400990217BL   C                     PARM           ORDPRM
171500990122     C                     ENDSR
171600990122      *
171700990122      *----------------------------------------------------------------
171800990122      * Print invoice.
171900990122      *----------------------------------------------------------------
172000990122     C           PRTINV    BEGSR
172100000728BL   C                     MOVELXJSORD    ORDPRM
172200990217BL   C                     CALL 'HSR220'
172300990217BL   C                     PARM           ORDPRM
172400990122     C                     ENDSR
172500990122      *
172600990122      *----------------------------------------------------------------
172700990122      * Create order details.
172800990122      *----------------------------------------------------------------
172900990122     C           UPORDD    BEGSR
173000990215      *
173100990215      * Order line already exists
173200990215     C                     MOVEL' '       UPDAT
173300000728     C           XOLIN     IFGT 0
173400990215     C           KEYOLN    CHAINHSLORDDB             98
173500000728     C                     Z-ADDXOLIN     KLINE
173600990215     C                     ENDIF
173700990128      *
173800990128      * Write fields for order detail record.
173900000728     C                     MOVELXSELC     KLTYP
174000000728     C                     MOVELXJCOMP    KCOMP
174100000728     C                     MOVELXJTYPE    KTYPE
174200000728     C                     Z-ADDXJSORD    KSORD
174300000728     C                     Z-ADDRRNX      KLINE
174400000728     C                     MOVELXJCUST    KCUST
174500000728     C                     MOVELXKPROD    KPROD
174600000728     C                     MOVELXKSERC    KSERC
174700000728     C                     Z-ADDXKSERF    KSERNF
174800990128     C                     Z-ADD0         KELEMF
174900000728     C                     Z-ADDXKSERT    KSERNT
175000990128     C                     Z-ADD0         KELEMT
175100000728     C                     Z-ADDXKQTYN    KQTYN
175200990128     C                     Z-ADDNCOST     KCOST
175300000728     C                     Z-ADDXKPRIC    KPRIC
175400000728     C                     Z-ADDXKVALU    KVALU
175500990208      *
175600990218BL    * Obtain VAT% from Order Type record.
175700000728BL   C*          £KVALU    MULT .175      KVATA
175800000728BL   C*          £KVALU    MULT MVATP     KVATA
175900990223BL   C*          KVATA     DIV  100       KVATA     H
176000990128     C                     Z-ADDCYMD      KCRTD
176100000728     C                     Z-ADDXXTME     KCRTT
176200000728     C                     MOVELXNDESC    KDESC
176300000728     C                     MOVELXJOBNO    KCRTS
176400000728     C                     MOVELXUSRID    KCRTU
176500000728     C                     MOVELXPGMID    KCRTP
176600990128     C                     MOVEL*BLANK    KDELT
176700990215      *
176800990215      * Update order detail record.
176900000728     C           XOLIN     IFGT 0
177000990211     C           *IN98     IFEQ *OFF
177100990211     C                     MOVEL'Y'       UPDAT
177200990211     C                     UPDATHSFORDD
177300990211     C                     ENDIF
177400990211     C                     ELSE
177500990215      *
177600990128      * Write order detail record.
177700990128     C                     WRITEHSFORDD
177800990211     C                     ENDIF
177900990122     C                     ENDSR
178000990122      *
178100990122      *----------------------------------------------------------------
178200990122      * Create order header.
178300990122      *----------------------------------------------------------------
178400990122     C           UPORDH    BEGSR
178500990215      *
178600990215      * Program mode - Maintenance, or Dispatch
178700000728     C           YMODE     IFEQ 'M'
178800000728     C           YMODE     OREQ 'D'
178900990215      *
179000990215      * Access order header record.
179100000728     C           XJSORD    CHAINHSLORDHA             99
179200990215     C                     ENDIF
179300990128      *
179400990128      * Write fields for order header record.
179500000728     C                     MOVELXJCOMP    JCOMP
179600000728     C                     MOVELXJCUST    JCUST
179700990128     C                     MOVEL*BLANKS   JCUSB
179800000728     C                     MOVELXJORDR    JORDR
179900000728     C                     MOVELXJTYPE    JTYPE
180000000728     C                     Z-ADDXJSORD    JSORD
180100990128     C                     Z-ADDWKORDD    JORDD
180200990128     C                     MOVEL*BLANKS   JINVN
180300990128     C                     Z-ADD0         JINVD
180400990128     C                     MOVEL*BLANKS   JDELN
180500990128     C                     Z-ADD0         JDELD
180600990128     C                     Z-ADDCYMD      JCRTD
180700000728     C                     Z-ADDXXTME     JCRTT
180800000728     C                     MOVELXJOBNO    JCRTS
180900000728     C                     MOVELXUSRID    JCRTU
181000000728     C                     MOVELXPGMID    JCRTP
181100990128     C                     MOVEL*BLANK    JDELT
181200990128      *
181300990215      * Program mode - Entry
181400000728     C           YMODE     IFEQ 'E'
181500990211      *
181600990128      * Write order header record.
181700990217BL   C                     MOVEL'A'       JSTAT
181800990217     C                     WRITEHSFORDH
181900990211     C                     ENDIF
182000990211      *
182100990215      * Program mode - Maintenance, or Dispatch
182200000728     C           YMODE     IFEQ 'M'
182300000728     C           YMODE     OREQ 'D'
182400000728BL   C           YMODE     IFEQ 'D'
182500990225BL   C                     Z-ADD*DATE     JDELD
182600990217BL   C                     MOVEL'D'       JSTAT
182700990217BL   C                     ENDIF
182800990211      *
182900990211      * Update order header record.
183000990211     C           *IN99     IFEQ *OFF
183100990211     C                     UPDATHSFORDH
183200990211     C                     ENDIF
183300990211     C                     ENDIF
183400990122     C                     ENDSR
183500990122      *
183600990128      *----------------------------------------------------------------
183700990128      * Create order delivery details.
183800990128     C           UPODEL    BEGSR
183900990215      *
184000990215      * Program mode - Maintenance, or Dispatch
184100000728     C           YMODE     IFEQ 'M'
184200000728     C           YMODE     OREQ 'D'
184300990215      *
184400000728     C           XJSORD    CHAINHSFODEL              99
184500990215     C                     ENDIF
184600990128      *
184700990128      * Write fields for order delivery detail record.
184800000728     C                     MOVELXJCOMP    VCOMP
184900000728     C                     MOVELXJTYPE    VTYPE
185000000728     C                     Z-ADDXJSORD    VSORD
185100000728     C                     MOVELXVNAM1    VNAM1
185200000728     C                     MOVELXVADR1    VADR1
185300000728     C                     MOVELXVADR2    VADR2
185400000728     C                     MOVELXVADR3    VADR3
185500000728     C                     MOVELXVPCDE    VPCDE
185600000728     C                     MOVELXVDIN1    VDIN1
185700000728     C                     MOVELXVDIN2    VDIN2
185800000728     C                     MOVELXVDIN3    VDIN3
185900990128     C                     MOVEL*BLANKS   VDELT
186000990128      *
186100990215      * Program mode - Entry
186200000728     C           YMODE     IFEQ 'E'
186300990211      *
186400990211      * Write order delivery details record.
186500990211     C                     WRITEHSFODEL
186600990211     C                     ENDIF
186700990211      *
186800990215      * Program mode - Maintenance, or Dispatch
186900000728     C           YMODE     IFEQ 'M'
187000000728     C           YMODE     OREQ 'D'
187100990211      *
187200990211      * Update order delivery details record.
187300990211     C           *IN99     IFEQ *OFF
187400990211     C                     UPDATHSFODEL
187500990211     C                     ENDIF
187600990211     C                     ENDIF
187700990211      *
187800990128     C                     ENDSR
187900990128      *----------------------------------------------------------------
188000990128      * Create inventory sales transaction.
188100990128      *----------------------------------------------------------------
188200990128     C           UPINVT    BEGSR
188300990128      *
188400990128      * Write fields for inventory sales transaction record.
188500000728     C                     MOVELXJCOMP    CCOMP
188600000728     C                     MOVELXJWHSE    CWHSE
188700000728     C                     MOVELXKPROD    CPROD
188800990128     C                     MOVEL*BLANKS   CSUBCF
188900990128     C                     MOVEL*BLANKS   CSUBCT
189000990128     C                     MOVEL*BLANKS   CVTYP
189100000728     C                     MOVELXKSERC    CSERC
189200000728     C                     Z-ADDXKSERF    CSERNF
189300990128     C                     Z-ADD0         CELEMF
189400000728     C                     Z-ADDXKSERT    CSERNT
189500990128     C                     Z-ADD0         CELEMT
189600000728     C                     Z-ADDXKQTYN    CQTYN
189700990128     C                     Z-ADD0         CBATC
189800000728BL   C                     MOVELXJSORD    CDELN     P
189900990128     C                     MOVEL*BLANKS   CREAS
190000990128     C                     Z-ADDCYMD      CTDAT
190100990218BL   C                     MOVELMTTYP     CTYPE
190200990128     C                     MOVEL*BLANKS   CSUPP
190300000728     C                     MOVELXJCUST    CCUST
190400990128     C                     MOVEL*BLANKS   CAREA
190500990128     C                     MOVEL*BLANKS   CAISL
190600990128     C                     MOVEL*BLANKS   CBAYR
190700990128     C                     MOVEL*BLANKS   CLEVL
190800990128     C                     MOVEL*BLANKS   CINVN
190900990128     C                     Z-ADDCYMD      CCRTD
191000000728     C                     Z-ADDXXTME     CCRTT
191100000728     C                     MOVELXJOBNO    CCRTS
191200000728     C                     MOVELXUSRID    CCRTU
191300000728     C                     MOVELXPGMID    CCRTP
191400990128     C                     MOVEL*BLANK    CDELT
191500990128      *
191600990128      * Write inventory sales transaction record.
191700990128     C                     WRITEHSFINVT
191800990128     C                     ENDSR
191900990128      *
192000990107      *----------------------------------------------------------------
192100990122      * VALIDH - Validate header screen.
192200990107      *----------------------------------------------------------------
192300990107      *
192400990122     C           VALIDH    BEGSR
192500990108      *
192600990111      * Screen Header validation:
192700990114      *
192800990125      * Reset work values.
192900000728     C                     RESETXERROR
193000990125     C                     MOVE *OFF      *IN61            Hide F10/F11
193100990125      *
193200990125      * Reset error indicators.
193300000728     C                     MOVEAXZEROS    *IN,30
193400990125      *
193500990125      * Validate that Order Type is a valid Type.
193600000728     C           XJTYPE    CHAINHSLORDPA             99
193700990125     C           *IN99     IFEQ *ON
193800990125     C                     MOVE *ON       *IN30
193900000728     C                     MOVE XYES      XERROR
194000990125     C                     MOVEL'HSV2001' P0MSID
194100000728     C                     EXSR YSNDMG
194200990125     C                     ENDIF
194300990125      *
194400990125      * Validate that Company is valid.
194500000728     C           XJCOMP    IFNE *BLANKS
194600000728     C           XJCOMP    CHAINHSLCOMPA             99
194700990125     C           *IN99     IFEQ *ON
194800990125     C                     MOVE *ON       *IN31
194900000728     C                     MOVE XYES      XERROR
195000990125     C                     MOVEL'HSV2002' P0MSID
195100000728     C                     EXSR YSNDMG
195200990125     C                     ENDIF
195300990125     C                     ENDIF
195400990125      *
195500990125      * Validate that Warehouse is valid.
195600000728     C           XJWHSE    IFNE *BLANKS
195700000728     C           XJWHSE    CHAINHSLWHSEA             99
195800990125     C           *IN99     IFEQ *ON
195900990125     C                     MOVE *ON       *IN32
196000000728     C                     MOVE XYES      XERROR
196100990125     C                     MOVEL'HSV0006' P0MSID
196200000728     C                     EXSR YSNDMG
196300990125     C                     ENDIF
196400990125     C                     ENDIF
196500990125      *
196600990125      * Validate Post Code
196700000728XXX  C           XJCUST    IFEQ *BLANKS
196800000728     C           XJPCDE    IFNE *BLANKS
196900000728     C           XJPCDE    CHAINHSLCUSTB             99
197000990125     C           *IN99     IFEQ *ON
197100990125     C                     MOVE *ON       *IN33
197200000728     C                     MOVE XYES      XERROR
197300990125     C                     MOVEL'HSV2003' P0MSID
197400000728     C                     EXSR YSNDMG
197500990125     C                     ENDIF
197600990125      *
197700990125      * If Customer is found
197800990125     C           *IN99     IFEQ *OFF
197900990125      * ...load Customer record into screen fields.
198000000728XXXM C                     MOVELENAM1     XJNAM1           Name 1
198100000728XXXM C                     MOVELENAM2     XJNAM2           Name 2
198200000728XXXM C                     MOVELEADR1     XJADR1           Address 1
198300000728XXXM C                     MOVELEADR2     XJADR2           Address 2
198400000728XXXM C                     MOVE ECUST     XJCUST           Cust No.
198500000728XXX  C                     MOVE ECLIM     XJCLIM 150       Credit Limit
198600000728XXX  C                     MOVE ETYSL     XJTYSL 205       Last Year Sales
198700990225XXX  C                     ENDIF
198800990125      *
198900990125     C                     ENDIF
199000990126     C                     ENDIF
199100990125      *
199200990125      * Validate Customer Number
199300000728XXXD C*          £JCUST    IFNE *BLANKS
199400000728     C           XJCUST    CHAINHSLCUSTA             99
199500990125     C           *IN99     IFEQ *ON
199600990125     C                     MOVE *ON       *IN34
199700000728     C                     MOVE XYES      XERROR
199800990125     C                     MOVEL'HSV2004' P0MSID
199900000728     C                     EXSR YSNDMG
200000990125     C                     ENDIF
200100990125      *
200200990125      * If Customer is found
200300990125     C           *IN99     IFEQ *OFF
200400990125      * ...load Customer record into screen fields.
200500000728XXXM C                     MOVELENAM1     XJNAM1           Name 1
200600000728XXXM C                     MOVELENAM2     XJNAM2           Name 2
200700000728XXXM C                     MOVELEADR1     XJADR1           Address 1
200800000728XXXM C                     MOVELEADR2     XJADR2           Address 2
200900000728XXXM C                     MOVE EPCDE     XJPCDE           Post Code
201000000728XXX  C                     MOVE ECLIM     XJCLIM 150       Credit Limit
201100000728XXX  C                     MOVE ETYSL     XJTYSL 205       Last Year Sales
201200990225XXX   *
201300990225XXX   * Check customer's credit rating allows order entry......
201400990225XXX  C           ECRAT     IFEQ '01 '
201500990225XXX  C                     MOVE *ON       *IN34
201600000728XXX  C                     MOVE XYES      XERROR
201700990225XXX  C                     MOVEL'HSV2018' P0MSID
201800000728XXX  C                     EXSR YSNDMG
201900990225XXX  C                     ENDIF
202000990205      *
202100990205     C                     ENDIF
202200990225XXXD C*                    ENDIF
202300990205      *
202400990205      * Maximum discount is 40%
202500000728     C           XJDISP    IFGT 40
202600990205     C                     MOVE *ON       *IN36
202700000728     C                     MOVE XYES      XERROR
202800990205     C                     MOVEL'HSV0142' P0MSID
202900000728     C                     EXSR YSNDMG
203000990205     C                     ENDIF
203100990215      *
203200990128      * Check order date
203300000728     C           XJORDD    IFEQ 0
203400000728     C                     EXSR YDATEC
203500990125     C                     ELSE
203600990215      *
203700990215      * a) Check for leap year and adjust number of days in February
203800990215      *    in Days in Month array.
203900990215     C           JYY       DIV  4         REM     40
204000990215     C           REM       IFEQ 0
204100990215     C                     MOVEL'Y'       LEAP    1
204200990215     C                     ELSE
204300990215     C                     MOVEL' '       LEAP
204400990215     C                     ENDIF
204500990215     C                     SELEC
204600990215     C           LEAP      WHEQ ' '
204700990215     C                     MOVEA28        DIM,2
204800990215     C           LEAP      WHEQ 'Y'
204900990215     C                     MOVEA29        DIM,2
205000990215     C                     ENDSL
205100990126      * Day
205200990126     C           JDD       IFGT 31
205300990126     C           JDD       ORLT 01
205400990126      * Month
205500990125     C           JMM       ORGT 12
205600990126     C           JMM       ORLT 01
205700990215      *
205800990215      * If date error found...
205900990215     C                     MOVE *ON       *IN35
206000000728     C                     MOVE XYES      XERROR
206100990215     C                     MOVEL'HSV2005' P0MSID
206200000728     C                     EXSR YSNDMG
206300990215     C                     ENDIF
206400990215      *
206500990215      * Validate Day within month.
206600990215     C                     Z-ADDJMM       M       20
206700990215     C           JDD       IFLT 1
206800990215     C           JMM       ORGE 1
206900990215     C           JMM       ANDLE12
207000990215     C           JDD       ANDGTDIM,M
207100990128      *
207200990128      * If date error found...
207300990125     C                     MOVE *ON       *IN35
207400000728     C                     MOVE XYES      XERROR
207500990125     C                     MOVEL'HSV2005' P0MSID
207600000728     C                     EXSR YSNDMG
207700990125     C                     ENDIF
207800990125     C                     ENDIF
207900990125      *
208000990128      * If no errors found...
208100000728     C           XERROR    IFEQ XNO
208200990125      * ...display "Data valid.Press F10 to update" message...
208300990125     C                     MOVEL'HSV9006' P0MSID
208400000728     C                     EXSR YSNDMG
208500990125      * ...activate F10 key (*IN61=*ON).
208600990302     C                     MOVE *ON       *IN61
208700990125     C                     ENDIF
208800990125      *
208900990107     C                     ENDSR
209000990125      *
209100990125      *----------------------------------------------------------------
209200000728      * ‡DATEC - Date Check Routine
209300990125      *----------------------------------------------------------------
209400990125      *
209500000728     C           YDATEC    BEGSR
209600990125      *
209700990128      * Convert six-digit system date to eight digits, with century.
209800990125     C                     MOVELUDAY      DD
209900990125     C                     MOVELUMONTH    MM
210000990125     C                     MOVELUYEAR     YY
210100990125     C           YY        IFGT 80
210200990125     C                     Z-ADD19        CC
210300990125     C                     ELSE
210400990125     C                     Z-ADD20        CC
210500990125     C                     ENDIF
210600990223     C                     MOVELCC        CCYY    40
210700990223     C                     MOVE YY        CCYY
210800990128      *
210900990128      * Set default date for order entry.
211000000728     C           XJORDD    IFEQ 0
211100000728     C                     Z-ADDDMCY      XJORDD
211200990125     C                     ENDIF
211300990128      *
211400990128      * Set date for transaction audit field.
211500990128     C                     Z-ADDDD        DDD
211600990128     C                     Z-ADDMM        MMM
211700990128     C                     Z-ADDCC        CCC
211800990128     C                     Z-ADDYY        YYY
211900990125     C                     ENDSR
212000990125      *
212100990115      *----------------------------------------------------------------
212200000728      * ‡SERCH - F4 prompt control.
212300990115      *----------------------------------------------------------------
212400990115      *
212500000728     C           YSERCH    BEGSR
212600990115      *
212700990115      * Check that cursor is in a valid field for prompting.
212800990126     C           CSRRCD    IFEQ 'HSS200A'
212900000728     C           CSRFLD    ANDEQ'XJCUST'
213000990125     C           CSRRCD    OREQ 'HSS200A'
213100000728     C           CSRFLD    ANDEQ'XJTYPE'
213200990126     C           CSRRCD    OREQ 'HSS200A'
213300000728     C           CSRFLD    ANDEQ'XJCOMP'
213400990125     C           CSRRCD    OREQ 'HSS200A'
213500000728     C           CSRFLD    ANDEQ'XJWHSE'
213600990126     C           CSRRCD    OREQ 'HSS200A'
213700000728     C           CSRFLD    ANDEQ'XJPCDE'
213800990127     C           CSRRCD    OREQ 'HSS200C'
213900000728     C           CSRFLD    ANDEQ'XKPROD'
214000990126      *
214100990119      * Move appropriate data to parameter fields depending upon search
214200990119      * field chosen.
214300990119     C                     SELEC
214400990119      *
214500990119      * Customer No.
214600000728     C           CSRFLD    WHEQ 'XJCUST'
214700000728     C                     MOVEL'HSLCUSTA'FILEY     P
214800000728     C                     MOVEL'ENAM1'   NAMEY     P
214900000728     C                     MOVEL'ECUST'   NUMBRY    P
215000990125      *
215100990125      * Post Code
215200000728     C           CSRFLD    WHEQ 'XJPCDE'
215300000728     C                     MOVEL'HSLCUSTB'FILEY     P
215400000728     C                     MOVEL'ENAM1'   NAMEY     P
215500000728     C                     MOVEL'EPCDE'   NUMBRY    P
215600990119      *
215700990125      * Order Type.
215800000728     C           CSRFLD    WHEQ 'XJTYPE'
215900000728     C                     MOVEL'HSLORDPA'FILEY     P
216000000728     C                     MOVEL'MODES'   NAMEY     P
216100000728     C                     MOVEL'MOTYP'   NUMBRY    P
216200990119      *
216300990125      * Company Code
216400000728     C           CSRFLD    WHEQ 'XJCOMP'
216500000728     C                     MOVEL'HSLCOMPA'FILEY     P
216600000728     C                     MOVEL'WODES'   NAMEY     P
216700000728     C                     MOVEL'WCOMP'   NUMBRY    P
216800990126      *
216900990126      * Warehouse Code
217000000728     C           CSRFLD    WHEQ 'XJWHSE'
217100000728     C                     MOVEL'HSLWHSEA'FILEY     P
217200000728     C                     MOVEL'PODES'   NAMEY     P
217300000728     C                     MOVEL'PWHSE'   NUMBRY    P
217400990125      *
217500990126      * Product Code
217600000728     C           CSRFLD    WHEQ 'XKPROD'
217700000728     C                     MOVEL'HSLPRODA'FILEY     P
217800000728     C                     MOVEL'NDESC'   NAMEY     P
217900000728     C                     MOVEL'NPROD'   NUMBRY    P
218000990125      *
218100990119     C                     ENDSL
218200990115      *
218300990115      * Call system window program to retrieve data.  If Return Code is
218400990115      * *OFF then load retrieved data into screen fields.
218500000728     C                     Z-ADD10        LINY
218600000728     C                     Z-ADD8         COLY
218700990115     C                     CALL 'HSR341'  PL341
218800990119      *
218900990119      * If Return Code is *OFF then load retrieved data into
219000990119      * appropriate screen fields.
219100000728     C           YRTNC     IFEQ *OFF                       ..If2
219200990119      *
219300990119     C                     SELEC
219400990119      *
219500990119      * Customer No.
219600000728     C           CSRFLD    WHEQ 'XJCUST'
219700000728     C                     MOVELYNUMBR    XJCUST    P
219800990125      *
219900990125      * Post Code
220000000728     C           CSRFLD    WHEQ 'XJPCDE'
220100000728     C                     MOVELYNUMBR    XJPCDE    P
220200990119      *
220300990119      * Customer Type.
220400000728     C           CSRFLD    WHEQ 'XJTYPE'
220500000728     C                     MOVELYNUMBR    XJTYPE    P
220600990125      *
220700990125      * Company Code
220800000728     C           CSRFLD    WHEQ 'XJCOMP'
220900000728     C                     MOVELYNUMBR    XJCOMP    P
221000990125      *
221100990125      * Warehouse Code
221200000728     C           CSRFLD    WHEQ 'XJWHSE'
221300000728     C                     MOVELYNUMBR    XJWHSE    P
221400990126      *
221500990126      * Product Code
221600000728     C           CSRFLD    WHEQ 'XKPROD'
221700000728     C                     MOVELYNUMBR    XKPROD    P
221800990119      *
221900990119     C                     ENDSL
222000990121     C                     ENDIF                           ..EndIf2
222100990115      *
222200990119      * otherwise cursor is in wrong format/field so display message.
222300990121     C                     ELSE                            .ElseIf1
222400990115     C                     MOVEL'HSV9009' P0MSID
222500000728     C                     EXSR YSNDMG
222600990119     C                     ENDIF                           .EndIf1
222700990115      *
222800990115     C                     ENDSR
222900990106      *
223000990127      *----------------------------------------------------------------
223100000728      * ‡SERSF - F4 prompt control for order detail subfile.
223200990127      *----------------------------------------------------------------
223300990127      *
223400000728     C           YSERSF    BEGSR
223500990127      * Clear row / column control.
223600990127     C                     Z-ADD0         CSRROW
223700990127     C                     Z-ADD0         CSRCOL
223800990127      *
223900990127      * Retrieve the current cursor position.
224000990127     C           CSRLOC    DIV  256       ROW     20
224100990127     C                     MVR            COL     20
224200990127     C                     Z-ADDROW       CSRROW
224300990127     C                     Z-ADDCOL       CSRCOL
224400990127      *
224500990127      * Execute search.
224600000728     C                     EXSR YSERCH
224700990127      *
224800990127      * Flag subfile record to return value.
224900990127     C           CSRRRN    CHAINHSS200C              99
225000990127     C           *IN99     IFEQ *OFF
225100990127     C                     MOVEL*ON       *IN37
225200000728XXX  C           YNUMBR    IFNE *BLANKS
225300000728     C                     MOVELYNUMBR    XKPROD    P
225400990225XXX  C                     ENDIF
225500990127     C                     UPDATHSS200C
225600990127     C                     MOVEL*OFF      *IN37
225700990127     C                     ENDIF
225800990127     C                     ENDSR
225900990127      *
226000990106      *----------------------------------------------------------------
226100000728      * ‡SNDMG - Send message to this program's MSGQ.
226200990106      *----------------------------------------------------------------
226300990106      *
226400000728     C           YSNDMG    BEGSR
226500990106      *
226600990107     C                     CALL 'SNDMSGC'
226700990106     C                     PARM           P0PGMQ           Program queue
226800990106     C                     PARM           P0PGRL           Rel queue
226900990106     C                     PARM           P0MSID           Message ID
227000990106     C                     PARM           P0MSGF           Message file
227100990106     C                     PARM           P0MSDA           Message data
227200990106     C                     PARM           P0MSTP           Message type
227300990106      *
227400990106     C                     ENDSR
227500990106      *
227600990106      *----------------------------------------------------------------
227700000728      * ‡CLRMG - Clear message(s) from this program's MSGQ.
227800990106      *----------------------------------------------------------------
227900990106      *
228000000728     C           YCLRMG    BEGSR
228100990106      *
228200990107     C                     CALL 'RMVMSGC'
228300990106      *
228400990106     C                     ENDSR
228500990106      *
228600990223      *----------------------------------------------------------------
228700990223      * *UPPVCT- Update the voucher control
228800990223      *----------------------------------------------------------------
228900990223      *
229000990223     C           UPPVCT    BEGSR
229100990225     C                     Z-ADD1         RRNQ
229200990225     C           RRNQ      CHAINHSS200C              97
229300990223     C           *IN97     DOWEQ*OFF
229400990223      *
229500990225     C                     ADD  1         RRNQ
229600000728     C           XSELC     IFNE *BLANK
229700000728     C           XKPROD    ORNE *BLANK
229800000728     C           XNDESC    ORNE *BLANK
229900000728     C           XKPRIC    ORNE *ZEROS
230000000728     C           XKQTYN    ORNE *ZEROS
230100000728     C           XKVALU    ORNE *ZEROS
230200000728     C           XKVATA    ORNE *ZEROS
230300000728     C           XKSERC    ORNE *BLANKS
230400000728     C           XKSERF    ORNE *ZEROS
230500000728     C           XKSERT    ORNE *ZEROS
230600000728     C                     MOVE XKSERC    WKSERC
230700000728     C                     MOVE XKSERT    TEMP    90
230800990223     C                     ADD  1         TEMP
230900990223     C           VCHKEY    SETLLHSLVCTLA
231000000728     C           XKPROD    READEHSLVCTLA                 92
231100990223     C                     MOVE TEMP      BSERNN
231200990223     C                     UPDATHSFVCTL
231300990223     C                     ENDIF
231400990223      *
231500990225     C           RRNQ      IFEQ 100
231600990223     C                     LEAVE
231700990223     C                     ENDIF
231800990225     C           RRNQ      CHAINHSS200C              97
231900990223     C                     ENDDO
232000990223     C                     ENDSR
232100990223      *
232200990106      *----------------------------------------------------------------
232300990106      * *INZSR - Initialization.
232400990106      *----------------------------------------------------------------
232500990106      *
232600990106     C           *INZSR    BEGSR
232700990217BL    *
232800990217BL    * Dummy read to open file.
232900990217BL   C                     READ HSPINVT                  99
233000990222BL   C                     UPDATHSFINVT
233100990302     C                     OPEN HSLEXPAA
233200990302BL   C                     READ HSLEXPAA                 99
233300990302     C                     CLOSEHSLEXPAA
233400990127      *
233500990106      * Key lists.
233600990128      * Key List for Voucher Control.
233700990127     C           VCHKEY    KLIST
233800000728     C                     KFLD           XKPROD
233900990128     C                     KFLD           WKSERC
234000990223      *
234100990223      * Key List for Voucher Cross-Reference.
234200990223     C           KEYXRF    KLIST
234300990223     C                     KFLD           CCYY
234400000728     C                     KFLD           XJCUST
234500000728     C                     KFLD           XKPROD
234600990205      *
234700990211      * Key List for Sales Order.
234800990211     C           KEYOLN    KLIST
234900000728     C                     KFLD           XJSORD
235000000728     C                     KFLD           XOLIN
235100990211      *
235200990205      * Key List for Inventory Masterfile.
235300990205     C           IVMKEY    KLIST
235400000728     C                     KFLD           XKPROD
235500990205     C                     KFLD           WKSUBC
235600990205     C                     MOVE *BLANKS   WKSUBC
235700990115      *
235800990128      * Key List for Voucher Tracking.
235900990128     C           TRCKEY    KLIST
236000000728     C                     KFLD           XKPROD
236100000728     C                     KFLD           XKSERC
236200000728     C                     KFLD           XKSERF
236300990215      *
236400990301      * Key List for Customer Discount File.
236500990215     C           DSCKEY    KLIST
236600990215     C                     KFLD           ECTYP
236700990215     C                     KFLD           PFAMT
236800990128      *
236900990115      * Parameter Lists.
237000990203      * Entry parameter list.
237100990203     C           *ENTRY    PLIST
237200000728     C                     PARM           YMODE   1        Mode
237300000728     C                     PARM           YORDNO  8        Sales Order No.
237400000728     C                     PARM           YTYPE   3        Order Type
237500000728     C                     PARM           YCUST   8        Customer No.
237600990203      *
237700990115      * List for Call to HSR341 - Search program.
237800990115     C           PL341     PLIST
237900000728     C                     PARM           YRTNC   1
238000000728     C                     PARM           YNUMBR 15
238100000728     C                     PARM           FILEY  10
238200000728     C                     PARM           NAMEY   6
238300000728     C                     PARM           NUMBRY  6
238400000728     C                     PARM           LINY    30
238500000728     C                     PARM           COLY    30
238600990127      *
238700990127      * Field definitions
238800000728     C           *LIKE     DEFN XKVALU    WKTOTV
238900000728     C           *LIKE     DEFN XKSERC    WKSERC
239000990128     C           *LIKE     DEFN BSERNN    WKSERN
239100000728     C           *LIKE     DEFN XKQTYN    WKQTYN
239200990211     C           *LIKE     DEFN DSUBC     WKSUBC
239300000728     C           *LIKE     DEFN XNO       WKRANG
239400000728     C           *LIKE     DEFN XNO       WKVCTL
239500000728     C           *LIKE     DEFN XNO       UPDAT
239600990106      *
239700990106      * Variable declarations.
239800000728     C                     MOVE '0'       XNO     1
239900000728     C                     MOVE '1'       XYES    1
240000000728     C                     MOVE XNO       XERROR  1
240100000728     C                     MOVE XNO       XUPDAT  1
240200000728     C                     MOVE XNO       XDELET  1
240300990217BL   C                     MOVEL*BLANKS   ORDPRM  8
240400990126     C                     Z-ADD1         RCDNBR
240500000728     C                     Z-ADD0         RRNX    50
240600990211     C                     Z-ADD0         RRNVAL  50
240700990225     C                     Z-ADD0         RRNLIN  50
240800990225     C                     Z-ADD0         RRNQ    50
240900990225     C                     Z-ADD0         RRNP    50
241000990106      *
241100990106      * Prepare message subfile.
241200990106     C                     MOVE *ON       *IN79
241300000728     C                     MOVE XPGMID    P0PGMQ 10        Program queu
241400990111     C                     MOVEL'*PRV'    P0PGRL  5        Rel queue
241500990106     C                     MOVE *BLANKS   P0MSID  7        Message ID
241600990106     C                     MOVEL'HSM001'  P0MSGF 10        Message file
241700990106     C                     MOVE *BLANKS   P0MSDA132        Message data
241800990106     C                     MOVEL'*INFO'   P0MSTP  7        Message type
241900990204      *
242000000728     C                     EXSR YDATEC
242100990106      *
242200990106     C                     ENDSR
242300990215** Days in Month array DIM.
242400990215312831303130313130313031
