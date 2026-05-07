#include "platform_info.h"
#include "ervp_printf.h"

#include "ervp_delay.h"
#include "ervp_user_gpio.h"
#include "ervp_interrupt.h"

#include "ui.h"

#define DISPLAY_OLEDBW
#define DISPLAY_CLS

extern unsigned char rgbUserFont[];

int has_bntc_been_pressed = 0;
int has_bntu_been_pressed = 0;

void btnc_isr(void)
{
  printf("\npushed BTNC");
  has_bntc_been_pressed = 1;
  delay_ms(200);
}

void btnu_isr(void)
{
  printf("\npushed BTNU");
  has_bntu_been_pressed = 1;
  delay_ms(200);
}

void init_btn()
{
  user_gpio_set_input_cfg(GPIO_INDEX_FOR_BTNC, 0);
  user_gpio_enable_interrupt(GPIO_INDEX_FOR_BTNC, ERVP_TRIGGER_COND_RISE, 0);
  register_isr_gpio(GPIO_INDEX_FOR_BTNC, btnc_isr, 1);
  user_gpio_set_input_cfg(GPIO_INDEX_FOR_BTNU, 0);
  user_gpio_enable_interrupt(GPIO_INDEX_FOR_BTNU, ERVP_TRIGGER_COND_RISE, 0);
  register_isr_gpio(GPIO_INDEX_FOR_BTNU, btnu_isr, 1);

  register_plic_grant();
  allow_interrupt_plic();
  enable_interrupt();
}

int check_btn()
{
  int result = 0;
  if(has_bntu_been_pressed)
  {
    result = 2;
    has_bntu_been_pressed = 0;
  }
  else if(has_bntc_been_pressed)
  {
    result = 1;
    has_bntc_been_pressed = 0;
  }
  return result;
}

int wait_for_push_btn()
{
  int result = 0;
  while(1)
  {
    if(has_bntu_been_pressed)
    {
      result = 2;
      has_bntu_been_pressed = 0;
      break;
    }
    else if(has_bntc_been_pressed)
    {
      result = 1;
      has_bntc_been_pressed = 0;
      break;
    }
    delay_ms(100);
  }
  return result;
}
