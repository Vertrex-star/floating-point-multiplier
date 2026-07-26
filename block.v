
module float_product_block (
    input  [5:0]  decimal_factor_a,
    input  [31:0] whole_a,
    input  [5:0]  decimal_factor_b,
    input  [31:0] whole_b,
    output [31:0] float_out
);
 
    wire [31:0] float_a, float_b;
 
    float_decoder DEC_A (
        .decimal_factor(decimal_factor_a),
        .whole(whole_a),
        .float(float_a)
    );
 
    float_decoder DEC_B (
        .decimal_factor(decimal_factor_b),
        .whole(whole_b),
        .float(float_b)
    );
 
    float_product MUL (
        .sA(float_a[31]),    .sB(float_b[31]),
        .eA(float_a[30:23]), .eB(float_b[30:23]),
        .mA(float_a[22:0]),  .mB(float_b[22:0]),
        .float(float_out)
    );
 
endmodule
