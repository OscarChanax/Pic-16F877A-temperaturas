//
// Definicion de opcode para la LCD
// Direccion por defecto PCF8574 = 0x4E
// Direccion por defecto PCF8574A = 0x7E

// Definicion de direcciones
#define LCD_ADDR 0x7E
//#define LCD_ADDR 0x4E
//#define LCD_ADDR 0x27

#define LCD_ROW1 0x80
#define LCD_ROW2 0xC0
#define LCD_ROW3 0x94
#define LCD_ROW4 0xD4

// OPCODE de manejo de pantalla
#define LCD_CLEAR 0x01
#define LCD_RETURN 0x10
#define LCD_CUR_OFF 0x0C
#define LCD_CUR_ON 0x0F
#define LCD_UND_ON 0x0E
#define LCD_BLINK_ON 0x0F
#define LCD_OFF 0x08
#define LCD_ON 0x0C

// Definicion de señales
#define ACK 1
#define NOACK 0

// Definicion de la direccion I2C del LM75A
#define LM75A_ADDR 0x90

// Defino variable que almacena valor del ADC
unsigned int lecturaADC;         //lectura de ADC

// Defino variable que almacena valor de temperatura del sensor LM75
char textoLM75[20];
char textoLM35[20];

//Variable para almacenar la lectura de temperatura del LM75
float temperaturaLM75;

//Variable para almacenar la lectura de temperatura del LM35
float temperaturaLM35;


void configurar(){
        ADCON0 = 0;
        ADCON1 = 0x0E;
        I2C1_Init(100000);
}

// Funciones para manejar la LCD
void I2C_LCD_Write2Reg(char rs,char dato)
{
        char data_h,data_l;
        data_h=dato & 0xF0;
        data_l=(dato << 4)& 0xF0;
        // Iniciar comunicacion I2C
        I2C1_Start();
        I2C1_Is_Idle();
        I2C1_Wr(LCD_ADDR);
        I2C1_Is_Idle();
        // Envio de la primera mitad del dato que es la alta
        I2C1_Wr(data_h | rs | 0x04 | 0x08);
        I2C1_Is_Idle();
        Delay_us(50);

        I2C1_Wr(data_h | rs | 0x00 | 0x08);
        I2C1_Is_Idle();
        Delay_us(100);

        // Envio de la segunda mitad del dato que es la baja
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
        if(comando==LCD_CLEAR){ Delay_ms(2); }
}

void I2C_LCD_PrintChr(char row,char col, char simbolo)
{
        char rs=0x01;
        switch(row)
        {
                case 1: I2C_LCD_Cmd(LCD_ROW1 + col);
                        break;
                case 2: I2C_LCD_Cmd(LCD_ROW2 + col);
                        break;
                case 3: I2C_LCD_Cmd(LCD_ROW3 + (col-1));
                        break;
                case 4: I2C_LCD_Cmd(LCD_ROW4 + (col-1));
                        break;
        }
        I2C_LCD_Write2Reg(rs,simbolo);
}
void I2C_LCD_PrintStr(char row,char col, char *texto)
{
        // Escritura de cadena de caracteres
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
        I2C1_Wr(LCD_ADDR);
        Delay_us(30);
        // Envio de la configuracion de primera linea de 4 bits
        I2C1_Wr(0x20 | rs | 0x04 | 0x08);
        I2C1_Is_Idle();
        Delay_us(50);
        I2C1_Wr(0x20 | rs | 0x00 | 0x08);
        I2C1_Is_Idle();
        I2C1_Stop();
        Delay_us(10);
        // Envio de la configuracion
        I2C_LCD_Cmd(0x28);
        // Envio de modo de entrada
        I2C_LCD_Cmd(0x06);
}

void escribir(char msg1[], char msg2[])
{
     I2C_LCD_Init();
     I2C_LCD_Cmd(LCD_CUR_OFF);
     I2C_LCD_Cmd(LCD_CLEAR);
     
     //vIsilizar texto en un area especifica
     
     I2C_LCD_PrintStr(1,0,"TEMPLM75:");
     I2C_LCD_PrintStr(2,0,"TEMPLM35:");
     
     I2C_LCD_PrintStr(1,10,msg1);
     I2C_LCD_PrintStr(2,10,msg2);
}

// Funcion para leer temperatura del LM75A
float leerTemperaturaLM75A()
{
        unsigned int temp;
        float temperatura;

        // Iniciar comunicacion I2C
        I2C1_Start();
        I2C1_Is_Idle();
        I2C1_Wr(LM75A_ADDR | 0);  // Direccion del LM75A + bit de escritura
        I2C1_Is_Idle();
        I2C1_Wr(0x00);  // Registro de temperatura
        I2C1_Is_Idle();

        // Reiniciar para leer
        I2C1_Repeated_Start();
        I2C1_Is_Idle();
        I2C1_Wr(LM75A_ADDR | 1);  // Direccion del LM75A + bit de lectura
        I2C1_Is_Idle();

        // Leer datos de temperatura
        temp = I2C1_Rd(ACK);
        temp <<= 8;
        temp |= I2C1_Rd(NOACK);

        // Detener comunicacion I2C
        I2C1_Stop();

        // Convertir a temperatura
        temperatura = temp / 256.0;

        return temperatura;
}

void main()
{
        configurar();
        
        //---------------------Declaro los pines como analogos-----------------
         //Analogo AN0
        //ADCON1 = 0b1110;
        //Declaracion de los pines como analogos
        ADCON1=0b0100;                     //3 canales analogos

        //--------------------Defino los pines como entradas-------------------
        //Defino los pines como entradas
        TRISA0_bit=1;
        TRISA1_bit=1;

        while (1)
        {
        //-------------------------------------------------LM75--------------------------------------------
                // Leer temperatura del sensor LM75A
                temperaturaLM75 = leerTemperaturaLM75A();
        //-------------------------------------------------------------------------------------------------

        //*********************************Lectura Sensor de temperatura LM35*********************************************************
        //lectura del ADC
        lecturaADC=ADC_Read(0);

        //conversion de dato del ADC a temperatura

        temperaturaLM35 = lecturaADC*500.0/1023.0;
        
        //-------------------------------------------------------------------------------------------------------------------------
        
        //*************************************Conversion de datos********************************************************************
                // Conversion de datos del LM75 a texto
                floattostr_(temperaturaLM75, textoLM75, 2);
                
                //conversion de datos conversion de datos del LM75 a texto

                floattostr_(temperaturaLM35,textoLM35,2);

         //********************************Visualizacion de texto en pantalla*****************************************************
                  //Utilizo la libreria STRCAT para concatenar texto
                 // strcat(textoLM75,"TEMPLM75);
                
                // Mostrar temperatura en la LCD
                escribir(textoLM75, textoLM35);
                

                // Esperar 1 segundo antes de la siguiente lectura
                Delay_ms(500);
        }
}