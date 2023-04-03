module secuenciador(
    input clock,
    input reset,
    input cc,
    input[1:0] microinst,
    input[3:0] liga,
    input[3:0] reg_transf,
    input[3:0] reg_int,
    output[3:0] estado_presente);

reg[2:0] temporal, temporal2;
always@(posedge clock) begin
    if (reset)
        temporal = 0;
    else begin
        temporal2 = estado_presente+1;
        case (microinst) 
            2'b00:
                temporal = temporal2;
            2'b01: 
                if(!cc)
                    temporal = liga;
                else
                    temporal = temporal2;
            2'b10: 
                temporal = reg_transf;
            2'b11: 
                if (!cc)
                    temporal = reg_int;
                else
                    temporal = temporal2;
            default:
                temporal = 0;
        endcase
    end
end
assign estado_presente=temporal;
endmodule