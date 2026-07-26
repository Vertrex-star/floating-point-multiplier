module int_to_float (
	input wire signed [31:0] int_in,
	output wire [31:0] float_out
);

wire sign = int_in[31];
wire [31:0] abs_val = sign ? (~int_in + 1'b1) : int_in;

// find most significant bit 
integer i;
reg[5:0] msb_pos;

always @(*) begin 
	msb_pos = 6'd0;
	for (i = 31; i >= 0; i = i-1) begin 
		if(abs_val[i] && (msb_pos == 0) && i != 0) begin 
			msb_pos = i[5:0];
		end
	end
end

// shifting time
wire[5:0] shift_amt = 6'd31 - msb_pos;
wire[63:0] shifted = ({32'd0, abs_val} << shift_amt);

wire[22:0] mantissa_raw = shifted[30:8];
wire guard = shifted[7];
wire round_bit = shifted[6];
wire sticky = |shifted[5:0];

// round up
wire round_up = guard && (round_bit || sticky || mantissa_raw[0]);

wire[23:0] mantissa_rounded = {1'b0, mantissa_raw} + round_up;
wire mant_overflow = mantissa_rounded[23];


// final based on overflw result
wire[22:0] mantissa_final = mant_overflow ? 23'd0 : mantissa_rounded[22:0];

// exponent time
wire[8:0] exponent_biased = {3'b0, msb_pos} + 9'd127 + mant_overflow;
wire is_zero = (abs_val == 32'd0);

// the final result sheeeshh
assign float_out = is_zero ? 32'd0 : {sign, exponent_biased[7:0], mantissa_final};

endmodule 
