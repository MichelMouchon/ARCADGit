000100990603      ****************************************************************
000200990603      *                                                              *
000300000727      * APPLICATION NAME...........: . APPLICATIONS WITH THE PF BPFSK*
000400000727      * COPY NAME..................: . SRAFSKO                       *
000500000727      * COPY TYPE..................: . MODULE                        *
000600000727      * FUNCTION...................: . DATE WITH SYSTEM HIGH VALUE   *
000700000727      *         .                      IN WRITING FOR FILE BPFSK     *
000800000727      * OTHER COPIES REQUIRED......: . WKAFSK IN WORKING             *
000900990609      *         .                                                    *
001000000727      * COPY LOCATION..............: . PROCEDURE                     *
001100990603      *         .                                                    *
001200000727      * GLOBAL FILEDS TOUCHED......: .                               *
001300990603      *         .                                                    *
001400000727      * INPUT PARAMETERS...........: .                               *
001500990603      *         .                                                    *
001600000727      * OUTPUT PARAMETERS..........: .                               *
001700990603      *         .                                                    *
001800990603      *                                                              *
001900990603      ****************************************************************
002000990603      *
002100991105       SRAFSK2O.
002200990603      *
002300000727      *---<MODIFICATION DATE>--------------------------------------------------*
002400990615           IF WK-SKXXM-SS = "20"
002500990615              MOVE HIGH-VALUE    TO WK-SKAAM-1
002600990615              MOVE WK-SKAAM-S-2 TO WK-SKAAM-2
002700990603           ELSE
002800990615              MOVE WK-SKAAM-S TO WK-SKAAM
002900990603           END-IF
003000990615           MOVE WK-SKMMM-S TO WK-SKMMM
003100990615           MOVE WK-SKJJM-S TO WK-SKJJM
003200991105           MOVE WK-SKAAM TO SKAAM OF SK-ENR-DDS
003300991105           MOVE WK-SKMMM TO SKMMM OF SK-ENR-DDS
003400991105           MOVE WK-SKJJM TO SKJJM OF SK-ENR-DDS.
003500991116       SRAFSK2O-FIN.
003600991116           EXIT.
003700990609      *
003800990603      *
003900870416      *
