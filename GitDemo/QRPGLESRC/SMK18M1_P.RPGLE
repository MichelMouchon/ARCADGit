000100051123      *------------------------------------------------------------------------
000200051123      * Prototype for Procedures for scan in Strings
000300051123      *------------------------------------------------------------------------
000400051123     D*------------------------------------------------------------------------
000500051123     D* Str_ScanNonSensitive : Non sensitive scan for a string in another string
000600051123     D*  Return Value : '0' = not Found, '1'=Found
000700051123     D* Param. 1 : String in which to scan
000800051123     D* Param. 2 : String to scan for
000900051123     D* Param. 3 : length of string to scan for
001000051123     D* Param. 4 (Omissible) : If found : return the first position of the
001100051123     D*                            string
001200051123     D*------------------------------------------------------------------------
001300051123     P*
001400051123     D Str_ScanNonSensitive...
001500051123     D                 Pr             1N
001600051123     D e_String1                    100a   Const
001700051123     D e_String2                    100a   Const
001800051123     D e_String2Len                  10i 0 Const
001900051123     D e_FirstPosit                  10i 0 Options(*Omit)
002000051123     D*--------
002100051123
