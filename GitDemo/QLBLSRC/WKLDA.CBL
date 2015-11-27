000100870430      ****************************************************************
000200870430      *                                                              *
000300000727      * APPLICATION NAME...........: . ALL APPLICATIONS              *
000400000727      * COPY NAME..................: . WKLDA                         *
000500000727      * COPY TYPE..................: . DEFINITION GENERAL FIELD      *
000600000727      * FUNCTION...................: . IMAGE OF THE LDA              *
000700871103      *         .                                                    *
000800000727      * OTHER COPIES REQUIRED......: .                               *
000900870430      *         .                                                    *
001000000727      * COPY LOCATION..............: . WORKING-STORAGE               *
001100870430      *         .                                                    *
001200870507      * UTILISATION................: .                               *
001300871103      *         .  ACCEPT WKLDA FROM LDA.                            *
001400000727      *                 (LDA DESCRIBED IN SPECIAL-NAMES)             *
001500870430      ****************************************************************
001600871103       01  WKLDA.
001700871104           05        LDA-GENERAL.
001800881229      *********  TYPE DE FICHIER FOURNISSEUR     1,1
001900871104             10      LDA-FOUR           PIC X.
002000881229      *********  TYPE DE FICHIER CLIENT          2,1
002100871201             10      LDA-CLI            PIC X.
002200881229      *********  TYPE DE FICHIER ARTICLE         3,1
002300881229             10      LDA-ART            PIC X.
002400881229      *********  MODE : V=VISUEL                 4,1
002500871216             10      LDA-MODE           PIC X.
002600881229      *********  MODE : M=CONTROLE MODULO        5,1
002700880104             10      LDA-MODULO         PIC X.
002800880204      *********  TYPE TRAITEMENT : (J)our (H)ebdo (M)ens (A)n (E)xcep
002900881229      *********                                  6,1
003000880204             10      LDA-FREQ           PIC X.
003100881229      *********  TYPE PRODUIT : FR=frais PG=PGC  7,2
003200880204             10      LDA-PRODUIT        PIC XX.
003300881229      *********  MOIS                            9,2
003400880222             10      LDA-MOIS.
003500880222              15     LDA-MOIS9          PIC 99.
003600881229      *********  SEMAINE                        11,2
003700880222             10      LDA-SEM.
003800880222              15     LDA-SEM9           PIC 99.
003900881229      *********  RENSEIGNEMENTS SOCIETE         13,8
004000881125             10      LDA-NOMSOC         PIC X(3).
004100881221                 88  LDA-COURNON      VALUE "COU".
004200881221                 88  LDA-TOURS        VALUE "TOU".
004300881221                 88  LDA-EMER         VALUE "EMR".
004400881221                 88  LDA-BLANQ        VALUE "BLQ".
004500881125             10      LDA-CNUD           PIC X(3).
004600881125             10      LDA-STE            PIC X(2).
004700881229      *********  RENSEIGNEMENTS CENTRE D'ACTIVITE  21,7
004800881125             10      LDA-CID            PIC X(5).
004900881125             10      LDA-NOENTR         PIC XX.
005000881229      *  EX    ANG=ANGOULEME                       28,3
005100881212             10      LDA-NOMENT         PIC X(3).
005200910828      *  FORMAT D'EDITION DU SLIM POUR BASCULER 6->10  ' '/'X'    31,1
005300890227             10      LDA-NEWSLIM        PIC X(1).
005400910312      *  NOM DU SITE (ORDINATEUR)         32,8         ' '/'X'
005500910312             10      LDA-ORDI           PIC X(8).
005600910827      *  TYPE DE LIVRAISON : LE OU LD     40,2         LE/LD
005700910827             10      LDA-LELD           PIC X(2).
005800910827      *  ENVIRONNEMENT PROMO  ?           42,3         '   '/'PRM'
005900910827             10      LDA-PROM           PIC X(3).
006000910916      *  TYPE D'INTERFACE                 45,3         '   '/'HAD'
006100910916             10      LDA-INTERFACE      PIC X(3).
006200920922      *  SITE ASSOCIE                     48,8
006300920922             10      LDA-SITE-ASSOCIE   PIC X(8).
006400940318      *  TRIGRAMME ENTREPOT               56,3
006500940318             10      LDA-TRIG           PIC X(3).
006600970408      *  ORIGINE CODIF POUR BDLF          59,2
006700970408             10      LDA-ORIG-BDLF      PIC X(2).
006800970408      *                                   61,40
006900970408             10      FILLER             PIC X(40).
007000881229      *********  JOB AYANT LANCE UN SUBMIT        101,26
007100881229             10      LDA-JOB            PIC X(10).
007200881229             10      LDA-USER           PIC X(10).
007300881229             10      LDA-NBR            PIC X(6).
007400890606      *********  AFFICHAGE MESSAGE INTERACTIF     127,1
007500890606      *********           SI 'N' PAS D'AFFICHAGE
007600890606             10      LDA-AFFICH-INTER   PIC X(1).
007700911112      *********  PARAMETRES TEMPORELS
007800911112      *                                           128,10
007900911112      *********  ANNEE
008000911112             10      LDA-DT-AN          PIC X(2).
008100911112      *********  MOIS
008200911112             10      LDA-DT-MOIS        PIC X(2).
008300911112      *********  SEMAINE
008400911112             10      LDA-DT-SEM         PIC X(2).
008500911112      *********  QUANTIEME
008600911112             10      LDA-DT-QQQ         PIC X(3).
008700911112      *********  JOUR DANS SEMAINE
008800911112             10      LDA-DT-J           PIC X(1).
008900961009      *********  DECODIF MULTISITE O = OUI N = NON  138,1
009000961009             10      LDA-MULTISITE      PIC X(1).
009100961009      *                                           139,374
009200961009             10      FILLER             PIC X(374).
009300870507      *
