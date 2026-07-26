module float_point_decoder (
	input[31:0] float,
	
	output sign,
	output[7:0] exponent, 
	output[22:0] mantissa
);

assign sign = float[31];
assign exponent = float[30:23];
assign mantissa = float[22:0];

endmodule 
