000100990202/********************************************************************/
000200990202/* Program     : HSC731                                             */
000300990202/* Purpose     : Create OPNQRYF for Voucher Control file HSLVCTLA   */
000400990202/* System      : HSV - Voucher Tracking and Control                 */
000500990202/* Date        : January 1999                                       */
000600990202/********************************************************************/
000700151127             /* Git change 1 */
000800151127             /* git chnage 2 from base */
000900151127             /* Git change 1 in projet1 */
001000151127             /*         additionnal change */
001100151127             /* Git change 2 in Project1 */
001101151127             /* Git change 3 in Master */
001102160217             /* git change 4 */
001103160217
001200990202
001300000728             PGM        PARM(&XPROD &XPROD1 &XPGMID &XUSRID &XJOBNO)
001400000728             DCL        VAR(&XPROD) TYPE(*CHAR) LEN(13)
001500000728             DCL        VAR(&XPROD1) TYPE(*CHAR) LEN(13)
001600000728             DCL        VAR(&XPGMID) TYPE(*CHAR) LEN(10)
001700000728             DCL        VAR(&XUSRID) TYPE(*CHAR) LEN(10)
001800000728             DCL        VAR(&XJOBNO) TYPE(*CHAR) LEN(10)
001900990202             OVRDBF     FILE(HSLVCTLA) SHARE(*YES)
002000990202             OPNQRYF    FILE((HSLVCTLA)) QRYSLT('(''BPROD *GE ''" +
002100000728                          *CAT ''&XPROD1'' *CAT "'' '')') +
002200990202                          KEYFLD((BPROD)) SEQONLY(*NO) +
002300990202                          OPTIMIZE(*FIRSTIO 12)
002400990202   /*        OPNQRYF    FILE((HSLVCTLA)) QRYSLT('BPROD = %RANGE(' || + */
002500990202 /*              "'&£PROD'" |> "'&£PROD1'" || ')') KEYFLD((BPROD)) +   */
002600990202 /*                       SEQONLY(*NO) OPTIMIZE(*FIRSTIO 12)           */
002700990202             CPYFRMQRYF FROMOPNID(HSLVCTLA) TOFILE(*PRINT)
002800000728             CALL       PGM(HSR735) PARM(&XPROD &XPROD1 &XPGMID +
002900000728                          &XUSRID &XJOBNO)
003000990202             DLTOVR     FILE(HSLVCTLA)
003100990202             CLOF       OPNID(HSLVCTLA)
003200990202                          ENDPGM
