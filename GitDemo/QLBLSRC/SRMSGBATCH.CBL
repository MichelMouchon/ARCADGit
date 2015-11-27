000100871208      ****************************************************************
000200000727      * APPLICATION NAME...........: . ALL APPLICATIONS              *
000300000727      * COPY NAME..................: . SRMSGBATCH                    *
000400000727      * TYPE OF COPY...............: . SUB-ROUTINE  (PERFORM)        *
000500000727      * FUNCTION...................: . WORK WITH BATCH MESSAGES      *
000600870511      *         .                                                    *
000700000727      * OTHER REQUIRED COPIES......: . WKMSGBATCH       IN WORKING   *
000800870511      *         .                                                    *
000900000727      * COPY LOCATION..............: . PROCEDURE                     *
001000870511      *         .                                                    *
001100000727      * INPUT PARAMETERS...........: .                               *
001200871117      *         . WK-MESSAGE-NO  WK-MESSAGE-LIB                      *
001300000727      *         . WK-MESSAGE-REP   = BLANK OR "*INQ"                 *
001400000727      * OUTPUT PARAMETERS..........: .                               *
001500000727      *         . WK-MESSAGE-REP   ...... THE REPLY                  *
001600870511      ****************************************************************
001700870511      *
001800871123       AFF-MESSAGE.
001900871117           CALL     "ACLMG100"            USING   WK-MESSAGE.
002000871117           MOVE     SPACE                 TO      WK-MESSAGE-NO.
002100871123           MOVE     SPACE                 TO      WK-MESSAGE-LIB.
002200871123       AFF-MESSAGE-EXIT.
002300870507           EXIT.
002400871117      *
002500870709       TILT.
002600871117           IF WK-MESSAGE-NO = SPACE
002700871117              MOVE "XXX0101"           TO  WK-MESSAGE-NO
002800871117              MOVE SPACE               TO  WK-MESSAGE-REP.
002900871123           PERFORM AFF-MESSAGE         THRU  AFF-MESSAGE-EXIT.
003000871124           SET     SW0    TO  ON.
003100871117           STOP   RUN.
003200870709      *
