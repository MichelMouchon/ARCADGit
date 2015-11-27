000100051123      *------------------------------------------------------------------------
000200051123      * Procedures to handle  "int" values
000300051123      *------------------------------------------------------------------------
000400051123     H NoMain
000500051123     D* Prototype for exported procedures
000600051123     D/COPY SMK21M1_P
000700051123     P*------------------------------------------------------------------------
000800051123     P* Get_IntMin : get the minimum value from 2,3 or 4 int
000900051123     P*
001000051123     P*------------------------------------------------------------------------
001100051123     P Get_IntMin      B                   Export
001200051123     P*
001300051123     D Get_IntMin      Pi            10i 0
001400051123     D e_Int1                        10i 0 Value
001500051123     D e_Int2                        10i 0 Value
001600051123     D e_Int3                        10i 0 Value
001700051123     D                                     Options(*Nopass)
001800051123     D e_Int4                        10i 0 Value
001900051123     D                                     Options(*Nopass)
002000051123
002100051123     D*--------
002200051123     D wInt            s             10i 0
002300051123     D*
002400051123     C*
002500051123     C                   Eval      wInt = e_Int1
002600051123     C*
002700051123     C                   if        e_Int2 < wInt
002800051123     C                   eval      wInt = e_Int2
002900051123     C                   endif
003000051123     C*
003100051123     C                   if        %Parms >= 3
003200051123     C                             and e_Int3 < wInt
003300051123     C                   eval      wInt = e_Int3
003400051123     C                   endif
003500051123     C*
003600051123     C                   if        %Parms >= 4
003700051123     C                             and e_Int4 < wInt
003800051123     C                   eval      wInt = e_Int4
003900051123     C                   endif
004000051123     C*
004100051123     C                   return    WInt
004200051123     P Get_IntMin      E
004300051123     P*------------------------------------------------------------------------
004400051123     P* Get_IntMax : get the maximum value from 2,3 or 4 int
004500051123     P*------------------------------------------------------------------------
004600051123     P Get_IntMax      B                   Export
004700051123     P*
004800051123     D Get_IntMax      Pi            10i 0
004900051123     D e_Int1                        10i 0 Value
005000051123     D e_Int2                        10i 0 Value
005100051123     D e_Int3                        10i 0 Value
005200051123     D                                     Options(*Nopass)
005300051123     D e_Int4                        10i 0 Value
005400051123     D                                     Options(*Nopass)
005500051123
005600051123     D*--------
005700051123     D wInt            s             10i 0
005800051123     D*
005900051123     C*
006000051123     C                   Eval      wInt = e_Int1
006100051123     C*
006200051123     C                   if        e_Int2 > wInt
006300051123     C                   eval      wInt = e_Int2
006400051123     C                   endif
006500051123     C*
006600051123     C                   if        %Parms >= 3
006700051123     C                             and e_Int3 > wInt
006800051123     C                   eval      wInt = e_Int3
006900051123     C                   endif
007000051123     C*
007100051123     C                   if        %Parms >= 4
007200051123     C                             and e_Int4 > wInt
007300051123     C                   eval      wInt = e_Int4
007400051123     C                   endif
007500051123     C*
007600051123     C                   return    WInt
007700051123     P Get_IntMax      E
007800051123
007900051123     P*------------------------------------------------------------------------
008000051123     P* Anz_IntTab : Analyze a table of int values
008100051123     P*  and return the minimal value and the average value
008200051123     P*
008300051123     P*------------------------------------------------------------------------
008400051123     P Anz_IntTab      B                   Export
008500051123     P*
008600051123     D Anz_IntTab      Pi
008700051123     D* in : Pointer to the address of a table of int :
008800051123     D e_pIntTab                       *   Value
008900051123     D* in : Number of element in the table :
009000051123     D e_nbElt                        5i 0 Value
009100051123     D* out : Return the minimum value :
009200051123     D e_Min                         10i 0
009300051123     D* out : Return the average with 2 decimals
009400051123     D e_Average                     12p 2
009500051123     D*--------
009600051123     D* Table based on the address of input table of int
009700051123     D wIntTab         s             10i 0 Dim(5000) Based(e_pIntTab)
009800051123     D*
009900051123     D Ix              s             10i 0
010000051123     D wSum            s             10i 0
010100051123     D wSum2           s             12p 2
010200051123     D*
010300051123     C*--------------
010400051123     C* Calculate the minimum value
010500051123     C*--------------
010600051123     C*     using Get_IntMin (funny method, just for the sample !)
010700051123     C*
010800051123     C                   Eval      Ix=1
010900051123     C                   Eval      e_Min=*hival
011000051123     C*
011100051123     C                   Dow       Ix <= e_NbElt
011200051123     C*
011300051123     C                   Select
011400051123     C*
011500051123     C                   When      Ix + 2 <= e_NbElt
011600051123     C                   Eval      e_Min=Get_IntMin(
011700051123     C                             e_Min:
011800051123     C                             wIntTab(Ix):
011900051123     C                             wIntTab(Ix+1):
012000051123     C                             wIntTab(Ix+2)  )
012100051123     C*
012200051123     C                   When      Ix + 1 = e_NbElt
012300051123     C                   Eval      e_Min=Get_IntMin(
012400051123     C                             e_Min:
012500051123     C                             wIntTab(Ix):
012600051123     C                             wIntTab(Ix+1) )
012700051123     C*
012800051123     C                   When      Ix  = e_NbElt
012900051123     C                   Eval      e_Min=Get_IntMin(e_Min:wIntTab(Ix))
013000051123     C                   Endsl
013100051123     C
013200051123     C                   Eval      Ix = Ix + 3
013300051123     C                   Enddo
013400051123     C*--------------
013500051123     C* Calculate the average
013600051123     C*--------------
013700051123     C*
013800051123     C                   Eval      WSum = 0
013900051123     C*
014000051123     C                   for       Ix = 1 to e_NbElt
014100051123     C                   Eval      WSum = WSum + wIntTab(Ix)
014200051123     C                   endfor
014300051123     C*
014400051123     C                   Eval      wSum2 = wSum
014500051123     C                   Eval(h)   e_Average = wSum2 / e_NbElt
014600051123     C* Exit
014700051123     C                   return
014800051123     P Anz_IntTab      E
014900051123
015000051123
