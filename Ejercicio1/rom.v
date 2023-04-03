module rom (
	input[3:0] estado_presente,//4
	output reg[3:0] liga, //4 
	output reg[2:0] prueba, //3
	output reg VF, //1
	output reg[1:0] microinst, //2
	output reg[4:0] salidas //5
);
	
	reg[14:0] memoria;
	

always @(estado_presente ) 

begin
	case (estado_presente)
		4'b0000: 
			memoria = 15'b000000000000000;
		4'b0001: 
			memoria = 15'b000000000000001;
		4'b0010: 
			memoria = 15'b010011000000010;
		4'b0011: 
			memoria = 15'b010011000000011;
		4'b0100: 
			memoria = 15'b010011000000011;
		4'b0101: 
			memoria = 15'b010011000000011;
		4'b0110: 
			memoria = 15'b010011000000011;
		4'b0111:  
			memoria = 15'b010011000000011;
		4'b1000:  
			memoria = 15'b010011000000011;
		4'b1001:  
			memoria = 15'b010011000000011;
		4'b1010:  
			memoria = 15'b010011000000011;
		4'b1011:  
			memoria = 15'b010011000000011;
		4'b1100:  
			memoria = 15'b010011000000011;
		4'b1101:  
			memoria = 15'b010011000000011;
		4'b1110:  
			memoria = 15'b010011000000011;
		4'b1111:  
			memoria = 15'b010011000000011;
		default: 
			memoria = 15'b000000000000000;
	endcase
	liga <= memoria[3:0];//4 
	prueba <= memoria[6:4]; //3
	VF <= memoria[7] ; //1
	microinst <=memoria[9:8]; //2
	salidas <=memoria[14:10];//5
end

endmodule 