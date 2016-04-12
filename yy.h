#ifndef YY_H
#define YY_H
#include "main.h"

#define MAX_NUM								100
#define MIN_NUM								3
enum
{
    WELCOM_WORD                 = 0x02, /* ??��-��1��??��????��2������?����?��?�騦?3y????�̣�?��1|?��?��????��?????WiFi3����1|?��?�� */
    WIFI_CFG                    = 0x03, /* ??��1��??��????��2����?��?��??����?t????WiFi */
    NODE_DEL                    = 0x04, /* ????��?��?3y */
    NODE_NEAR_GW                = 0x05, /* ??????������????����?1?��?��??���䣤���騪��3�� */
    ADD                         = 0x06, /* ����?�� */
    DELETE                      = 0x07, /* ��?3y */
    NODE_ADD                    = 0x08, /* ????��?����?�� */
    SEQUENCE                    = 0x09, /* D����Do? */
    MAGNETIC_SENSOR             = 0x0A, /* ??��?��??D?�� */
    REMOTE_CTRL                 = 0x0B, /* ����???�� */
    INFRARED_DETECTOR           = 0x0C, /* o����a��?2a?�� */
    SMOKE_DETECTOR              = 0x0D, /* ?��?D��?2a?�� */
    REPLACE_BETTERY             = 0x0E, /* ?��??��?3? */
    ZERO                        = 0x0F, /* 0 */
    ONE                         = 0x10, /* 1 */
    TWO                         = 0x11, /* 2 */
    THREE                       = 0x12, /* 3 */
    FOUR                        = 0x13, /* 4 */
    FIVE                        = 0x14, /* 5 */
    SIX                         = 0x15, /* 6 */
    SEVEN                       = 0x16, /* 7 */
    EIGHT                       = 0x17, /* 8 */
    NINE                        = 0x18, /* 9 *///����9������
    OUT_MODE_START_ONE_MIN      = 0x19, /* ��a3??�꨺?1��??��o��???�� */
    NOT_CLOSED_WINDOW           = 0x1A, /* ���?��?��1? */
    NIGHT_MODE                  = 0x1B, /* ��1����?�꨺????�� */
    INHOME_MODE                 = 0x1C, /* 1?��??�꨺????�� */
    SOS                         = 0x1D, /* ?e?�� */
    SOMEBODY_INTO               = 0x1E, /* ��D��?��3��? */
    EMERGENCY_CALL              = 0x1F, /* ???��o??�� */
    WINDOW_DETECTOR             = 0x20 /* ����?��??D?�� */
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