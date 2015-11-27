000100000527     HNOMAIN
000200000724      /COPY MOD004_P
000300000724     P Multiplica      B                   EXPORT
000400000724     D                 PI            20P 5
000500000527     DFacteur1                       15P 5
000600000527     DFacteur2                       15P 5
000700000527     D*
000800000724     C                   return    Facteur1 * Facteur2
000900000724     P                 E
001000000724     P Divide          B                   EXPORT
001100000724     D                 PI            20P 5
001200000724     DFacteur1                       15P 5
001300000724     DFacteur2                       15P 5
001400000724     DRemainder                      15P 5 OPTIONS(*NOPASS)
001500000724     D*
001600000724     DResultat         S             20P 5
001700000724     DRemaind          S             15P 5
001800000724     C     Facteur1      DIV       facteur2      Resultat
001900000724     C                   MVR                     Remaind
002000000724     C                   if        %PARMS > 2
002100000724     C                   EVAL      Remainder = remaind
002200000724     C                   endif
002300000724     C                   return    Resultat
002400000724     P                 E
