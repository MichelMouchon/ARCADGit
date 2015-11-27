000100051123     H NoMain
000200051123     D* Prototype for exported procedures
000300051123     D/COPY SMK29M1_P
000400051123     P*------------------------------------------------------------------------
000500051123     P* Get_RandInt : get a random integer
000600051123     P*------------------------------------------------------------------------
000700051123     P Get_RandInt     B                   Export
000800051123     P*
000900051123     D Get_RandInt     Pi            10i 0
001000051123     D  e_IntMax                     10i 0 Value
001100051123
001200051123     D*--------
001300051123
001400051123     D*  Prototype for IBM C procedures
001500051123     Drand             Pr            10I 0 ExtProc('rand')
001600051123     D
001700051123     Dsrand            Pr                  ExtProc('srand')
001800051123     D                               10I 0  Value
001900051123     D*-------
002000051123     D IntRes          S             10I 0
002100051123     D*
002200051123     D Timexx          DS
002300051123     D Time                            T
002400051123     D Time06          S              6S 0
002500051123     D Mvr1            S              6S 0
002600051123     D*
002700051123     D FstCall         S              1A    inz('0') Static
002800051123     D
002900051123     C*   Init random only at the first time
003000051123     C                   If        FstCall  = '0'
003100051123     C                   Eval      FstCall  = '1'
003200051123     C                   Time                    Time
003300051123     C                   Move      Time          Time06
003400051123     C                   Div       32768         Time06
003500051123     C                   Mvr                     Mvr1
003600051123     C                   Callp     srand(Mvr1)
003700051123     C                   Endif
003800051123     C*   get the next random value
003900051123     C                   Eval      IntRes = rand
004000051123     C* adjust to max
004100051123     C                   If        e_IntMax > 0
004200051123     C                   Eval      INTRes = (Intres * e_IntMax) / 32768 + 1
004300051123     C                   Endif
004400051123     C*
004500051123     C                   Return    IntRes
004600051123     P Get_RandInt     E
