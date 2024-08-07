#line 1 "C:/Users/oscar/Documents/Semestre VIII/Microprocesadores ll/MikroC/Pic Sensor de temperatura LM35 y LM75/Pic_LM35_y_LM75.c"
#line 34 "C:/Users/oscar/Documents/Semestre VIII/Microprocesadores ll/MikroC/Pic Sensor de temperatura LM35 y LM75/Pic_LM35_y_LM75.c"
unsigned int lecturaADC;


char textoLM75[20];
char textoLM35[20];


float temperaturaLM75;


float temperaturaLM35;


void configurar(){
 ADCON0 = 0;
 ADCON1 = 0x0E;
 I2C1_Init(100000);
}


void I2C_LCD_Write2Reg(char rs,char dato)
{
 char data_h,data_l;
 data_h=dato & 0xF0;
 data_l=(dato << 4)& 0xF0;

 I2C1_Start();
 I2C1_Is_Idle();
 I2C1_Wr( 0x7E );
 I2C1_Is_Idle();

 I2C1_Wr(data_h | rs | 0x04 | 0x08);
 I2C1_Is_Idle();
 Delay_us(50);

 I2C1_Wr(data_h | rs | 0x00 | 0x08);
 I2C1_Is_Idle();
 Delay_us(100);


 I2C1_Wr(data_l | rs | 0x04 | 0x08);
 I2C1_Is_Idle();
 Delay_us(50);

 I2C1_Wr(data_l | rs | 0x00 | 0x08);
 I2C1_Is_Idle();
 I2C1_Stop();
}

void I2C_LCD_Cmd(char comando)
{
 char rs=0;
 I2C_LCD_Write2Reg(rs,comando);
 if(comando== 0x01 ){ Delay_ms(2); }
}

void I2C_LCD_PrintChr(char row,char col, char simbolo)
{
 char rs=0x01;
 switch(row)
 {
 case 1: I2C_LCD_Cmd( 0x80  + col);
 break;
 case 2: I2C_LCD_Cmd( 0xC0  + col);
 break;
 case 3: I2C_LCD_Cmd( 0x94  + (col-1));
 break;
 case 4: I2C_LCD_Cmd( 0xD4  + (col-1));
 break;
 }
 I2C_LCD_Write2Reg(rs,simbolo);
}
void I2C_LCD_PrintStr(char row,char col, char *texto)
{

 while(*texto)
 {
 I2C_LCD_PrintChr(row,col++,*texto++);
 }
}
void I2C_LCD_Init()
{
 char rs=0;
 I2C1_Start();
 I2C1_Is_Idle();
 I2C1_Wr( 0x7E );
 Delay_us(30);

 I2C1_Wr(0x20 | rs | 0x04 | 0x08);
 I2C1_Is_Idle();
 Delay_us(50);
 I2C1_Wr(0x20 | rs | 0x00 | 0x08);
 I2C1_Is_Idle();
 I2C1_Stop();
 Delay_us(10);

 I2C_LCD_Cmd(0x28);

 I2C_LCD_Cmd(0x06);
}

void escribir(char msg1[], char msg2[])
{
 I2C_LCD_Init();
 I2C_LCD_Cmd( 0x0C );
 I2C_LCD_Cmd( 0x01 );



 I2C_LCD_PrintStr(1,0,"TEMPLM75:");
 I2C_LCD_PrintStr(2,0,"TEMPLM35:");

 I2C_LCD_PrintStr(1,10,msg1);
 I2C_LCD_PrintStr(2,10,msg2);
}


float leerTemperaturaLM75A()
{
 unsigned int temp;
 float temperatura;


 I2C1_Start();
 I2C1_Is_Idle();
 I2C1_Wr( 0x90  | 0);
 I2C1_Is_Idle();
 I2C1_Wr(0x00);
 I2C1_Is_Idle();


 I2C1_Repeated_Start();
 I2C1_Is_Idle();
 I2C1_Wr( 0x90  | 1);
 I2C1_Is_Idle();


 temp = I2C1_Rd( 1 );
 temp <<= 8;
 temp |= I2C1_Rd( 0 );


 I2C1_Stop();


 temperatura = temp / 256.0;

 return temperatura;
}

void main()
{
 configurar();





 ADCON1=0b0100;



 TRISA0_bit=1;
 TRISA1_bit=1;

 while (1)
 {


 temperaturaLM75 = leerTemperaturaLM75A();




 lecturaADC=ADC_Read(0);



 temperaturaLM35 = lecturaADC*500.0/1023.0;





 floattostr_(temperaturaLM75, textoLM75, 2);



 floattostr_(temperaturaLM35,textoLM35,2);






 escribir(textoLM75, textoLM35);



 Delay_ms(500);
 }
}
