000100051123      *------------------------------------------------------------------------
000200051123      * Protototype of Procedures to handle  "int" values
000300051123      *------------------------------------------------------------------------
000400051123     D*------------------------------------------------------------------------
000500051123     D* Get_IntMin : get the minimum value from 2,3 or 4 int
000600051123     D*
000700051123     D*------------------------------------------------------------------------
000800051123     D Get_IntMin      Pr            10i 0
000900051123     D e_Int1                        10i 0 Value
001000051123     D e_Int2                        10i 0 Value
001100051123     D e_Int3                        10i 0 Value
001200051123     D                                     Options(*Nopass)
001300051123     D e_Int4                        10i 0 Value
001400051123     D                                     Options(*Nopass)
001500051123     D*------------------------------------------------------------------------
001600051123     D* Get_IntMax : get the maximum value from 2,3 or 4 int
001700051123     D*------------------------------------------------------------------------
001800051123     D Get_IntMax      Pr            10i 0
001900051123     D e_Int1                        10i 0 Value
002000051123     D e_Int2                        10i 0 Value
002100051123     D e_Int3                        10i 0 Value
002200051123     D                                     Options(*Nopass)
002300051123     D e_Int4                        10i 0 Value
002400051123     D                                     Options(*Nopass)
002500051123     D*------------------------------------------------------------------------
002600051123     D* Anz_IntTab : Analyze a table of int values
002700051123     D*  and return the minimal value and the average value
002800051123     D*
002900051123     D*------------------------------------------------------------------------
003000051123     D Anz_IntTab      Pr
003100051123     D* in : Pointer to the address of a table of int :
003200051123     D e_pIntTab                       *   Value
003300051123     D* in : Number of element in the table :
003400051123     D e_nbElt                        5i 0 Value
003500051123     D* out : Return the minimum value :
003600051123     D e_Min                         10i 0
003700051123     D* out : Return the average with 2 decimals
003800051123     D e_Average                     12p 2
003900051123     D*--------
