000100051123     H
000200051123     H*------------------------------------------------------------------------
000300051123     H* Test procedures for 2 int
000400051123     H*------------------------------------------------------------------------
000500051123     D* Prototype for called procedures
000600051123     D/COPY SMK21M1_P
000700051123     D
000800051123     D* Parameters
000900051123     D e_Int1          s             10i 0
001000051123     D e_Int2          s             10i 0
001100051125     D e_Int3          s             10i 0
001200051125     D e_Int4          s             10i 0
001300051125     D e_Int5          s             10i 0
001400051125     D e_Int6          s             10i 0
001500051125     D e_Min           s             10i 0
001600051125     D e_Avg           s             12p 2
001700051123     D*--------
001800051125     D wIntTab         s             10i 0       Dim(6)
001900051125     D*--------
002000051123     D*
002100051123     C*
002200051123     C     *ENTRY        PLIST
002300051123     C                   Parm                    e_Int1
002400051123     C                   Parm                    e_Int2
002500051125     C                   Parm                    e_Int3
002600051125     C                   Parm                    e_Int4
002700051125     C                   Parm                    e_Int5
002800051125     C                   Parm                    e_Int6
002900051125     C                   Parm                    e_Min
003000051125     C                   Parm                    e_Avg
003100051123     C*
003200051125     C                   Eval      wIntTab(1) = e_Int1
003300051125     C                   Eval      wIntTab(2) = e_Int2
003400051125     C                   Eval      wIntTab(3) = e_Int3
003500051125     C                   Eval      wIntTab(4) = e_Int4
003600051125     C                   Eval      wIntTab(5) = e_Int5
003700051125     C                   Eval      wIntTab(6) = e_Int6
003800051123     C*
003900051125     C                   Callp     Anz_IntTab(
004000051125     C                             %Addr(wIntTab) :
004100051125     C                             %Elem(wIntTab) :
004200051125     C                             e_Min :
004300051125     C                             e_Avg )
004400051123     C*
004500051123     C                   Eval      *INLR = '1'
004600051123     C                   Return
004700051123     C*---------------------------------------
