000100870421      ****************************************************************
000200870421      *                                                              *
000300000727      * APPLICATION NAME...........: . WAREHOUSE                     *
000400000727      * COPY NAME..................: . FDAPFIN                       *
000500000727      * TYPE OF COPY...............: . FILE DESCRIPTION              *
000600000727      * FUNCTION...................: . INFORMATION FILE GENERAL      *
000700000727      *         .                        COPY                        *
000800000727      * OTHER COPIES REQUIRED......: . UPDATE THE DDS COPY AFTER     *
000900870421      *         .                                                    *
001000000727      * COPY LOCATION..............: . FILE SECTION                  *
001100870421      *         .                                                    *
001200000727      * GLOBAL FIELDS TOUCHED......: .                               *
001300870421      *         .                                                    *
001400000727      * INPUT PARAMETERS...........: .                               *
001500870421      *         .                                                    *
001600000727      * OUTPUT PARAMETERS..........: .                               *
001700870421      *         .                                                    *
001800870421      *                                                              *
001900870421      ****************************************************************
002000870512       FD  FINFODI   LABEL RECORD STANDARD
002100870525                     RECORD 256.
002200991026M01?V  01  INF-ENR.
002300870512           05        INF-CLE.
002400870527            10       INF-CLE-RAC18.
002500870527             15      INF-CLE-APPLICATION    PIC X(2).
002600870527             15      INF-CLE-LIB1           PIC X(6).
002700870527             15      INF-CLE-LIB2           PIC X(6).
002800870527             15      INF-CLE-NUMERO         PIC X(4).
002900880421            10       FILLER REDEFINES INF-CLE-RAC18.
003000880421             15      INF-CLE-RAC1-16        PIC X(16).
003100880421             15      INF-CLE-RAC17-18.
003200880421              20     INF-CLE-RAC17-18-NUM   PIC 99.
003300871103            10       INF-CLE-SEQENR.
003400871103             15      INF-CLE-SEQENR9        PIC 9(2).
003500870525           05        INF-CORPS              PIC X(223).
003600991026M01?V      05        INF-FIN.
003700991026M01?V       10       INF-MAJ-DATE.
003800000510M01?C        15      INF-MAJ-AA             PIC XX.
003900870512             15      INF-MAJ-MM             PIC XX.
004000870512             15      INF-MAJ-JJ             PIC XX.
004100870525            10       INF-MSG                PIC X(7).
004200870416      *
