000100870421      ****************************************************************
000200870421      *                                                              *
000300000727      * APPLICATION NAME...........: . APPLICATIONS WITH THE PF BPFSK*
000400000727      * COPY NAME..................: . WKAFSK                        *
000500000727      * TYPE OF COPY...............: . DEFINITION WORKING            *
000600000727      * FUNCTION...................: . CENTURY FIELDS FOR DATES IN   *
000700000727      *         .                      FILE BPFSK                    *
000800000727      * OTHER COPIES REQUIRED......: . ASSOCIATED  TO SRAFSKI        *
000900000727      *         .                            AND SRAFSKO             *
001000000727      * COPY LOCATION..............: . WORKING-STORAGE               *
001100870421      *         .                                                    *
001200000727      * GLOBAL FIELDS TOUCHED......: .                               *
001300870421      *         .                                                    *
001400000727      * INPUT PARAMETERS...........: .                               *
001500870421      *         .                                                    *
001600000727      * OUTPUT PARAMETERS..........: .                               *
001700870430      *         .                                                    *
001800870421      *                                                              *
001900870421      ****************************************************************
002000870430      *
002100990628       01  WK-BPFSK VALUE SPACES.
002200990602      *
002300000727      *---<MODIFICATION DATE>--------------------------------------------------*
002400990615           05          WK-SKXXM-AAMMJJ.
002500990615              10       WK-SKAAM.
002600990615                 15    WK-SKAAM-1                 PIC X.
002700990615                 15    WK-SKAAM-2                 PIC X.
002800990615              10       WK-SKMMM                   PIC XX.
002900990615              10       WK-SKJJM                   PIC XX.
003000990602      *
003100990615           05          WK-SKXXM-SSAAMMJJ.
003200990615              10       WK-SKXXM-SS                PIC XX.
003300990615              10       WK-SKXXM-AAMMJJ-S.
003400990615                 15    WK-SKAAM-S.
003500990615                    20 WK-SKAAM-S-1               PIC X.
003600990615                    20 WK-SKAAM-S-2               PIC X.
003700990615                 15    WK-SKMMM-S                 PIC XX.
003800990615                 15    WK-SKJJM-S                 PIC XX.
003900990603      *
004000990603      **************************************************************************
004100990602      *
