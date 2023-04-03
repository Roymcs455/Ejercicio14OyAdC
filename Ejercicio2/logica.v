module logica (
    input[3:0] microinst,
    input qselect,
    output reg selector,
    output reg pl,
    output reg mp,
    output reg vect
);
reg [3:0]salidas;
always @(microinst, qselect) begin
    case (microinst)
        3'b000: 
            salidas = 4'b0111;
        3'b001: 
            if (qselect) begin
                salidas = 4'b1011;
            end
            else begin
                salidas = 4'b0111;
            end
        3'b010: 
            if (qselect) begin
                salidas = 4'b0111;
            end
            else begin
                salidas = 4'b1011;
            end
        3'b011: 
            salidas = 4'b0111;
        3'b100: 
            salidas = 4'b0111;
        3'b101: 
            salidas = 4'b0111;
        3'b110: 
            salidas = 4'b0111;
        3'b111: 
            salidas = 4'b0111;
    endcase
    selector= salidas[3];
    pl= salidas[2];
    mp= salidas[1];
    vect= salidas[0];
end
    
endmodule