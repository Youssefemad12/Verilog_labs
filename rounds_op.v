module rounds_op(
input clk_120MHz,
input reset_n,
input [127:0] input_vector,
input [127:0] round_key,
input rounds_mux1,
input rounds_mux2,
input ff2_en,ff1_en,
output reg [127:0] cipher_text
);

reg [127:0] temp;
reg [7:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15;
reg [127:0] out_next,shifted_reg,mixed_reg;
reg [127:0] shifted_text;
reg [127:0] mixed_text;
wire [31:0] m1,m2,m3,m4;

mix_columns mc1(
    .in({r0,r5,r10,r15}),
    .out(m1)
);

mix_columns mc2(
    .in({r4,r9,r14,r3}),
    .out(m2)
);

mix_columns mc3(
    .in({r8,r13,r2,r7}),
    .out(m3)
);

mix_columns mc4(
    .in({r12,r1,r6,r11}),
    .out(m4)
);
reg [7:0] sbox [0:255];
initial begin
    $readmemh("g_function.txt", sbox);
end

  always @(posedge clk_120MHz or negedge reset_n) begin
        if (!reset_n) begin
            shifted_reg <= 128'b0;
            mixed_reg   <= 128'b0;
            cipher_text <= 128'b0;
        end else begin
            if (ff1_en) begin
                shifted_reg <= shifted_text;
                mixed_reg   <= mixed_text;
            end
            if (ff2_en)
                cipher_text <= out_next;
        end
        if (rounds_mux2) begin
            out_next <= shifted_reg ^ round_key;
        end  else
            out_next <= mixed_reg ^ round_key;
end



always @(*) begin
    if (rounds_mux1)begin
        r15 = sbox[out_next[7:0]];
        r14 = sbox[out_next[15:8]];
        r13 = sbox[out_next[23:16]];
        r12 = sbox[out_next[31:24]];
        r11 = sbox[out_next[39:32]];
        r10 = sbox[out_next[47:40]];
        r9  = sbox[out_next[55:48]];
        r8  = sbox[out_next[63:56]];
        r7  = sbox[out_next[71:64]];
        r6  = sbox[out_next[79:72]];
        r5  = sbox[out_next[87:80]];
        r4  = sbox[out_next[95:88]];
        r3  = sbox[out_next[103:96]];
        r2  = sbox[out_next[111:104]];
        r1  = sbox[out_next[119:112]];
        r0  = sbox[out_next[127:120]];
    end
    else begin
        temp = input_vector ^ round_key;
        r15 = sbox[temp[7:0]];
        r14 = sbox[temp[15:8]];
        r13 = sbox[temp[23:16]];
        r12 = sbox[temp[31:24]];
        r11 = sbox[temp[39:32]];
        r10 = sbox[temp[47:40]];
        r9  = sbox[temp[55:48]];
        r8  = sbox[temp[63:56]];
        r7  = sbox[temp[71:64]];
        r6  = sbox[temp[79:72]];
        r5  = sbox[temp[87:80]];
        r4  = sbox[temp[95:88]];
        r3  = sbox[temp[103:96]];
        r2  = sbox[temp[111:104]];
        r1  = sbox[temp[119:112]];
        r0  = sbox[temp[127:120]];
    end

    shifted_text = {r0,r5,r10,r15,r4,r9,r14,r3,r8,r13,r2,r7,r12,r1,r6,r11};

    mixed_text = {m1,m2,m3,m4};
end
endmodule
