000100990603      ****************************************************************
000200990603      *                                                              *
000300000727      * APPLICATION NAME...........: . APPLICATIONS WITH THE PF BPFER*
000400000727      * COPY NAME..................: . SRAFER2O                      *
000500000727      * TYPE OF COPY...............: . MODULE                        *
000600000727      * FUNCTION...................: . DATE WITH SYSTEM  HIGH VALUE  *
000700000727      *         .                      WRITING TO FILE BPFER         *
000800000727      * OTHER COPIES REQUIRED......: . WKAFER IN WORKING             *
000900990609      *         .                                                    *
001000000727      * COPY LOCATION..............: . PROCEDURE                     *
001100990603      *         .                                                    *
001200000727      * GLOBAL FIELDS TOUCHED......: .                               *
001300990603      *         .                                                    *
001400000727      * INPUT PARAMETERS...........: .                               *
001500990603      *         .                                                    *
001600000727      * OUTPUT PARAMETERS..........: .                               *
001700990603      *         .                                                    *
001800990603      *                                                              *
001900990603      ****************************************************************
002000990603      *
002100990616       SRAFER2O.
002200990603      *
002300000727      *---<RECEPTION DATE>-----------------------------------------------------*
002400990615           IF WK-ERXXRC-SS = "20"
002500990615              MOVE HIGH-VALUE    TO WK-ERAARC-1
002600990615              MOVE WK-ERAARC-S-2 TO WK-ERAARC-2
002700990603           ELSE
002800990615              MOVE WK-ERAARC-S TO WK-ERAARC
002900990603           END-IF
003000990615           MOVE WK-ERMMRC-S TO WK-ERMMRC
003100990615           MOVE WK-ERJJRC-S TO WK-ERJJRC
003200990616           MOVE WK-ERAARC TO ERAARC OF BPFER
003300990616           MOVE WK-ERMMRC TO ERMMRC OF BPFER
003400990616           MOVE WK-ERJJRC TO ERJJRC OF BPFER.
003500990609      *
003600991116       SRAFER2O-FIN.
003700991116           EXIT.
003800990603      *
