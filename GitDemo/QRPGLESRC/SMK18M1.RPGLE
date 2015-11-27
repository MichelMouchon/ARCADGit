000100051123      *------------------------------------------------------------------------
000200051123      * Procedures for scan in Strings
000300051123      *------------------------------------------------------------------------
000400051123     H NoMain
000500051123     D* Prototype for exported procedures
000600051123     D/COPY SMK18M1_P
000700051123     D* Prototype for imported procedures
000800051123     D/COPY SMK25M1_P
000900051123     D*
001000051123     H*------------------------------------------------------------------------
001100051123     H* Str_ScanNonSensitive : Non sensitive scan for a string in another string
001200051123     H*  Return Value : '0' = not Found, '1'=Found
001300051123     H* Param. 1 : String in which to scan
001400051123     H* Param. 2 : String to scan for
001500051123     H* Param. 3 : length of string to scan for
001600051123     H* Param. 4 (Omissible) : If found : return the first position of the
001700051123     H*                            string
001800051123     H*------------------------------------------------------------------------
001900051123     P Str_ScanNonSensitive...
002000051123     P                 B                   Export
002100051123     P*
002200051123     D Str_ScanNonSensitive...
002300051123     D                 Pi             1N
002400051123     D e_String1                    100a   Const
002500051123     D e_String2                    100a   Const
002600051123     D e_String2Len                  10i 0 Const
002700051123     D e_FirstPosit                  10i 0 Options(*Omit)
002800051123     D*--------
002900051123     D wString1        s            100a
003000051123     D wString2        s            100a
003100051123     D wLen            s             10i 0
003200051123     D wPos            s             10i 0
003300051123     D*
003400051123     C* Convert the two strings to Upper
003500051123     C                   Eval      wString1 = Str_ToUpper(e_String1)
003600051123     C                   Eval      wString2 = Str_ToUpper(e_String2)
003700051123     C* scan
003800051123     C                   Eval      WLen = e_String2Len
003900051123     C     wString2:wLen Scan      wString1      wPos
004000051123     C* found
004100051123     C                   if        %Found
004200051123     C                   if        %Addr(e_FirstPosit) <> *null
004300051123     C                   Eval      e_FirstPosit = wPos
004400051123     C                   Endif
004500051123     C                   Return    '1'
004600051123     C* not found
004700051123     C                   Else
004800051123     C                   if        %Addr(e_FirstPosit) <> *null
004900051123     C                   Eval      e_FirstPosit = 0
005000051123     C                   Endif
005100051123     C                   Return    '0'
005200051123     C                   Endif
005300051123     C*
005400051123     P Str_ScanNonSensitive...
005500051123     P                 E
