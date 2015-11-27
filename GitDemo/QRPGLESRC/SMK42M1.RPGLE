000100051123     H*------------------------------------------------------------------------
000200051123     H* Test Pck procedures
000300051123     H*------------------------------------------------------------------------
000400051123     D* Prototype for called module and program
000500051123     D/COPY SMK42M3_P
000600051123     D/COPY SMK42R4_P
000700051123     D* Parameters
000800051123     D e_Action        s              1a
000900051123     D e_PckNbr        s              5p 0
001000051123     D e_Pck1          s             30p 9
001100051123     D e_Pck2          s             30p 9
001200051123     D e_Pck3          s             30p 9
001300051123     D e_Pck4          s             30p 9
001400051123     D e_PckRet        s             30p 9
001500051123     D*--------
001600051123     D*
001700051123     C*
001800051123     C     *ENTRY        PLIST
001900051123     C                   Parm                    e_Action                       1=Min: 2=Max
002000051123     C                   Parm                    e_PckNbr
002100051123     C                   Parm                    e_Pck1
002200051123     C                   Parm                    e_Pck2
002300051123     C                   Parm                    e_Pck3
002400051123     C                   Parm                    e_Pck4
002500051123     C                   Parm                    e_PckRet
002600051123     C*
002700051123     C                   Eval      e_PckRet = 0
002800051123     C*
002900051123     C                   Select
003000051123     C*
003100051123     C*-- Test with 2 Pck
003200051123     C                   When      e_PckNbr = 2
003300051123     C                   CallB     'SMK42M2'
003400051123     C                   Parm                    e_Action
003500051123     C                   Parm                    e_Pck1
003600051123     C                   Parm                    e_Pck2
003700051123     C                   Parm                    e_PckRet
003800051123     C*
003900051123     C*-- Test with 3 Pck
004000051123     C                   When      e_PckNbr = 3
004100051123     C                   Callp     SMK42M3(e_Action:
004200051123     C                             e_Pck1:e_Pck2:e_Pck3:e_PckRet)
004300051123     C*
004400051123     C*-- Test with 4 Pck
004500051123     C                   When      e_PckNbr = 4
004600051123     C                   Callp     SMK42R4(e_Action:
004700051123     C                             e_Pck1:e_Pck2:e_Pck3:e_Pck4:e_PckRet)
004800051123     C*
004900051123     C                   Endsl
005000051123     C*
005100051123     C                   Eval      *INLR = '1'
005200051123     C                   Return
005300051123     C*---------------------------------------
