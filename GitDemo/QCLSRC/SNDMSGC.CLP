000100990107/********************************************************************/
000200990107/*     Title         : Send message to program message queue.       */
000300990107/*     System        : HSV Control & Tracking                       */
000400000727/*     Author        : Tim Jefford                                  */
000500990107/*     Date          : January 1999                                 */
000600990107/********************************************************************/
000700990107             PGM        PARM(&PGMID &TOPGMQ &MSGID &MSGF &MSGDTA +
000800990107                          &MSGTYPE)
000900990107
001000990107             DCL        VAR(&PGMID) TYPE(*CHAR) LEN(10)
001100990107             DCL        VAR(&TOPGMQ) TYPE(*CHAR) LEN(5)
001200990107             DCL        VAR(&MSGID) TYPE(*CHAR) LEN(7)
001300990107             DCL        VAR(&MSGF) TYPE(*CHAR) LEN(10)
001400990107             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(132)
001500990107             DCL        VAR(&MSGTYPE) TYPE(*CHAR) LEN(7)
001600990107
001700990107             SNDPGMMSG  MSGID(&MSGID) MSGF(*LIBL/&MSGF) +
001800990107                          MSGDTA(&MSGDTA) TOPGMQ(&TOPGMQ) +
001900990107                          MSGTYPE(&MSGTYPE)
002000990107
002100990107             ENDPGM
