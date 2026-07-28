module float_decoder
    (
    input  [5:0]  decimal_factor,
    input  [31:0] whole,
    output [31:0] float
    );

    wire [31:0] int_val;
    wire [31:0] int_float;
    wire [31:0] product_out;

    assign int_val = whole;

    int_to_float I1 (
        .int_in(int_val),
        .float_out(int_float)
    );

      reg [31:0] divFactor;

    float_product M1 (
        .sA(divFactor[31]),    .sB(int_float[31]),
        .eA(divFactor[30:23]), .eB(int_float[30:23]),
        .mA(divFactor[22:0]),  .mB(int_float[22:0]),
        .float(product_out)
    );

    assign float = product_out;

    always @(*) begin
        case (decimal_factor)
            6'd0 : divFactor = 32'h3F800000; // 1/10^0  = 1.0
            6'd1 : divFactor = 32'h3DCCCCCD; // 1/10^1  = 0.1
            6'd2 : divFactor = 32'h3C23D70A; // 1/10^2  = 0.01
            6'd3 : divFactor = 32'h3A83126F; // 1/10^3  = 0.001
            6'd4 : divFactor = 32'h38D1B717; // 1/10^4  = 0.0001
            6'd5 : divFactor = 32'h3727C5AC; // 1/10^5  = 0.00001
            6'd6 : divFactor = 32'h358637BD; // 1/10^6  = 0.000001
            6'd7 : divFactor = 32'h33D6BF95; // 1/10^7  = 1e-7
            6'd8 : divFactor = 32'h322BCC77; // 1/10^8  = 1e-8
            6'd9 : divFactor = 32'h3089705F; // 1/10^9  = 1e-9
            6'd10: divFactor = 32'h2EDBE6FF; // 1/10^10 = 1e-10
            default: divFactor = 32'h3F800000; // fallback = 1.0
        endcase
    end

endmodule
