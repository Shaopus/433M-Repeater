#ifndef YY_H
#define YY_H
#include "main.h"

#define MAX_NUM								100
#define MIN_NUM								3
enum
{
    WELCOM_WORD                 = 0x02, /* ??¨®-¨º1¨®??¡Â????¡ã2¡¤¨¤¡ê?¨¬¨ª?¨®?¡é¨¦?3y????¦Ì£¤?¡Â1|?¨¹?¨¹????¡ê?????WiFi3¡è¡ã¡ä1|?¨¹?¨¹ */
    WIFI_CFG                    = 0x03, /* ??¨º1¨®??¡Â????¡ã2¡¤¨¤?¨ª?¡ì??¨¨¨ª?t????WiFi */
    NODE_DEL                    = 0x04, /* ????¨°?¨¦?3y */
    NODE_NEAR_GW                = 0x05, /* ??????¨¦¨¨¡À????¨¹¨ª?1?¡ê?¨º??¡¥¡ä£¤¡¤¡é¨ª¨º3¨¦ */
    ADD                         = 0x06, /* ¨¬¨ª?¨® */
    DELETE                      = 0x07, /* ¨¦?3y */
    NODE_ADD                    = 0x08, /* ????¨°?¨¬¨ª?¨® */
    SEQUENCE                    = 0x09, /* D¨°¨¢Do? */
    MAGNETIC_SENSOR             = 0x0A, /* ??¡ä?¡ä??D?¡Â */
    REMOTE_CTRL                 = 0x0B, /* ¨°¡ê???¡Â */
    INFRARED_DETECTOR           = 0x0C, /* o¨¬¨ªa¨¬?2a?¡Â */
    SMOKE_DETECTOR              = 0x0D, /* ?¨¬?D¨¬?2a?¡Â */
    REPLACE_BETTERY             = 0x0E, /* ?¨¹??¦Ì?3? */
    ZERO                        = 0x0F, /* 0 */
    ONE                         = 0x10, /* 1 */
    TWO                         = 0x11, /* 2 */
    THREE                       = 0x12, /* 3 */
    FOUR                        = 0x13, /* 4 */
    FIVE                        = 0x14, /* 5 */
    SIX                         = 0x15, /* 6 */
    SEVEN                       = 0x16, /* 7 */
    EIGHT                       = 0x17, /* 8 */
    NINE                        = 0x18, /* 9 *///²¥·Å9ÓÐÆÆÒô
    OUT_MODE_START_ONE_MIN      = 0x19, /* ¨ªa3??¡ê¨º?1¡¤??¨®o¨®???¡¥ */
    NOT_CLOSED_WINDOW           = 0x1A, /* ¡ä¡ã?¡ì?¡ä1? */
    NIGHT_MODE                  = 0x1B, /* ¨°1¨ª¨ª?¡ê¨º????¡¥ */
    INHOME_MODE                 = 0x1C, /* 1?¡ã??¡ê¨º????¡¥ */
    SOS                         = 0x1D, /* ?e?¡¥ */
    SOMEBODY_INTO               = 0x1E, /* ¨®D¨¨?¡ä3¨¨? */
    EMERGENCY_CALL              = 0x1F, /* ???¡Ào??¨¨ */
    WINDOW_DETECTOR             = 0x20 /* ¡ä¡ã¡ä?¡ä??D?¡Â */
};

enum
{
	IDLE=0,
	S1,
	WT,
	BUSY
};
	
	
enum
{
	STOP = 0,
	START,
	RUNNING
};	

enum
{
	NOKEY=0,
	KEY1,
	LONGKEY
};

void yy_init(void);
void yy_start(u8 cnt,u8 * nr);

#endif