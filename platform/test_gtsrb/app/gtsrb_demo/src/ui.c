#include "platform_info.h"
#include "ervp_printf.h"
#include "ervp_uart.h"

#include "ervp_delay.h"
#include "ervp_user_gpio.h"
#include "ervp_interrupt.h"

#include "PmodOLED.h"
#include "OledChar.h"
#include "OledGrph.h"

#include "ui.h"

#define DISPLAY_OLEDBW
//#define DISPLAY_CLS

extern unsigned char rgbUserFont[];

int has_bnt_been_pressed = 0;

void btnc_isr(void)
{
  printf("\npushed btnc 0");
  has_bnt_been_pressed = 1;
  delay_ms(200);
}

void init_btnc()
{
  user_gpio_set_input_cfg(GPIO_INDEX_FOR_BTNC, 0);
  user_gpio_enable_interrupt(GPIO_INDEX_FOR_BTNC, ERVP_TRIGGER_COND_RISE, 0);
  register_isr_gpio(GPIO_INDEX_FOR_BTNC, btnc_isr, 1);

  register_plic_grant();
  allow_interrupt_plic();
  enable_interrupt();

}

int check_btnc()
{
  int result = 0;
  if(has_bnt_been_pressed)
  {
    result = 1;
    has_bnt_been_pressed = 0;
  }
  return result;
}

void wait_for_push_btnc()
{
  while(1)
  {
    if(has_bnt_been_pressed == 1)
    {
      has_bnt_been_pressed = 0;
      display_init();
#ifdef DISPLAY_OLEDBW
      OledDevPowerOff();
#endif
      break;
    }
    delay_ms(100);
  }
}

#define UART_ID_OF_CLS        (UART_INDEX_FOR_USER)
#define UART_RATE_OF_CLS      (9600)

void display_init()
{
#ifdef DISPLAY_CLS
  uart_config(UART_ID_OF_CLS, UART_RATE_OF_CLS);

  // Erase display
  uart_putc(UART_ID_OF_CLS, (char)27);  // ESC
  uart_puts(UART_ID_OF_CLS, "[j");

  // Display config: 2-line mode
  uart_putc(UART_ID_OF_CLS, (char)27);
  uart_puts(UART_ID_OF_CLS, "[0h");

  // Move cursor to row 1, column 5
  uart_putc(UART_ID_OF_CLS, (char)27);
  uart_puts(UART_ID_OF_CLS, "[0;0H");
  uart_puts(UART_ID_OF_CLS, "NPX GTSRB Demo");

  // Move cursor to row 2, column 1
  uart_putc(UART_ID_OF_CLS, (char)27);
  uart_puts(UART_ID_OF_CLS, "[1;0H");
  uart_puts(UART_ID_OF_CLS, "Capturing..");
#endif
}

void display_result(int class_id)
{
  char ch;
  char str[20];
  sprintf(str, "Class ID: %d", class_id);

#ifdef DISPLAY_OLEDBW
  printf("\nOledBwInit\n");
  OledInit();
  //OledClear();

  /* Define the user definable characters
  */
  for (ch = 0; ch < 0x18; ch++) {
    OledDefUserChar(ch, &rgbUserFont[ch*cbOledChar]);
  }

  OledClearBuffer();

  OledSetFillPattern(OledGetStdPattern(0));
  OledSetCharUpdate(0);

  OledClearBuffer();
  OledSetCursor(0, 0);
  OledPutString("NPX");
  OledSetCursor(0, 1);
  OledPutString("GTSRB Result");
  OledSetCursor(0, 2);
  OledPutString(str);

  reverseBitsInEntireBuffer();
  OledUpdate();

  delay_ms(100);
#endif

#ifdef DISPLAY_CLS
  uart_config(UART_ID_OF_CLS, UART_RATE_OF_CLS);

  // Erase display
  uart_putc(UART_ID_OF_CLS, (char)27);  // ESC
  uart_puts(UART_ID_OF_CLS, "[j");

  // Display config: 2-line mode
  uart_putc(UART_ID_OF_CLS, (char)27);
  uart_puts(UART_ID_OF_CLS, "[0h");

  // Move cursor to row 1, column 5
  uart_putc(UART_ID_OF_CLS, (char)27);
  uart_puts(UART_ID_OF_CLS, "[0;0H");
  uart_puts(UART_ID_OF_CLS, "NPX GTSRB Result");

  // Move cursor to row 2, column 1
  uart_putc(UART_ID_OF_CLS, (char)27);
  uart_puts(UART_ID_OF_CLS, "[1;0H");
  uart_puts(UART_ID_OF_CLS, str);
#endif

}
