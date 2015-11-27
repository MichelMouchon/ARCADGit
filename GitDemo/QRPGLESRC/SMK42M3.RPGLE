000100051123     H
000200051123     H*------------------------------------------------------------------------
000300051123     H* Test procedures for 3 Pck
000400051123     H*------------------------------------------------------------------------
000500051123     D* Prototype for this module
000600051123     D/COPY SMK42M3_P
000700051123     D* Prototype for called procedures
000800051123     D/COPY SMK21M2_P
000900051123     D*
001000051123     D* Parameters interface for this module
001100051123     D SMK42M3         Pi
001200051123     D* 1=Min, 2=Max
001300051123     D e_Action                       1a
001400051123     D e_Pck1                        30p 9
001500051123     D e_Pck2                        30p 9
001600051123     D e_Pck3                        30p 9
001700051123     D e_PckRet                      30p 9
001800051123     D*--------
001900051123     D*
002000051123     C*
002100051123     C                   Select
002200051123     C*
002300051123     C*-- Min
002400051123     C                   When      e_Action = '1'
002500051123     C                   Eval      e_PckRet = Get_PckMin(
002600051123     C                             e_Pck1:e_Pck2:e_Pck3)
002700051123     C*-- Max
002800051123     C                   When      e_Action = '2'
002900051123     C                   Eval      e_PckRet = Get_PckMax(
003000051123     C                             e_Pck1:e_Pck2:e_Pck3)
003100051123     C*
003200051123     C                   Endsl
003300051123     C*
003400051123     C                   Eval      *INLR = '1'
003500051123     C                   Return
003600051123     C*---------------------------------------
