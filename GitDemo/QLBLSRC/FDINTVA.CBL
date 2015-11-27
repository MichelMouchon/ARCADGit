000100000000      ****************************************************************
000200000727      * APPLICATION NAME...........: . ALL APPLICATIONS              *
000300000727      * COPY NAME..................: . FDINTVA                       *
000400000727      * TYPE OF COPY...............: . DEFINITION GENERAL FIELD      *
000500000727      * FUNCTION...................: . DESCRIPTION INFODI            *
000600000727      *         .                        TAX RECORD                  *
000700000727      * OTHER COPIES REQUIRED......: .                               *
000800000000      *         .                                                    *
000900000727      * COPY LOCATION..............: . INPUT-OUTPUT SECTION          *
001000000727      *         .   T  = RATE                                        *
001100000727      *         .   TL = LONG RATE (+ PRECISE)                       *
001200000727      *         .   E  = EDIT                                        *
001300000727      *         .   M  = COEFFICIENT  =  1 + RATE / 100              *
001400000727      *         .   ML = COEFF LONG (+ PRECISE)                      *
001500970605      *                                                              *
001600000727      *  LAST MODIFICATION DATE. ...: 05/06/97 BY JNF                *
001700000727      *  LAST MODIFICATION REASON...: CORRESPONDANCE TAX CODE FOR    *
001800000727      *                                  TWO SITES                   *
001900970605      *                                                              *
002000000000      ****************************************************************
002100991026M01?V  01  FDIN-TVA.
002200880812           05  FDIN-TVA-CLEF.
002300880812               10  FDIN-TVA-CLEF-GEN  PIC X(18).
002400880812               10  FDIN-TVA-CLEF-VER  PIC X(2).
002500880812           05  FDIN-TVA-LIB           PIC X(20).
002600880812      ********   SUR ACHAT
002700880812           05  FDIN-TVA-TVAT          PIC S9(2)V9(2).
002800880812           05  FDIN-TVA-TVATL         PIC S9(2)V9(5).
002900880812           05  FDIN-TVA-TVAE          PIC X(5).
003000880812           05  FDIN-TVA-TVAM          PIC S9(1)V9(4).
003100880812           05  FDIN-TVA-TVAML         PIC S9(1)V9(7).
003200880812      ********   SUR VENTE
003300880812           05  FDIN-TVA-TVVT          PIC S9(2)V9(2).
003400880812           05  FDIN-TVA-TVVTL         PIC S9(2)V9(5).
003500880812           05  FDIN-TVA-TVVE          PIC X(5).
003600880812           05  FDIN-TVA-TVVM          PIC S9(1)V9(4).
003700880812           05  FDIN-TVA-TVVML         PIC S9(1)V9(7).
003800900614      *
003900900614           05  FILLER                 PIC XX.
004000900614      *
004100900614      ***** Code TVA actif        O/N        101
004200900615           05  FDIN-TVA-ACTIF         PIC X.
004300900615      ***** Code TVA avec regie   O/N        102
004400900615           05  FDIN-TVA-REGIE         PIC X.
004500910903      ***** Code TVA achat COFRADEL correspondant  Pos:103/Lg:02
004600910903           05  FDIN-TVA-COFACH           PIC X(2).
004700910903      ***** Code TVA vente COFRADEL correspondant  Pos:105/Lg:02
004800910903           05  FDIN-TVA-COFVEN           PIC X(2).
004900970605      ***** Correspondance d'un autre site         Pos:107/Lg:02
005000970605           05  FDIN-TVA-CORRES           PIC X(2).
005100970605      ***** Zone non utilisée                      Pos:109/Lg:148
005200970605           05  FILLER                 PIC X(148).
005300000000      *
