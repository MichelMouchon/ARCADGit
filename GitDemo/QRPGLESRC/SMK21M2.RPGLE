000100051123      *------------------------------------------------------------------------
000200051123      * Procedures to handle  "Pck" values
000300051123      *------------------------------------------------------------------------
000400051123     H NoMain
000500051123     D* Prototype for exported procedures
000600051123     D/COPY SMK21M2_P
000700051123     P*------------------------------------------------------------------------
000800051123     P* Get_PckMin : get the minimum value from 2,3 or 4 Pck
000900051123     P*
001000051123     P*------------------------------------------------------------------------
001100051123     P Get_PckMin      B                   Export
001200051123     P*
001300051123     D Get_PckMin      Pi            30p 9
001400051123     D e_Pck1                        30p 9 Value
001500051123     D e_Pck2                        30p 9 Value
001600051123     D e_Pck3                        30p 9 Value
001700051123     D                                     Options(*Nopass)
001800051123     D e_Pck4                        30p 9 Value
001900051123     D                                     Options(*Nopass)
002000051123
002100051123     D*--------
002200051123     D wPck            s             30p 9
002300051123     D*
002400051123     C*
002500051123     C                   Eval      wPck = e_Pck1
002600051123     C*
002700051123     C                   if        e_Pck2 < wPck
002800051123     C                   eval      wPck = e_Pck2
002900051123     C                   endif
003000051123     C*
003100051123     C                   if        %Parms >= 3
003200051123     C                             and e_Pck3 < wPck
003300051123     C                   eval      wPck = e_Pck3
003400051123     C                   endif
003500051123     C*
003600051123     C                   if        %Parms >= 4
003700051123     C                             and e_Pck4 < wPck
003800051123     C                   eval      wPck = e_Pck4
003900051123     C                   endif
004000051123     C*
004100051123     C                   return    WPck
004200051123     P Get_PckMin      E
004300051123     P*------------------------------------------------------------------------
004400051123     P* Get_PckMax : get the maximum value from 2,3 or 4 Pck
004500051123     P*------------------------------------------------------------------------
004600051123     P Get_PckMax      B                   Export
004700051123     P*
004800051123     D Get_PckMax      Pi            30p 9
004900051123     D e_Pck1                        30p 9 Value
005000051123     D e_Pck2                        30p 9 Value
005100051123     D e_Pck3                        30p 9 Value
005200051123     D                                     Options(*Nopass)
005300051123     D e_Pck4                        30p 9 Value
005400051123     D                                     Options(*Nopass)
005500051123
005600051123     D*--------
005700051123     D wPck            s             30p 9
005800051123     D*
005900051123     C*
006000051123     C                   Eval      wPck = e_Pck1
006100051123     C*
006200051123     C                   if        e_Pck2 > wPck
006300051123     C                   eval      wPck = e_Pck2
006400051123     C                   endif
006500051123     C*
006600051123     C                   if        %Parms >= 3
006700051123     C                             and e_Pck3 > wPck
006800051123     C                   eval      wPck = e_Pck3
006900051123     C                   endif
007000051123     C*  Here's an error on the next test !
007100051123     C                   if        %Parms >= 4
007200051123     C                             and e_Pck4 < wPck
007300051123     C                   eval      wPck = e_Pck4
007400051123     C                   endif
007500051123     C*
007600051123     C                   return    WPck
007700051123     P Get_PckMax      E
007800051123
