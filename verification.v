module verf;

    reg  [5:0]  dfa;
    reg  [5:0]  dfb;
    reg  [31:0] whole_a;
    reg  [31:0] whole_b;
    wire [31:0] float_out; 

    float_product_block DUT (
        .decimal_factor_a(dfa), .whole_a(whole_a),
        .decimal_factor_b(dfb), .whole_b(whole_b),
        .float_out(float_out)
    );

    initial begin
        whole_a = 32'd25627; dfa = 6'd2;
        whole_b = 32'd1;     dfb = 6'd0;
        #10;
        $display("Test 1: 256.27 * 1.0");
        $display("  got      = 0x%08h", float_out);
        $display("  expected = 0x4380228F");
        $display("");

        whole_a = 32'd500;   dfa = 6'd1;
        whole_b = 32'd25627; dfb = 6'd2;
        #10;
        $display("Test 2: 50.0 * 256.27");
        $display("  got      = 0x%08h", float_out);
        $display("  expected = 0x46483600");
        $display("");

        whole_a = 32'd100; dfa = 6'd0;
        whole_b = 32'd100; dfb = 6'd0;
        #10;
        $display("Test 3: 100.0 * 100.0");
        $display("  got      = 0x%08h", float_out);
        $display("  expected = 0x461C4000");
        $display("");

        whole_a = 32'd12345; dfa = 6'd3;
        whole_b = 32'd2;     dfb = 6'd0;
        #10;
        $display("Test 4: 12.345 * 2.0");
        $display("  got      = 0x%08h", float_out);
        $display("  expected = 0x41C5851F");
        $display("");
    end

endmodule
