module spi_module
(
         input I_clk, // глобальные часы 50 МГц
         input I_rst_n, // Сброс сигнала, активный низкий
         input I_rx_en, // сигнал включения чтения
         input I_tx_en, // отправить сигнал разрешения
         output reg [7: 0] O_data_out, // полученные данные
         output reg O_tx_done, // Отправить флаг завершения байта
         output reg O_rx_done, // Получить флаг завершения байта
    
         // Четырехпроводное стандартное определение сигнала SPI
         input I_spi_miso, // последовательный вход SPI, используется для получения данных от подчиненного
         output logic O_spi_sck, // часы SPI
         output logic O_spi_cs, // сигнал выбора микросхемы SPI
         output reg O_spi_mosi // Выход SPI, используемый для отправки данных на ведомый          
);

logic [7:0]   I_data_in       ; // данные для отправки
logic [3:0]   R_tx_state      ; 
logic [3:0]   R_rx_state      ;

always @(posedge I_clk or negedge I_rst_n)
begin
    if(!I_rst_n)
        begin
            R_tx_state  <=  4'd0    ;
            R_rx_state  <=  4'd0    ;
            O_spi_cs    <=  1'b1    ;
            O_spi_sck   <=  1'b0    ;
            O_spi_mosi  <=  1'b0    ;
            O_tx_done   <=  1'b0    ;
            O_rx_done   <=  1'b0    ;
            O_data_out  <=  8'd0    ;
        end 
         else if (I_tx_en) // При отправке включен сигнал включения
        begin
            O_spi_cs <= 1'b0; // вытащить чип выбрать CS низкий
            case(R_tx_state)
                4'd1, 4'd3 , 4'd5 , 4'd7  , 
                                 4'd9, 4'd11, 4'd13, 4'd15: // интегрировать нечетное состояние
                    begin
                        O_spi_sck   <=  1'b1                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        O_tx_done   <=  1'b0                ;
                    end
                                 4'd0: // отправить 7-й бит
                    begin
                        O_spi_mosi  <=  I_data_in[7]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        O_tx_done   <=  1'b0                ;
                    end
                                 4'd2: // отправить 6-ю цифру
                    begin
                        O_spi_mosi  <=  I_data_in[6]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        O_tx_done   <=  1'b0                ;
                    end
                                 4'd4: // отправить пятую цифру
                    begin
                        O_spi_mosi  <=  I_data_in[5]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        O_tx_done   <=  1'b0                ;
                    end 
                                 4'd6: // отправить 4-ю цифру
                    begin
                        O_spi_mosi  <=  I_data_in[4]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        O_tx_done   <=  1'b0                ;
                    end 
                                 4'd8: // отправить третью цифру
                    begin
                        O_spi_mosi  <=  I_data_in[3]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        O_tx_done   <=  1'b0                ;
                    end                            
                                 4'd10: // отправить вторую цифру
                    begin
                        O_spi_mosi  <=  I_data_in[2]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        O_tx_done   <=  1'b0                ;
                    end 
                                 4'd12: // отправить первый бит
                    begin
                        O_spi_mosi  <=  I_data_in[1]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        O_tx_done   <=  1'b0                ;
                    end 
                                 4'd14: // отправить бит 0
                    begin
                        O_spi_mosi  <=  I_data_in[0]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        O_tx_done   <=  1'b1                ;
                    end
                default:R_tx_state  <=  4'd0                ;   
            endcase 
        end
         else if (I_rx_en) // При получении сигнал включения включен
        begin
                         O_spi_cs <= 1'b0; // опустить сигнал выбора микросхемы CS
            case(R_rx_state)
                4'd0, 4'd2 , 4'd4 , 4'd6  , 
                                 4'd8, 4'd10, 4'd12, 4'd14: // интегрировать четное состояние
                    begin
                        O_spi_sck       <=  1'b0                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        O_rx_done       <=  1'b0                ;
                    end
                                 4'd1: // Получить 7-ю цифру
                    begin                       
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        O_rx_done       <=  1'b0                ;
                        O_data_out[7]   <=  I_spi_miso          ;   
                    end
                                 4'd3: // Получить 6-ю цифру
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        O_rx_done       <=  1'b0                ;
                        O_data_out[6]   <=  I_spi_miso          ; 
                    end
                                 4'd5: // Получить 5-ю цифру
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        O_rx_done       <=  1'b0                ;
                        O_data_out[5]   <=  I_spi_miso          ; 
                    end 
                                 4'd7: // Получить 4-ую цифру
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        O_rx_done       <=  1'b0                ;
                        O_data_out[4]   <=  I_spi_miso          ; 
                    end 
                                 4'd9: // Получить третью цифру
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        O_rx_done       <=  1'b0                ;
                        O_data_out[3]   <=  I_spi_miso          ; 
                    end                            
                                 4'd11: // Получить вторую цифру
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        O_rx_done       <=  1'b0                ;
                        O_data_out[2]   <=  I_spi_miso          ; 
                    end 
                                 4'd13: // Получить первую цифру
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        O_rx_done       <=  1'b0                ;
                        O_data_out[1]   <=  I_spi_miso          ; 
                    end 
                                 4'd15: // Получить бит 0
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        O_rx_done       <=  1'b1                ;
                        O_data_out[0]   <=  I_spi_miso          ; 
                    end
                default:R_rx_state  <=  4'd0                    ;   
            endcase 
        end    
    else
        begin
            R_tx_state  <=  4'd0    ;
            R_rx_state  <=  4'd0    ;
            O_tx_done   <=  1'b0    ;
            O_rx_done   <=  1'b0    ;
            O_spi_cs    <=  1'b1    ;
            O_spi_sck   <=  1'b0    ;
            O_spi_mosi  <=  1'b0    ;
            O_data_out  <=  8'd0    ;
        end      
end

adc adc_inst
(
    .I_data_in(I_data_in)
);

endmodule
