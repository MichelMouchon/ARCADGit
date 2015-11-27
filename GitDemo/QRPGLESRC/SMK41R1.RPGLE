000100051123     H*------------------------------------------------------------------------
000200051123     H* Test int procedures
000300051123     H*------------------------------------------------------------------------
000400051123     D* Prototype for called module and program
000500051123     D/COPY SMK41M3_P
000600051123     D/COPY SMK41R4_P
000700051123     D* Parameters
000800051123     D e_Action        s              1a
000900051123     D e_IntNbr        s              5i 0
001000051123     D e_Int1          s             10i 0
001100051123     D e_Int2          s             10i 0
001200051123     D e_Int3          s             10i 0
001300051123     D e_Int4          s             10i 0
001400051123     D e_IntRet        s             10i 0
001500051123     D*--------
001600051123     D*
001700051123     C*
001800051123     C     *ENTRY        PLIST
001900051123     C                   Parm                    e_Action                       1=Min: 2=Max
002000051123     C                   Parm                    e_IntNbr
002100051123     C                   Parm                    e_Int1
002200051123     C                   Parm                    e_Int2
002300051123     C                   Parm                    e_Int3
002400051123     C                   Parm                    e_Int4
002500051123     C                   Parm                    e_IntRet
002600051123     C*
002700051123     C                   Eval      e_IntRet = 0
002800051123     C*
002900051123     C                   Select
003000051123     C*
003100051123     C*-- Test with 2 int
003200051123     C                   When      e_IntNbr = 2
003300051123     C                   CallB     'SMK41M2'
003400051123     C                   Parm                    e_Action
003500051123     C                   Parm                    e_Int1
003600051123     C                   Parm                    e_Int2
003700051123     C                   Parm                    e_IntRet
003800051123     C*
003900051123     C*-- Test with 3 int
004000051123     C                   When      e_IntNbr = 3
004100051123     C                   Callp     MOD_SMK41M3(e_Action:
004200051123     C                             e_Int1:e_Int2:e_Int3:e_IntRet)
004300051123     C*
004400051123     C*-- Test with 4 int
004500051123     C                   When      e_IntNbr = 4
004600051123     C                   Callp     PGM_SMK41R4(e_Action:
004700051123     C                             e_Int1:e_Int2:e_Int3:e_Int4:e_IntRet)
004800051123     C*
004900051123     C                   Endsl
005000051123     C*
005100051123     C                   Eval      *INLR = '1'
005200051123     C                   Return
005300051123     C*---------------------------------------
