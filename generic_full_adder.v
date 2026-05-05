module generic_full_adder #(parameter WIDTH = 8) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire             cin,
    input  wire             clk,
    output wire [WIDTH-1:0] sum,
    output wire             cout
);

    wire [WIDTH:0] c;
    assign c[0] = cin;
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : FA_LOOP
            adder FA (
                .a   (a[i]),
                .b   (b[i]),
                .cin (c[i]),
                .clk (clk),
                .s   (sum[i]),
                .c   (c[i+1])
            );
        end
    endgenerate

    assign cout = c[WIDTH];

endmodule
