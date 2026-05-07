/************************************************************************/
/*																		*/
/*	oled.c	--	Graphics Driver Library for OLED Display				*/
/*																		*/
/************************************************************************/
/*	Author: 	Gene Apperson											*/
/*	Copyright 2011, Digilent Inc.										*/
/************************************************************************/
/*  Module Description: 												*/
/*																		*/
/*																		*/
/************************************************************************/
/*  Revision History:													*/
/*																		*/
/*	04/29/2011(GeneA): Created											*/
/*																		*/
/************************************************************************/


/* ------------------------------------------------------------ */
/*				Include File Definitions						*/
/* ------------------------------------------------------------ */

#include "PmodOLED.h"
#include "OledChar.h"
#include "OledGrph.h"

#include "platform_info.h"
#include "ervp_mmio_util.h"
#include "ervp_uart.h"
#include "ervp_user_gpio.h"
#include "ervp_printf.h"
#include "ervp_delay.h"
#include "ervp_multicore_synch.h"
#include "ervp_external_peri_group_memorymap.h"
#include "frvp_spi.h"

/* ------------------------------------------------------------ */
/*				Local Type Definitions							*/
/* ------------------------------------------------------------ */

#define SPI_FREQ_OF_OLED	10000000
#define SPI_MODE_OF_OLED	SPI_SCKMODE_3
#define SPI_INDEX         SPI_INDEX_FOR_USER 

static const SpiConfig oled_spi_config = {SPI_DIVSOR(SPI_FREQ_OF_OLED), SPI_MODE_OF_OLED, (1<<SPI_INDEX), SPI_CSMODE_OFF, (SPI_FMT_PROTO(SPI_PROTO_S) | SPI_FMT_ENDIAN(SPI_ENDIAN_MSB) | SPI_FMT_LEN(8)), 1};

/* ------------------------------------------------------------ */
/*				Global Variables								*/
/* ------------------------------------------------------------ */

extern unsigned char		rgbOledFont0[];
extern unsigned char		rgbOledFontUser[];
extern unsigned char		rgbFillPat[];

extern int		xchOledMax;
extern int		ychOledMax;

/* Coordinates of current pixel location on the display. The origin
** is at the upper left of the display. X increases to the right
** and y increases going down.
*/
int		xcoOledCur;
int		ycoOledCur;

unsigned char *	pbOledCur;			//address of byte corresponding to current location
int		bnOledCur;			//bit number of bit corresponding to current location
unsigned char	clrOledCur;			//drawing color to use
unsigned char *	pbOledPatCur;		//current fill pattern
int		fOledCharUpdate;

int		dxcoOledFontCur;
int		dycoOledFontCur;

unsigned char *	pbOledFontCur;
unsigned char *	pbOledFontUser;

/* ------------------------------------------------------------ */
/*				Local Variables									*/
/* ------------------------------------------------------------ */

/* This array is the offscreen frame buffer used for rendering.
** It isn't possible to read back frome the OLED display device,
** so display data is rendered into this offscreen buffer and then
** copied to the display.
*/
unsigned char	rgbOledBmp[cbOledDispMax];

/* ------------------------------------------------------------ */
/*				Forward Declarations							*/
/* ------------------------------------------------------------ */

void	OledHostInit();
void	OledDevInit();
void	OledDvrInit();
void	Spi2PutByte(unsigned char bVal);
void	OledPutBuffer(int cb, unsigned char * rgbTx);

static inline void OledReset()
{
	user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_RES, 1);
	user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_RES, 0);
	delay_ms(1);
	user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_RES, 1);
	delay_ms(1);
}

/* ------------------------------------------------------------ */
/*				Procedure Definitions							*/
/* ------------------------------------------------------------ */
/***	OledInit
**
**	Parameters:
**		none
**
**	Return Value:
**		none
**
**	Errors:
**		none
**
**	Description:
**		Initialize the OLED display subsystem.
*/

void
OledInit()
	{

	/* Init the PIC32 peripherals used to talk to the display.
	*/
	printf("OledHostInit\n");
	OledHostInit();

	/* Init the memory variables used to control access to the
	** display.
	*/
	printf("OledDvrInit\n");
	OledDvrInit();

	/* Init the OLED display hardware.
	*/
	printf("OledDevInit\n");
	OledDevInit();

	/* Clear the display.
	*/
	printf("OledClear\n");
	OledClear();

}

/* ------------------------------------------------------------ */
/***	OledHostInit
**
**	Parameters:
**		none
**
**	Return Value:
**		none
**
**	Errors:
**		none
**
**	Description:
**		Perform PIC32 device initialization to prepare for use
**		of the OLED display.
**		This is currently hard coded for the Cerebot 32MX4 and
**		SPI2. This needs to be generalized.
*/

void oled_bw_config_spi()
{
	spi_configure(&oled_spi_config);
}

void
OledHostInit()
{
	//unsigned int	tcfg;

	/* Initialize SPI port 0.
	*/
	oled_bw_config_spi();

	/* Make power control pins be outputs with the supplies off
	*/
	user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_VDD, 1);
	user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_VBAT, 1);
	//PORTSetBits(prtVddCtrl, bitVddCtrl);
	//PORTSetBits(prtVbatCtrl, bitVbatCtrl);
	//PORTSetPinsDigitalOut(prtVddCtrl, bitVddCtrl);		//VDD power control (1=off)
	//PORTSetPinsDigitalOut(prtVbatCtrl, bitVbatCtrl);	//VBAT power control (1=off)

	/* Make the Data/Command select, Reset, and SPI CS pins be outputs.
	*/
	user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_DC, OLED_DC_SEL_DATA);
	OledReset();
	//PORTSetBits(prtDataCmd, bitDataCmd);
	//PORTSetPinsDigitalOut(prtDataCmd, bitDataCmd);		//Data/Command# select
	//PORTSetBits(prtReset, bitReset);
	//PORTSetPinsDigitalOut(prtReset, bitReset);
	//PORTSetBits(prtSelect, bitSelect);				// spi CS pin
	//PORTSetPinsDigitalOut(prtSelect, bitSelect);

}

/* ------------------------------------------------------------ */
/***	OledDvrInit
**
**	Parameters:
**		none
**
**	Return Value:
**		none
**
**	Errors:
**		none
**
**	Description:
**		Initialize the OLED software system
*/

void
OledDvrInit()
	{
	int		ib;

	/* Init the parameters for the default font
	*/
	dxcoOledFontCur = cbOledChar;
	dycoOledFontCur = 8;
	pbOledFontCur = rgbOledFont0;
	pbOledFontUser = rgbOledFontUser;

	for (ib = 0; ib < cbOledFontUser; ib++) {
		rgbOledFontUser[ib] = 0;
	}

	xchOledMax = ccolOledMax / dxcoOledFontCur;
	ychOledMax = crowOledMax / dycoOledFontCur;

	/* Set the default character cursor position.
	*/
	OledSetCursor(0, 0);

	/* Set the default foreground draw color and fill pattern
	*/
	clrOledCur = 0x01;
	pbOledPatCur = rgbFillPat;
	OledSetDrawMode(modOledSet);

	/* Default the character routines to automaticall
	** update the display.
	*/
	fOledCharUpdate = 1;

}

/* ------------------------------------------------------------ */
/***	OledDevInit
**
**	Parameters:
**		none
**
**	Return Value:
**		none
**
**	Errors:
**		none
**
**	Description:
**		Initialize the OLED display controller and turn the display on.
*/

void
OledDevInit()
	{

	/* We're going to be sending commands, so clear the Data/Cmd bit
	*/
	user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_DC, OLED_DC_SEL_COMMAND);
	//PORTClearBits(prtDataCmd, bitDataCmd);

	/* Start by turning VDD on and wait a while for the power to come up.
	*/
	user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_VDD, 0);
	//PORTClearBits(prtVddCtrl, bitVddCtrl);
	delay_ms(1); //DelayMs(1);

	/* Display off command
	*/
	Spi2PutByte(0xAE);

	/* Bring Reset low and then high
	*/
	OledReset();
	//PORTClearBits(prtReset, bitReset);
	//DelayMs(1);
	//PORTSetBits(prtReset, bitReset);

	/* Send the Set Charge Pump and Set Pre-Charge Period commands
	*/
	Spi2PutByte(0x8D);
	Spi2PutByte(0x14);

	Spi2PutByte(0xD9);
	Spi2PutByte(0xF1);

	/* Turn on VCC and wait 100ms
	*/
	user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_VBAT, 0);
	//PORTClearBits(prtVbatCtrl, bitVbatCtrl);
	delay_ms(100); //DelayMs(100);

	/* Set the dispaly contrast
	*/
	Spi2PutByte(0x81);
	Spi2PutByte(0x0F);

	/* Send the commands to invert the display.
	*/
	Spi2PutByte(0xA1);			//remap columns
	Spi2PutByte(0xC8);			//remap the rows

	/* Send the commands to select sequential COM configuration
	*/
	Spi2PutByte(0xDA);			//set COM configuration command
	Spi2PutByte(0x20);			//sequential COM, left/right remap enabled

	/* Send Display On command
	*/
	Spi2PutByte(0xAF);

}

/* ------------------------------------------------------------ */
/***	OledClear
**
**	Parameters:
**		none
**
**	Return Value:
**		none
**
**	Errors:
**		none
**
**	Description:
**		Clear the display. This clears the memory buffer and then
**		updates the display.
*/

void
OledClear()
	{

	OledClearBuffer();
	OledUpdate();

}

/* ------------------------------------------------------------ */
/***	OledClearBuffer
**
**	Parameters:
**		none
**
**	Return Value:
**		none
**
**	Errors:
**		none
**
**	Description:
**		Clear the display memory buffer.
*/

void
OledClearBuffer()
	{
	int			ib;
	unsigned char *		pb;

	pb = rgbOledBmp;

	/* Fill the memory buffer with 0.
	*/
	for (ib = 0; ib < cbOledDispMax; ib++) {
		*pb++ = 0x00;
	}

}

/* ------------------------------------------------------------ */
/***	OledUpdate
**
**	Parameters:
**		none
**
**	Return Value:
**		none
**
**	Errors:
**		none
**
**	Description:
**		Update the OLED display with the contents of the memory buffer
*/

void
OledUpdate()
	{
	int		ipag;
	//int		icol;
	unsigned char *	pb;

	pb = rgbOledBmp;

	for (ipag = 0; ipag < cpagOledMax; ipag++) {

		user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_DC, OLED_DC_SEL_COMMAND);
		//PORTClearBits(prtDataCmd, bitDataCmd);

		/* Set the page address
		*/
		Spi2PutByte(0x22);		//Set page command
		Spi2PutByte(ipag);		//page number

		/* Start at the left column
		*/
		Spi2PutByte(0x00 | 0x00);		//set low nybble of column
		Spi2PutByte(0x10 | 0x00);		//set high nybble of column

		user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_DC, OLED_DC_SEL_DATA);
		//PORTSetBits(prtDataCmd, bitDataCmd);

		/* Copy this memory page of display data.
		*/
		OledPutBuffer(ccolOledMax, pb);
		pb += ccolOledMax;

	}

}

/* ------------------------------------------------------------ */
/***	OledPutBuffer
**
**	Parameters:
**		cb		- number of bytes to send/receive
**		rgbTx	- pointer to the buffer to send
**
**	Return Value:
**		none
**
**	Errors:
**		none
**
**	Description:
**		Send the bytes specified in rgbTx to the slave and return
**		the bytes read from the slave in rgbRx
*/

void
OledPutBuffer(int cb, unsigned char * rgbTx)
{
	spi_start();
	spi_write(cb, rgbTx);
	spi_end();
}

/* ------------------------------------------------------------ */
/***	Spi2PutByte
**
**	Parameters:
**		bVal		- byte value to write
**
**	Return Value:
**		Returns 0
**
**	Errors:
**		none
**
**	Description:
**		Write/Read a byte on SPI port 2
*/

void
Spi2PutByte(unsigned char bVal)
{
	spi_start();
	spi_write(1, &bVal);
	spi_end();
}

/* ------------------------------------------------------------ */
/***	ProcName
**
**	Parameters:
**
**	Return Value:
**
**	Errors:
**
**	Description:
**
*/

/* ------------------------------------------------------------ */
/***	OledDevPowerOff
**
**	Parameters:
**		none
**
**	Return Value:
**		none
**
**	Errors:
**		none
**
**	Description:
**		Initialize the OLED display controller and turn the display on.
*/

void
OledDevPowerOff()
	{
	/* We're going to be sending commands, so clear the Data/Cmd bit
	*/
	user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_DC, OLED_DC_SEL_COMMAND);

	/* Display off command
	*/
	Spi2PutByte(0xAE);

	/* Bring Reset low and then high
	*/
	OledReset();

	/* Power/Turn off VBAT/VCC and wait 100ms
	*/
	user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_VBAT, 1);
	delay_ms(100); //DelayMs(100);

  /* Power off VDD
  */
	user_gpio_set_output(GPIO_INDEX_FOR_OLED_BW_VDD, 1);

}

/* ------------------------------------------------------------ */

//#include <stdint.h>
#include "ervp_memory_util.h"

// Function to reverse the bits within a single byte (e.g., 0b00010010 -> 0b01001000)
unsigned char reverseByte(unsigned char b) {
    unsigned char r = 0;
    for (int i = 0; i < 8; i++) {
        r <<= 1;
        r |= (b & 1);
        b >>= 1;
    }
    return r;
}

// Function to reverse the entire display buffer at the bit level
void reverseBitsInEntireBuffer() {
    unsigned char reversedBmp[cbOledDispMax] = {0};

    for (int i = 0; i < cbOledDispMax * 8; i++) {
        // i: original bit position (0 to 4095)
        // rev_i: reversed bit position
        int rev_i = cbOledDispMax * 8 - 1 - i;

        // Read the bit value at position i
        int byte_idx = i / 8;
        int bit_idx = i % 8;
        int bit_val = (rgbOledBmp[byte_idx] >> bit_idx) & 1;

        // Write the bit to its reversed position
        int rev_byte_idx = rev_i / 8;
        int rev_bit_idx = rev_i % 8;
        reversedBmp[rev_byte_idx] |= (bit_val << rev_bit_idx);
    }

    // Copy the reversed buffer back to the original buffer
    memcpy(rgbOledBmp, reversedBmp, cbOledDispMax);
}

/************************************************************************/

