000100051123     H
000200051123     H*------------------------------------------------------------------------
000300051123     H* Test string procedures
000400051123     H*------------------------------------------------------------------------
000500051123     D* Prototype for imported procedures
000600051123     D/COPY SMK25M1_P
000700051123     D/COPY SMK18M1_P
000800051123     D*
000900051123     D* Prototypes for internal procedures
001000051123     P*
001100051123     D Test_ToUpperLower...
001200051123     D                 Pr           100a
001300051123     D
001400051123     D                                1A   Value
001500051123     D                              100A   Value
001600051123     D*--------
001700051123     D* Global variable
001800051123     D* Parameters
001900051123     D e_Action        s              1a
002000051123     D e_Str1          s            100a
002100051123     D e_Str2          s            100a
002200051123     D e_RetNbr        s             10i 0
002300051123     D e_RetInd        s              1N
002400051123     D*  WStr (not used)
002500051123     D WStr            s            200a
002600051123     D*--------
002700051123     D*
002800051123     C*
002900051123     C*
003000051123     C     *ENTRY        PLIST
003100051123     C                   Parm                    e_Action                        L/U /  T /S
003200051123     C                   Parm                    e_Str1
003300051123     C                   Parm                    e_Str2
003400051123     C                   Parm                    e_RetNbr
003500051123     C                   Parm                    e_RetInd
003600051123     C*
003700051123     C                   Eval      e_RetNbr = 0
003800051123     C                   Eval      e_Retind = '0'
003900051123     C*
004000051123     C                   Select
004100051123     C*
004200051123     C*-- 'L' or 'U' --> Test of Proc. ToLower or ToUpper
004300051123     C                   When      e_Action = 'L' or e_Action = 'U'
004400051123     C                   Eval      e_Str2 = Test_ToUpperLower(
004500051123     C                             e_Action :
004600051123     C                             e_Str1)
004700051123     C*
004800051123     C*-- 'T' --> Test of the case of Str1
004900051123     C                   When      e_Action = 'T'
005000051123     C                   Exsr      SrTestTest
005100051123     C*
005200051123     C*-- 'S' --> Test of Str_ScanNonSensitive
005300051123     C                   When      e_Action = 'S'
005400051123     C                   Eval      e_RetInd =
005500051123     C                             Str_ScanNonSensitive(
005600051123     C                             e_Str1:
005700051123     C                             e_Str2:
005800051123     C                             %Len(%Trim(e_Str2)):
005900051123     C                             e_RetNbr)
006000051123     C                   Endsl
006100051123     C*
006200051123     C                   Eval      *INLR = '1'
006300051123     C                   Return
006400051123     C*---------------------------------------
006500051123     C*  Test the case of the string
006600051123     C     SrTestTest    Begsr
006700051123     C                   Select
006800051123     C                   When      Str_isUpper(e_Str1) = '1'
006900051123     C                   Eval      e_Str2 = 'All is UpperCase'
007000051123     C                   When      Str_isLower(e_Str1)
007100051123     C                   Eval      e_Str2 = 'All is LowerCase'
007200051123     C                   Other
007300051123     C                   Eval      e_Str2 = 'The string is in Mixed Case'
007400051123     C                   Endsl
007500051123     C                   Endsr
007600051123     C*---------------------------------------
007700051123     C**************************************************
007800051123     C* Test of Proc. Str_ToLower or Str_ToUpper
007900051123     C**************************************************
008000051123     P Test_ToUpperLower...
008100051123     P                 B
008200051123     D Test_ToUpperLower...
008300051123     D                 Pi           100a
008400051123     D e_Act                          1a   Value                                 'U'/'L'
008500051123     D e_Str                        100a   Value
008600051123     D*--------
008700051123     D* Local variable
008800051123     D WStr            s            100a
008900051123     D*--------
009000051123     D*
009100051123     C*
009200051123     C                   if        e_Act = 'U'
009300051123     C                   Exsr      SrTestUpper
009400051123     C                   return    WStr
009500051123     C                   else
009600051123     C                   return    Str_ToLower(e_Str)
009700051123     C                   endif
009800051123     C*---------------------------------------
009900051123     C*  Test the case of the string
010000051123     C     SrTestUpper   Begsr
010100051123     C                   Eval      WStr = Str_ToUpper(e_Str)
010200051123     C                   Endsr
010300051123     C*---------------------------------------
010400051123     P Test_ToUpperLower...
010500051123     P                 E
