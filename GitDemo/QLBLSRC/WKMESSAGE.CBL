000100870430      ****************************************************************
000200870430      *                                                              *
000300000727      * APPLICATION NAME...........: . ALL APPLICATIONS              *
000400000727      * COPY NAME..................: . WKMESSAGE                     *
000500000727      * COPY TYPE..................: . DEFINITION GENERAL FIELD      *
000600000727      * FUNCTION...................: . CALL PARAMETERS TO WORK       *
000700000727      *         .                        WITH BATCH MESSAGES         *
000800000727      * OTHER COPIES REQUIRED......: .                               *
000900870430      *         .                                                    *
001000000727      * COPY LOCATION..............: . WORKING-STORAGE               *
001100870430      *         .                                                    *
001200870507      * UTILISATION................: .                               *
001300000727      *         .  IF THERE ARE NO SUBSTITUTION VARIABLES, PUT       *
001400000727      *         .    SPACE     IN   WK-MESSAGE-LIB                   *
001500000727      *         .  IF IT IS NOT A QUESTION, PUT SPACE IN             *
001600000727      *         .    WK-MESSAGE-REP ELSE  "*INQ"                     *
001700870507      *         .                                                    *
001800871117      *         .  MOVE "XXX99999" TO WK-MESSAGE-NO                  *
001900871117      *         .  MOVE SPACE      TO WK-MESSAGE-LIB                 *
002000871117      *         .  MOVE SPACE      TO WK-MESSAGE-REP                 *
002100870511      *         .                                                    *
002200871117      *         .  CALL "ACLMG100" USING WK-MESSAGE                  *
002300871117      *         .                                                    *
002400870507      * PARAMETRE(S) EN ENTREE.....: .                               *
002500871117      *         . WK-MESSAGE-NO    7  NUMEROS DE MESSAGES            *
002600871117      *         . WK-MESSAGE-LIB 121  VARIABLES DE SUBSTITUTION      *
002700871117      *         . WK-MESSAGE-REP 128  SPACE OU "*INQ"                *
002800870430      * PARAMETRE(S) EN SORTIE.....: .                               *
002900871117      *         . WK-MESSAGE-REP 128  REPONSE                        *
003000870430      *                                                              *
003100870430      ****************************************************************
003200871117       01  WK-MESSAGE VALUE SPACE.
003300871117           10      WK-MESSAGE-NO        PIC X(7).
003400871117           10      WK-MESSAGE-LIB       PIC X(121).
003500871117           10      WK-MESSAGE-REP       PIC X(128).
003600880929      ****************************************************************
003700880929      * FONCTION...................: . TABLES DES MESSAGES PROGRAMME *
003800880929      ****************************************************************
003900880929       01  WK-TABLMSG.
004000880929           05      FILLER               PIC X(128) VALUE SPACE.
004100880929       01  WK-RTABLMSG  REDEFINES  WK-TABLMSG.
004200880929           05      WK-TMSG-PST          OCCURS    1 INDEXED BY IN-TMSG.
004300880929               10  WK-TMSG-NO           PIC X(7).
004400880929               10  WK-TMSG-LIB          PIC X(121).
004500880929      *
