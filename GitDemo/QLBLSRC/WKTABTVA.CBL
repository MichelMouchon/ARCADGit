000100870430      ****************************************************************
000200870430      *                                                              *
000300000727      * APPLICATION NAME...........: . ALL APPLICATIONS              *
000400000727      * COPY NAME..................: . WKTABTVA                      *
000500000727      * COPY TYPE..................: . DEFINITION GENERAL FIELD      *
000600000727      * FUNCTION...................: . INFORMATION FOR THE TAX RATES *
000700000727      * OTHER COPIES REQUIRED......: .                               *
000800870430      *         .                                                    *
000900000727      * COPY LOCATIONµ.............: . WORKING-STORAGE               *
001000970605      *                                                              *
001100000727      *  LAST MODIFICATION DATE.....: 05/06/97 BY JNF                *
001200000727      *  LAST MODIFICATION SUBJECT..: CORRESPONDANCE TAX CODE FOR    *
001300000727      *                                   TWO SITES                  *
001400970605      *                                                              *
001500870430      ****************************************************************
001600880812       01  WK-TVA-CLE        VALUE "XXART   TVA   0000  ".
001700880812           05  WK-TVA-RAC            PIC X(18).
001800871102           05  FILLER                PIC XX.
001900871102       01  WK-TVA-NBPST              PIC 99    VALUE  10.
002000991026M01?V  01  WK-TVA-TABLE              VALUE     SPACE.
002100900626           05  FILLER                PIC X(754).
002200991026M01?V  01  WK-TVA-TABLE-REDEF REDEFINES WK-TVA-TABLE.
002300871102           05  WK-TVA-TP             OCCURS 10 INDEXED BY IN-TVA.
002400871102               10  WK-TVA-LIB        PIC X(20).
002500871102               10  WK-TVA-TVAT       PIC S9(3)V9(2) COMP-3.
002600871102               10  WK-TVA-TVAT-CENT  REDEFINES WK-TVA-TVAT
002700871102                                     PIC S9V9(4)    COMP-3.
002800871102               10  WK-TVA-TVATL      PIC S9(2)V9(5) COMP-3.
002900871102               10  WK-TVA-TVATL-CENT REDEFINES WK-TVA-TVATL
003000880617                                     PIC SV9(7)      COMP-3.
003100871102               10  WK-TVA-TVAE       PIC X(5).
003200871102               10  WK-TVA-TVAM       PIC S9(1)V9(4) COMP-3.
003300871102               10  WK-TVA-TVAML      PIC S9(2)V9(7) COMP-3.
003400871102               10  WK-TVA-TVVT       PIC S9(3)V9(2) COMP-3.
003500871102               10  WK-TVA-TVVT-CENT  REDEFINES WK-TVA-TVVT
003600871102                                     PIC S9V9(4)    COMP-3.
003700871102               10  WK-TVA-TVVTL      PIC S9(2)V9(5) COMP-3.
003800871102               10  WK-TVA-TVVTL-CENT REDEFINES WK-TVA-TVVTL
003900880617                                     PIC SV9(7)      COMP-3.
004000871102               10  WK-TVA-TVVE       PIC X(5).
004100871102               10  WK-TVA-TVVM       PIC S9(1)V9(4) COMP-3.
004200871102               10  WK-TVA-TVVML      PIC S9(2)V9(7) COMP-3.
004300900615               10  WK-TVA-ACTIF      PIC X.
004400900615               10  WK-TVA-REGIE      PIC X.
004500970605               10  WK-TVA-CORRES     PIC X(2).
004600991026M01?C *    05  WK-TVA-DATE           PIC X(6).
004700991026M01?C      05  WK-TVA-DATE           PIC X(8).
004800871102           05  WK-TVA-NMSG           PIC X(7).
004900871210           05  WK-TVA-VMSG           PIC X(121).
005000870507      *
