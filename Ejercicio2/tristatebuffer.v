module tristate_buffer(input enable, input[3:0] inpt, output reg[3:0] outpt);

always @(*) begin
  if (enable) begin
    outpt <= inpt;
  end
  else begin
    outpt <= 4'bzzzz; // tri-state output
  end
end

endmodule
