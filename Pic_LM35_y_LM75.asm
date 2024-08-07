
_configurar:

;Pic_LM35_y_LM75.c,47 :: 		void configurar(){
;Pic_LM35_y_LM75.c,48 :: 		ADCON0 = 0;
	CLRF       ADCON0+0
;Pic_LM35_y_LM75.c,49 :: 		ADCON1 = 0x0E;
	MOVLW      14
	MOVWF      ADCON1+0
;Pic_LM35_y_LM75.c,50 :: 		I2C1_Init(100000);
	MOVLW      10
	MOVWF      SSPADD+0
	CALL       _I2C1_Init+0
;Pic_LM35_y_LM75.c,51 :: 		}
L_end_configurar:
	RETURN
; end of _configurar

_I2C_LCD_Write2Reg:

;Pic_LM35_y_LM75.c,54 :: 		void I2C_LCD_Write2Reg(char rs,char dato)
;Pic_LM35_y_LM75.c,57 :: 		data_h=dato & 0xF0;
	MOVLW      240
	ANDWF      FARG_I2C_LCD_Write2Reg_dato+0, 0
	MOVWF      I2C_LCD_Write2Reg_data_h_L0+0
;Pic_LM35_y_LM75.c,58 :: 		data_l=(dato << 4)& 0xF0;
	MOVF       FARG_I2C_LCD_Write2Reg_dato+0, 0
	MOVWF      I2C_LCD_Write2Reg_data_l_L0+0
	RLF        I2C_LCD_Write2Reg_data_l_L0+0, 1
	BCF        I2C_LCD_Write2Reg_data_l_L0+0, 0
	RLF        I2C_LCD_Write2Reg_data_l_L0+0, 1
	BCF        I2C_LCD_Write2Reg_data_l_L0+0, 0
	RLF        I2C_LCD_Write2Reg_data_l_L0+0, 1
	BCF        I2C_LCD_Write2Reg_data_l_L0+0, 0
	RLF        I2C_LCD_Write2Reg_data_l_L0+0, 1
	BCF        I2C_LCD_Write2Reg_data_l_L0+0, 0
	MOVLW      240
	ANDWF      I2C_LCD_Write2Reg_data_l_L0+0, 1
;Pic_LM35_y_LM75.c,60 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;Pic_LM35_y_LM75.c,61 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,62 :: 		I2C1_Wr(LCD_ADDR);
	MOVLW      126
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;Pic_LM35_y_LM75.c,63 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,65 :: 		I2C1_Wr(data_h | rs | 0x04 | 0x08);
	MOVF       FARG_I2C_LCD_Write2Reg_rs+0, 0
	IORWF      I2C_LCD_Write2Reg_data_h_L0+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	BSF        FARG_I2C1_Wr_data_+0, 2
	BSF        FARG_I2C1_Wr_data_+0, 3
	CALL       _I2C1_Wr+0
;Pic_LM35_y_LM75.c,66 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,67 :: 		Delay_us(50);
	MOVLW      16
	MOVWF      R13+0
L_I2C_LCD_Write2Reg0:
	DECFSZ     R13+0, 1
	GOTO       L_I2C_LCD_Write2Reg0
	NOP
;Pic_LM35_y_LM75.c,69 :: 		I2C1_Wr(data_h | rs | 0x00 | 0x08);
	MOVF       FARG_I2C_LCD_Write2Reg_rs+0, 0
	IORWF      I2C_LCD_Write2Reg_data_h_L0+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	BSF        FARG_I2C1_Wr_data_+0, 3
	CALL       _I2C1_Wr+0
;Pic_LM35_y_LM75.c,70 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,71 :: 		Delay_us(100);
	MOVLW      33
	MOVWF      R13+0
L_I2C_LCD_Write2Reg1:
	DECFSZ     R13+0, 1
	GOTO       L_I2C_LCD_Write2Reg1
;Pic_LM35_y_LM75.c,74 :: 		I2C1_Wr(data_l | rs | 0x04 | 0x08);
	MOVF       FARG_I2C_LCD_Write2Reg_rs+0, 0
	IORWF      I2C_LCD_Write2Reg_data_l_L0+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	BSF        FARG_I2C1_Wr_data_+0, 2
	BSF        FARG_I2C1_Wr_data_+0, 3
	CALL       _I2C1_Wr+0
;Pic_LM35_y_LM75.c,75 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,76 :: 		Delay_us(50);
	MOVLW      16
	MOVWF      R13+0
L_I2C_LCD_Write2Reg2:
	DECFSZ     R13+0, 1
	GOTO       L_I2C_LCD_Write2Reg2
	NOP
;Pic_LM35_y_LM75.c,78 :: 		I2C1_Wr(data_l | rs | 0x00 | 0x08);
	MOVF       FARG_I2C_LCD_Write2Reg_rs+0, 0
	IORWF      I2C_LCD_Write2Reg_data_l_L0+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	BSF        FARG_I2C1_Wr_data_+0, 3
	CALL       _I2C1_Wr+0
;Pic_LM35_y_LM75.c,79 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,80 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;Pic_LM35_y_LM75.c,81 :: 		}
L_end_I2C_LCD_Write2Reg:
	RETURN
; end of _I2C_LCD_Write2Reg

_I2C_LCD_Cmd:

;Pic_LM35_y_LM75.c,83 :: 		void I2C_LCD_Cmd(char comando)
;Pic_LM35_y_LM75.c,85 :: 		char rs=0;
	CLRF       I2C_LCD_Cmd_rs_L0+0
;Pic_LM35_y_LM75.c,86 :: 		I2C_LCD_Write2Reg(rs,comando);
	MOVF       I2C_LCD_Cmd_rs_L0+0, 0
	MOVWF      FARG_I2C_LCD_Write2Reg_rs+0
	MOVF       FARG_I2C_LCD_Cmd_comando+0, 0
	MOVWF      FARG_I2C_LCD_Write2Reg_dato+0
	CALL       _I2C_LCD_Write2Reg+0
;Pic_LM35_y_LM75.c,87 :: 		if(comando==LCD_CLEAR){ Delay_ms(2); }
	MOVF       FARG_I2C_LCD_Cmd_comando+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_I2C_LCD_Cmd3
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_I2C_LCD_Cmd4:
	DECFSZ     R13+0, 1
	GOTO       L_I2C_LCD_Cmd4
	DECFSZ     R12+0, 1
	GOTO       L_I2C_LCD_Cmd4
	NOP
	NOP
L_I2C_LCD_Cmd3:
;Pic_LM35_y_LM75.c,88 :: 		}
L_end_I2C_LCD_Cmd:
	RETURN
; end of _I2C_LCD_Cmd

_I2C_LCD_PrintChr:

;Pic_LM35_y_LM75.c,90 :: 		void I2C_LCD_PrintChr(char row,char col, char simbolo)
;Pic_LM35_y_LM75.c,92 :: 		char rs=0x01;
	MOVLW      1
	MOVWF      I2C_LCD_PrintChr_rs_L0+0
;Pic_LM35_y_LM75.c,93 :: 		switch(row)
	GOTO       L_I2C_LCD_PrintChr5
;Pic_LM35_y_LM75.c,95 :: 		case 1: I2C_LCD_Cmd(LCD_ROW1 + col);
L_I2C_LCD_PrintChr7:
	MOVF       FARG_I2C_LCD_PrintChr_col+0, 0
	ADDLW      128
	MOVWF      FARG_I2C_LCD_Cmd_comando+0
	CALL       _I2C_LCD_Cmd+0
;Pic_LM35_y_LM75.c,96 :: 		break;
	GOTO       L_I2C_LCD_PrintChr6
;Pic_LM35_y_LM75.c,97 :: 		case 2: I2C_LCD_Cmd(LCD_ROW2 + col);
L_I2C_LCD_PrintChr8:
	MOVF       FARG_I2C_LCD_PrintChr_col+0, 0
	ADDLW      192
	MOVWF      FARG_I2C_LCD_Cmd_comando+0
	CALL       _I2C_LCD_Cmd+0
;Pic_LM35_y_LM75.c,98 :: 		break;
	GOTO       L_I2C_LCD_PrintChr6
;Pic_LM35_y_LM75.c,99 :: 		case 3: I2C_LCD_Cmd(LCD_ROW3 + (col-1));
L_I2C_LCD_PrintChr9:
	DECF       FARG_I2C_LCD_PrintChr_col+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDLW      148
	MOVWF      FARG_I2C_LCD_Cmd_comando+0
	CALL       _I2C_LCD_Cmd+0
;Pic_LM35_y_LM75.c,100 :: 		break;
	GOTO       L_I2C_LCD_PrintChr6
;Pic_LM35_y_LM75.c,101 :: 		case 4: I2C_LCD_Cmd(LCD_ROW4 + (col-1));
L_I2C_LCD_PrintChr10:
	DECF       FARG_I2C_LCD_PrintChr_col+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDLW      212
	MOVWF      FARG_I2C_LCD_Cmd_comando+0
	CALL       _I2C_LCD_Cmd+0
;Pic_LM35_y_LM75.c,102 :: 		break;
	GOTO       L_I2C_LCD_PrintChr6
;Pic_LM35_y_LM75.c,103 :: 		}
L_I2C_LCD_PrintChr5:
	MOVF       FARG_I2C_LCD_PrintChr_row+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_I2C_LCD_PrintChr7
	MOVF       FARG_I2C_LCD_PrintChr_row+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_I2C_LCD_PrintChr8
	MOVF       FARG_I2C_LCD_PrintChr_row+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_I2C_LCD_PrintChr9
	MOVF       FARG_I2C_LCD_PrintChr_row+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_I2C_LCD_PrintChr10
L_I2C_LCD_PrintChr6:
;Pic_LM35_y_LM75.c,104 :: 		I2C_LCD_Write2Reg(rs,simbolo);
	MOVF       I2C_LCD_PrintChr_rs_L0+0, 0
	MOVWF      FARG_I2C_LCD_Write2Reg_rs+0
	MOVF       FARG_I2C_LCD_PrintChr_simbolo+0, 0
	MOVWF      FARG_I2C_LCD_Write2Reg_dato+0
	CALL       _I2C_LCD_Write2Reg+0
;Pic_LM35_y_LM75.c,105 :: 		}
L_end_I2C_LCD_PrintChr:
	RETURN
; end of _I2C_LCD_PrintChr

_I2C_LCD_PrintStr:

;Pic_LM35_y_LM75.c,106 :: 		void I2C_LCD_PrintStr(char row,char col, char *texto)
;Pic_LM35_y_LM75.c,109 :: 		while(*texto)
L_I2C_LCD_PrintStr11:
	MOVF       FARG_I2C_LCD_PrintStr_texto+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_I2C_LCD_PrintStr12
;Pic_LM35_y_LM75.c,111 :: 		I2C_LCD_PrintChr(row,col++,*texto++);
	MOVF       FARG_I2C_LCD_PrintStr_row+0, 0
	MOVWF      FARG_I2C_LCD_PrintChr_row+0
	MOVF       FARG_I2C_LCD_PrintStr_col+0, 0
	MOVWF      FARG_I2C_LCD_PrintChr_col+0
	MOVF       FARG_I2C_LCD_PrintStr_texto+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_I2C_LCD_PrintChr_simbolo+0
	CALL       _I2C_LCD_PrintChr+0
	INCF       FARG_I2C_LCD_PrintStr_col+0, 1
	INCF       FARG_I2C_LCD_PrintStr_texto+0, 1
;Pic_LM35_y_LM75.c,112 :: 		}
	GOTO       L_I2C_LCD_PrintStr11
L_I2C_LCD_PrintStr12:
;Pic_LM35_y_LM75.c,113 :: 		}
L_end_I2C_LCD_PrintStr:
	RETURN
; end of _I2C_LCD_PrintStr

_I2C_LCD_Init:

;Pic_LM35_y_LM75.c,114 :: 		void I2C_LCD_Init()
;Pic_LM35_y_LM75.c,116 :: 		char rs=0;
	CLRF       I2C_LCD_Init_rs_L0+0
;Pic_LM35_y_LM75.c,117 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;Pic_LM35_y_LM75.c,118 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,119 :: 		I2C1_Wr(LCD_ADDR);
	MOVLW      126
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;Pic_LM35_y_LM75.c,120 :: 		Delay_us(30);
	MOVLW      9
	MOVWF      R13+0
L_I2C_LCD_Init13:
	DECFSZ     R13+0, 1
	GOTO       L_I2C_LCD_Init13
	NOP
	NOP
;Pic_LM35_y_LM75.c,122 :: 		I2C1_Wr(0x20 | rs | 0x04 | 0x08);
	MOVLW      32
	IORWF      I2C_LCD_Init_rs_L0+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	BSF        FARG_I2C1_Wr_data_+0, 2
	BSF        FARG_I2C1_Wr_data_+0, 3
	CALL       _I2C1_Wr+0
;Pic_LM35_y_LM75.c,123 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,124 :: 		Delay_us(50);
	MOVLW      16
	MOVWF      R13+0
L_I2C_LCD_Init14:
	DECFSZ     R13+0, 1
	GOTO       L_I2C_LCD_Init14
	NOP
;Pic_LM35_y_LM75.c,125 :: 		I2C1_Wr(0x20 | rs | 0x00 | 0x08);
	MOVLW      32
	IORWF      I2C_LCD_Init_rs_L0+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	BSF        FARG_I2C1_Wr_data_+0, 3
	CALL       _I2C1_Wr+0
;Pic_LM35_y_LM75.c,126 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,127 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;Pic_LM35_y_LM75.c,128 :: 		Delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_I2C_LCD_Init15:
	DECFSZ     R13+0, 1
	GOTO       L_I2C_LCD_Init15
;Pic_LM35_y_LM75.c,130 :: 		I2C_LCD_Cmd(0x28);
	MOVLW      40
	MOVWF      FARG_I2C_LCD_Cmd_comando+0
	CALL       _I2C_LCD_Cmd+0
;Pic_LM35_y_LM75.c,132 :: 		I2C_LCD_Cmd(0x06);
	MOVLW      6
	MOVWF      FARG_I2C_LCD_Cmd_comando+0
	CALL       _I2C_LCD_Cmd+0
;Pic_LM35_y_LM75.c,133 :: 		}
L_end_I2C_LCD_Init:
	RETURN
; end of _I2C_LCD_Init

_escribir:

;Pic_LM35_y_LM75.c,135 :: 		void escribir(char msg1[], char msg2[])
;Pic_LM35_y_LM75.c,137 :: 		I2C_LCD_Init();
	CALL       _I2C_LCD_Init+0
;Pic_LM35_y_LM75.c,138 :: 		I2C_LCD_Cmd(LCD_CUR_OFF);
	MOVLW      12
	MOVWF      FARG_I2C_LCD_Cmd_comando+0
	CALL       _I2C_LCD_Cmd+0
;Pic_LM35_y_LM75.c,139 :: 		I2C_LCD_Cmd(LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_I2C_LCD_Cmd_comando+0
	CALL       _I2C_LCD_Cmd+0
;Pic_LM35_y_LM75.c,143 :: 		I2C_LCD_PrintStr(1,0,"TEMPLM75:");
	MOVLW      1
	MOVWF      FARG_I2C_LCD_PrintStr_row+0
	CLRF       FARG_I2C_LCD_PrintStr_col+0
	MOVLW      ?lstr1_Pic_LM35_y_LM75+0
	MOVWF      FARG_I2C_LCD_PrintStr_texto+0
	CALL       _I2C_LCD_PrintStr+0
;Pic_LM35_y_LM75.c,144 :: 		I2C_LCD_PrintStr(2,0,"TEMPLM35:");
	MOVLW      2
	MOVWF      FARG_I2C_LCD_PrintStr_row+0
	CLRF       FARG_I2C_LCD_PrintStr_col+0
	MOVLW      ?lstr2_Pic_LM35_y_LM75+0
	MOVWF      FARG_I2C_LCD_PrintStr_texto+0
	CALL       _I2C_LCD_PrintStr+0
;Pic_LM35_y_LM75.c,146 :: 		I2C_LCD_PrintStr(1,10,msg1);
	MOVLW      1
	MOVWF      FARG_I2C_LCD_PrintStr_row+0
	MOVLW      10
	MOVWF      FARG_I2C_LCD_PrintStr_col+0
	MOVF       FARG_escribir_msg1+0, 0
	MOVWF      FARG_I2C_LCD_PrintStr_texto+0
	CALL       _I2C_LCD_PrintStr+0
;Pic_LM35_y_LM75.c,147 :: 		I2C_LCD_PrintStr(2,10,msg2);
	MOVLW      2
	MOVWF      FARG_I2C_LCD_PrintStr_row+0
	MOVLW      10
	MOVWF      FARG_I2C_LCD_PrintStr_col+0
	MOVF       FARG_escribir_msg2+0, 0
	MOVWF      FARG_I2C_LCD_PrintStr_texto+0
	CALL       _I2C_LCD_PrintStr+0
;Pic_LM35_y_LM75.c,148 :: 		}
L_end_escribir:
	RETURN
; end of _escribir

_leerTemperaturaLM75A:

;Pic_LM35_y_LM75.c,151 :: 		float leerTemperaturaLM75A()
;Pic_LM35_y_LM75.c,157 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;Pic_LM35_y_LM75.c,158 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,159 :: 		I2C1_Wr(LM75A_ADDR | 0);  // Direccion del LM75A + bit de escritura
	MOVLW      144
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;Pic_LM35_y_LM75.c,160 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,161 :: 		I2C1_Wr(0x00);  // Registro de temperatura
	CLRF       FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;Pic_LM35_y_LM75.c,162 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,165 :: 		I2C1_Repeated_Start();
	CALL       _I2C1_Repeated_Start+0
;Pic_LM35_y_LM75.c,166 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,167 :: 		I2C1_Wr(LM75A_ADDR | 1);  // Direccion del LM75A + bit de lectura
	MOVLW      145
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;Pic_LM35_y_LM75.c,168 :: 		I2C1_Is_Idle();
	CALL       _I2C1_Is_Idle+0
;Pic_LM35_y_LM75.c,171 :: 		temp = I2C1_Rd(ACK);
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      leerTemperaturaLM75A_temp_L0+0
	CLRF       leerTemperaturaLM75A_temp_L0+1
;Pic_LM35_y_LM75.c,172 :: 		temp <<= 8;
	MOVF       leerTemperaturaLM75A_temp_L0+0, 0
	MOVWF      leerTemperaturaLM75A_temp_L0+1
	CLRF       leerTemperaturaLM75A_temp_L0+0
;Pic_LM35_y_LM75.c,173 :: 		temp |= I2C1_Rd(NOACK);
	CLRF       FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	IORWF      leerTemperaturaLM75A_temp_L0+0, 1
	MOVLW      0
	IORWF      leerTemperaturaLM75A_temp_L0+1, 1
;Pic_LM35_y_LM75.c,176 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;Pic_LM35_y_LM75.c,179 :: 		temperatura = temp / 256.0;
	MOVF       leerTemperaturaLM75A_temp_L0+0, 0
	MOVWF      R0+0
	MOVF       leerTemperaturaLM75A_temp_L0+1, 0
	MOVWF      R0+1
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      135
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
;Pic_LM35_y_LM75.c,181 :: 		return temperatura;
;Pic_LM35_y_LM75.c,182 :: 		}
L_end_leerTemperaturaLM75A:
	RETURN
; end of _leerTemperaturaLM75A

_main:

;Pic_LM35_y_LM75.c,184 :: 		void main()
;Pic_LM35_y_LM75.c,186 :: 		configurar();
	CALL       _configurar+0
;Pic_LM35_y_LM75.c,192 :: 		ADCON1=0b0100;                     //3 canales analogos
	MOVLW      4
	MOVWF      ADCON1+0
;Pic_LM35_y_LM75.c,196 :: 		TRISA0_bit=1;
	BSF        TRISA0_bit+0, BitPos(TRISA0_bit+0)
;Pic_LM35_y_LM75.c,197 :: 		TRISA1_bit=1;
	BSF        TRISA1_bit+0, BitPos(TRISA1_bit+0)
;Pic_LM35_y_LM75.c,199 :: 		while (1)
L_main16:
;Pic_LM35_y_LM75.c,203 :: 		temperaturaLM75 = leerTemperaturaLM75A();
	CALL       _leerTemperaturaLM75A+0
	MOVF       R0+0, 0
	MOVWF      _temperaturaLM75+0
	MOVF       R0+1, 0
	MOVWF      _temperaturaLM75+1
	MOVF       R0+2, 0
	MOVWF      _temperaturaLM75+2
	MOVF       R0+3, 0
	MOVWF      _temperaturaLM75+3
;Pic_LM35_y_LM75.c,208 :: 		lecturaADC=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _lecturaADC+0
	MOVF       R0+1, 0
	MOVWF      _lecturaADC+1
;Pic_LM35_y_LM75.c,212 :: 		temperaturaLM35 = lecturaADC*500.0/1023.0;
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      122
	MOVWF      R4+2
	MOVLW      135
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _temperaturaLM35+0
	MOVF       R0+1, 0
	MOVWF      _temperaturaLM35+1
	MOVF       R0+2, 0
	MOVWF      _temperaturaLM35+2
	MOVF       R0+3, 0
	MOVWF      _temperaturaLM35+3
;Pic_LM35_y_LM75.c,218 :: 		floattostr_(temperaturaLM75, textoLM75, 2);
	MOVF       _temperaturaLM75+0, 0
	MOVWF      FARG_floattostr__numero_+0
	MOVF       _temperaturaLM75+1, 0
	MOVWF      FARG_floattostr__numero_+1
	MOVF       _temperaturaLM75+2, 0
	MOVWF      FARG_floattostr__numero_+2
	MOVF       _temperaturaLM75+3, 0
	MOVWF      FARG_floattostr__numero_+3
	MOVLW      _textoLM75+0
	MOVWF      FARG_floattostr__cadena_+0
	MOVLW      2
	MOVWF      FARG_floattostr__decimales_+0
	CALL       _floattostr_+0
;Pic_LM35_y_LM75.c,222 :: 		floattostr_(temperaturaLM35,textoLM35,2);
	MOVF       _temperaturaLM35+0, 0
	MOVWF      FARG_floattostr__numero_+0
	MOVF       _temperaturaLM35+1, 0
	MOVWF      FARG_floattostr__numero_+1
	MOVF       _temperaturaLM35+2, 0
	MOVWF      FARG_floattostr__numero_+2
	MOVF       _temperaturaLM35+3, 0
	MOVWF      FARG_floattostr__numero_+3
	MOVLW      _textoLM35+0
	MOVWF      FARG_floattostr__cadena_+0
	MOVLW      2
	MOVWF      FARG_floattostr__decimales_+0
	CALL       _floattostr_+0
;Pic_LM35_y_LM75.c,229 :: 		escribir(textoLM75, textoLM35);
	MOVLW      _textoLM75+0
	MOVWF      FARG_escribir_msg1+0
	MOVLW      _textoLM35+0
	MOVWF      FARG_escribir_msg2+0
	CALL       _escribir+0
;Pic_LM35_y_LM75.c,233 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	DECFSZ     R11+0, 1
	GOTO       L_main18
	NOP
	NOP
;Pic_LM35_y_LM75.c,234 :: 		}
	GOTO       L_main16
;Pic_LM35_y_LM75.c,235 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
