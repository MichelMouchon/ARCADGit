000100870430      ****************************************************************
000200870430      *                                                              *
000300000727      * APPLICATION NAME...........: . ALL APPLICATIONS              *
000400000727      * COPY NAME..................: . WKGENERAL                     *
000500000727      * COPY TYPE..................: . GENERAL FIELD DEFINITION      *
000600000727      * FUNCTION...................: . TABLE OF GENERAL FILEDS       *
000700000727      *         .                           AND CONSTANTS            *
000800000727      * OTHER COPIES REQUIRED......: .                               *
000900870430      *         .                                                    *
001000000727      * COPY LOCATION..............: . WORKING-STORAGE               *
001100870430      *         .                                                    *
001200000727      * GLOBAL  FIELDS TOUCHED.....: .                               *
001300870430      *         .                                                    *
001400000727      * INPUT PARAMETERS...........: .                               *
001500870430      *         .                                                    *
001600000727      * OUTPUT PARAMETERS..........: .                               *
001700870430      *         .                                                    *
001800870430      *                                                              *
001900870430      ****************************************************************
002000870601      *---------------------------
002100870601      *-      ZONES   I-O        -
002200870601      *---------------------------
002300870601       01  ST                     PIC XX.
002400881128       01  FILLER VALUE SPACE.
002500881128           05  WTILT              PIC 9.
002600870430      *---------------------------
002700870430      *-    BOOLEENS GENERAUX    -
002800870430      *---------------------------
002900870423       01  VRAI                   PIC 1 VALUE B"1".
003000870423       01  FAUX                   PIC 1 VALUE B"0".
003100870512      *------------------------------
003200870512      *-    CARACTERES DUPLIQUES    -
003300870512      *------------------------------
003400870512      * PIC S9999 COMP-4 VALUE 7196 CORRESPOND A
003500870512      *     2 OCTETS DE VALEUR HEXA X"1C"
003600870512       01         DUPLIC.
003700870512           05          FILLER          PIC S9999 COMP-4 VALUE 7196.
003800870512           05          FILLER          PIC S9999 COMP-4 VALUE 7196.
003900870512           05          FILLER          PIC S9999 COMP-4 VALUE 7196.
004000870512           05          FILLER          PIC S9999 COMP-4 VALUE 7196.
004100870512           05          FILLER          PIC S9999 COMP-4 VALUE 7196.
004200870512       01         FILLER REDEFINES DUPLIC.
004300870512           05          DUPLIC10.
004400870512            07         DUPLIC9.
004500870512             09        DUPLIC8.
004600870512              11       DUPLIC7.
004700870512               13      DUPLIC6.
004800870512                15     DUPLIC5.
004900870512                 17    DUPLIC4.
005000870512                  19   DUPLIC3.
005100870512                   21  DUPLIC2.
005200870512                    23 DUPLIC1         PIC X.
005300870512                    23 FILLER          PIC X.
005400870512                   21  FILLER          PIC X.
005500870512                  19   FILLER          PIC X.
005600870512                 17    FILLER          PIC X.
005700870512                15     FILLER          PIC X.
005800870512               13      FILLER          PIC X.
005900870512              11       FILLER          PIC X.
006000870512             09        FILLER          PIC X.
006100870512            07         FILLER          PIC X.
