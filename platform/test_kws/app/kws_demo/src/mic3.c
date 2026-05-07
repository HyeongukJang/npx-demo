#include "frvp_spi.h"
#include "ervp_timer.h"
#include "ervp_interrupt.h"
#include "ervp_assert.h"
#include "ervp_malloc.h"
#include "ervp_matrix.h"
#include "ervp_matrix_element.h"
#include "PmodOLED.h"

#include "npx_tensor.h"
#include "mic3.h"

#define NSAMPLES        (16000)

#define SPI_FREQ            1000000
#define SPI_MODE            SPI_SCKMODE_0
#define PORT_ID             SPI_INDEX_FOR_READYMADE
#define NUM_BYTES         2

static const SpiConfig spiconfig = {SPI_DIVSOR(SPI_FREQ), SPI_MODE, (1<<PORT_ID), SPI_CSMODE_OFF, (SPI_FMT_PROTO(SPI_PROTO_S) | SPI_FMT_ENDIAN(SPI_ENDIAN_MSB) | SPI_FMT_LEN(8)), 1};

void mic3_config_spi()
{ 
  spi_configure(&spiconfig);
}

unsigned short mic3_read_value()
{
  unsigned short result;
  unsigned char value[NUM_BYTES];
  unsigned char *p_result = (unsigned char *)&result;

  spi_start();
  spi_read(NUM_BYTES, value);
  spi_end();

  *(p_result + 1) = value[0];
  *(p_result) = value[1];

  return result;
}

static volatile int sample_count = 0;

static int data_12bits[NSAMPLES];

void mic3_int_service_routine()
{
  unsigned short data = mic3_read_value();

  if(sample_count < NSAMPLES)
  {
    data_12bits[sample_count] = data;
    sample_count++;
  }
  if(sample_count >= NSAMPLES)
  {
    stop_timer();
  }
}

void mic3_set_env()
{
  config_timer_interval_us(63); // 15873 Hz
  register_isr_timer(mic3_int_service_routine);
  allow_interrupt_timer();
  enable_interrupt();
}

// init recording
void mic3_start()
{
  sample_count = 0;
  mic3_config_spi();
  start_timer_periodic();
}

void mic3_wait_until_buffer_full()
{
  while(sample_count < NSAMPLES);
}

npx_rawinput_t *mic3_get_sample()
{
  static npx_rawinput_t *npx_sample = NULL;
  if(npx_sample==NULL)
    npx_sample = (npx_rawinput_t *)malloc(sizeof(npx_rawinput_t));
  assert(npx_sample);
  npx_sample->type = WAVEFORM;
  npx_sample->tensor = npx_tensor_alloc_wo_data(3);
  npx_sample->tensor->size[0] = NSAMPLES;
  npx_sample->tensor->size[1] = 1;
  npx_sample->tensor->size[2] = 1;
  npx_tensor_set_datatype(npx_sample->tensor, MATRIX_DATATYPE_SINT16);
  npx_tensor_alloc_data(npx_sample->tensor);

  int16_t *waveform = npx_sample->tensor->addr;
  for(int k=0; k < NSAMPLES; k++)
  {
    waveform[k] = (int16_t)((data_12bits[k] - 2048)<<4);
  }

  npx_sample->label = 0;

  // scale
  npx_sample->scaled = 1;

  return npx_sample;
}

void mic3_draw_waveform()
{
#if 1 // draw nomalized wave
        int min = 0;
        int max = 0;
        for(int k=0; k < NSAMPLES; k++)
        {
          if((data_12bits[k]-2048) > max) max = (data_12bits[k]-2048);
          if((data_12bits[k]-2048) < min) min = (data_12bits[k]-2048);
        }
        //printf("\ndata_12bits max[%d] min[%d]", max, min);

        if(max < -min)
          max = -min;
#endif

        int interval = NSAMPLES / 128;
        for(int i=0; i < 127; i++)
        {
#if 0 // draw raw wave 
          OledMoveTo(i, data_12bits[i*interval]>>11);
          OledLineTo(i+1, data_12bits[(i+1)*interval]>>11);
#else // draw nomalized wave
          OledMoveTo(i, (int)((((float)data_12bits[i*interval]-2048.0)/(float)max + 1.0)*15.0));
          OledLineTo(i+1, (int)((((float)data_12bits[(i+1)*interval]-2048.0)/(float)max + 1.0)*15.0));
#endif
        }
        oled_bw_config_spi();
        OledUpdate();
        OledClearBuffer();
}

