000100051123     H*------------------------------------------------------------------------
000200051123     H* Procedures for UpperCase/LowerCase Strings
000300051123     H*------------------------------------------------------------------------
000400051123     H NoMain
000500051123     D* Prototype for exported procedures
000600051123     D/COPY SMK25M1_P
000700051123     D*
000800051123     D Lower           C                   CONST('abcdefghijklmnopqrst-
000900051123     D                                     uvwxyz')
001000051123     D Upper           C                   CONST('ABCDEFGHIJKLMNOPQRST-
001100051123     D                                     UVWXYZ')
001200051123     P*------------------------------------------------------------------------
001300051123     P* Str_ToUpper : Convert a string to Uppercase
001400051123     P*     (max length = 100 char)
001500051123     P*------------------------------------------------------------------------
001600051123     P Str_ToUpper     B                   Export
001700051123     P*
001800051123     D Str_ToUpper     Pi           100A
001900051123     D e_String                     100a   Const
002000051123     D*--------
002100051123     D wString         s            100a
002200051123     D*
002300051123     C*
002400051123     C     Lower:Upper   Xlate     e_String      wString
002500051123     C*
002600051123     C                   Return    wString
002700051123     P Str_ToUpper     E
002800051123     P*------------------------------------------------------------------------
002900051123     P*------------------------------------------------------------------------
003000051123     P* Str_ToLower : Convert a string to Uppercase
003100051123     P*     (max length = 100 char)
003200051123     P*------------------------------------------------------------------------
003300051123     P Str_ToLower     B                   Export
003400051123     P*
003500051123     D Str_ToLower     Pi           100A
003600051123     D e_String                     100a   Const
003700051123     D*--------
003800051123     D wString         s            100a
003900051123     D*
004000051123     C*
004100051123     C     Upper:Lower   Xlate     e_String      wString
004200051123     C*
004300051123     C                   Return    wString
004400051123     P Str_ToLower     E
004500051123
004600051123     P*------------------------------------------------------------------------
004700051123     P* Str_isUpper : Check whether a String is only in UpperCase
004800051123     P*------------------------------------------------------------------------
004900051123     P Str_isUpper     B                   Export
005000051123     P*
005100051123     D Str_isUpper     Pi             1N
005200051123     D e_String                     100a   Const
005300051123     D*--------
005400051123     D*
005500051123     C* Test if the string does not change when it is converted to Upper
005600051123     C                   if        e_String = Str_ToUpper(e_String)
005700051123     C                   return    *On
005800051123     C                   else
005900051123     C                   return    *Off
006000051123     C                   endif
006100051123     C*
006200051123     P Str_isUpper     E
006300051123     P*------------------------------------------------------------------------
006400051123     P* Str_isLower : Check whether a String is only in UpperCase
006500051123     P*------------------------------------------------------------------------
006600051123     P Str_isLower     B                   Export
006700051123     P*
006800051123     D Str_isLower     Pi             1N
006900051123     D e_String                     100a   Const
007000051123     D*--------
007100051123     D*
007200051123     C* Test if the string does not change when it is converted to Upper
007300051123     C                   if        e_String = Str_ToLower(e_String)
007400051123     C                   return    *On
007500051123     C                   else
007600051123     C                   return    *Off
007700051123     C                   endif
007800051123     C*
007900051123     P Str_isLower     E
008000051123     P*------------------------------------------------------------------------
