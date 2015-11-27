000100870421      ****************************************************************
000200870421      *                                                              *
000300000727      * APPLICATION NAME...........: . APPLICATIONS WITH THE PF      *
000400990615      *                                BPFER                         *
000500000727      * COPY NAME..................: . WKAFER                        *
000600000727      * TYPE OF COPY...............: . DEFINITION WORKING            *
000700000727      * FUNCTION...................: . CENTURY FIELDS FOR DATES IN   *
000800000727      *         .                      FILE BPFER                    *
000900000727      * OTHER COPIES REQUIRED......: . ASSOCIATED TO SRAFERI         *
001000000727      *         .                            AND SRAFERO             *
001100000727      * COPY LOCATION..............: . WORKING-STORAGE               *
001200870421      *         .                                                    *
001300000727      * GLOBAL FIELDS TOUCHED......: .                               *
001400870421      *         .                                                    *
001500000727      * INPUT PARAMETERS...........: .                               *
001600870421      *         .                                                    *
001700000727      * OUTPUT PARAMETERS..........: .                               *
001800870430      *         .                                                    *
001900870421      *                                                              *
002000870421      ****************************************************************
002100870430      *
002200990628       01  WK-BPFER VALUE SPACES.
002300990602      *
002400000727      *---<RECEPTION DATE>-----------------------------------------------------*
002500990615           05          WK-ERXXRC-AAMMJJ.
002600990615              10       WK-ERAARC.
002700990615                 15    WK-ERAARC-1                PIC X.
002800990615                 15    WK-ERAARC-2                PIC X.
002900990615              10       WK-ERMMRC                  PIC XX.
003000990615              10       WK-ERJJRC                  PIC XX.
003100990602      *
003200990615           05          WK-ERXXRC-SSAAMMJJ.
003300990615              10       WK-ERXXRC-SS               PIC XX.
003400990615              10       WK-ERXXRC-AAMMJJ-S.
003500990615                 15    WK-ERAARC-S.
003600990615                    20 WK-ERAARC-S-1              PIC X.
003700990615                    20 WK-ERAARC-S-2              PIC X.
003800990615                 15    WK-ERMMRC-S                PIC XX.
003900990615                 15    WK-ERJJRC-S                PIC XX.
004000991022           05    WK-ERXXRC-SSAAMMJJR REDEFINES WK-ERXXRC-SSAAMMJJ.
004100991022              10       WK-ERXXRC-SSAA-S           PIC 9(4).
004200991022              10       WK-ERXXRC-MMJJ-S           PIC 9(4).
004300990603      *
004400990603      **************************************************************************
004500990602      *
