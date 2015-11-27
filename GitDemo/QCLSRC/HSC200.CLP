000100990202/********************************************************************/
000200990218/* Program     : HSC200                                             */
000300990218/* Purpose     : Sales Order Processing.                            */
000400990202/* System      : HSV - Voucher Tracking and Control                 */
000500990218/* Date        : February 1999                                      */
000600990202/********************************************************************/
000700990202
000800990223             PGM        PARM(&MODE &ORDER &TYPE &CUST)
000900990218             DCL        VAR(&MODE) TYPE(*CHAR) LEN(1)
001000990218             DCL        VAR(&ORDER) TYPE(*CHAR) LEN(8)
001100990223             DCL        VAR(&CUST) TYPE(*CHAR) LEN(3)
001200990223             DCL        VAR(&TYPE) TYPE(*CHAR) LEN(8)
001300990218             OVRDBF     FILE(ALTCUSTA) TOFILE(HSLCUSTA)
001400990226             CALL       PGM(HSR200) PARM(&MODE &ORDER &TYPE &CUST)
001500990218             DLTOVR     FILE(ALTCUSTA)
001600990218             ENDPGM
