000100000527      /COPY MOD002_P
000200000724      /COPY MOD004_P
000300000527     DValeur           S             15P 5
000400000527     D V1              S             15P 5
000500000527     D V2              S             15P 5
000600000724     D V3              S             15P 5
000700000527     C                   eval      V1 = 15
000800000527     C                   eval      V2 = 45
000900000527     C                   eval      Valeur = addition(V1:V2)
001000000527     C     Valeur        DSPLY
001100000724     C                   eval      V1 = 15
001200000724     C                   eval      V2 = 11
001300000724     C                   eval      Valeur = divide(V1:V2)
001400000724     C     Valeur        DSPLY
001500000724     C                   eval      Valeur = divide(V1:V2:V3)
001600000724     C     Valeur        DSPLY
001700000527     C                   Move      '1'           *INLR
