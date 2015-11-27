000100051123     H*------------------------------------------------------------------------
000200051123     H* Test Pck procedures en 15,5
000300051123     H*------------------------------------------------------------------------
000400051123     D* Parameters
000500051123     D e_Action        s              1a
000600051123     D e_PckNbr        s              5p 0
000700051123     D e_Pck1          s             15p 5
000800051123     D e_Pck2          s             15p 5
000900051123     D e_Pck3          s             15p 5
001000051123     D e_Pck4          s             15p 5
001100051123     D e_PckRet        s             15p 5
001200051123     D*--------
001300051123     D wPck1           s             30p 9
001400051123     D wPck2           s             30p 9
001500051123     D wPck3           s             30p 9
001600051123     D wPck4           s             30p 9
001700051123     D wPckRet         s             30p 9
001800051123     D*
001900051123     C*
002000051123     C     *ENTRY        PLIST
002100051123     C                   Parm                    e_Action                       1=Min: 2=Max
002200051123     C                   Parm                    e_PckNbr
002300051123     C                   Parm                    e_Pck1
002400051123     C                   Parm                    e_Pck2
002500051123     C                   Parm                    e_Pck3
002600051123     C                   Parm                    e_Pck4
002700051123     C                   Parm                    e_PckRet
002800051123     C*
002900051123     C                   Eval      wPck1 = e_Pck1
003000051123     C                   Eval      wPck2 = e_Pck2
003100051123     C                   Eval      wPck3 = e_Pck3
003200051123     C                   Eval      wPck4 = e_Pck4
003300051123     C*
003400051123     C                   Call      'SMK42G1'
003500051123     C                   Parm                    e_Action
003600051123     C                   Parm                    e_PckNbr
003700051123     C                   Parm                    wPck1
003800051123     C                   Parm                    wPck2
003900051123     C                   Parm                    wPck3
004000051123     C                   Parm                    wPck4
004100051123     C                   Parm                    wPckRet
004200051123     C*
004300051123     C                   Eval      e_PckRet = wPckRet
004400051123     C*
004500051123     C                   Eval      *INLR = '1'
004600051123     C                   Return
004700051123     C*---------------------------------------
