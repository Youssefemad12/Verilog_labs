module aes_128(
    input clk_120MHz,
    input reset_n,
    input start,
    input [127:0] key_vector,
    input [127:0] data_in,
    output [127:0] cipher_text,
    output data_valid
);
wire rounds_mux1, rounds_mux2, key_en, rounds_en;
wire [3:0] rc_sig;
wire [127:0] round_key1;

control_unit cu1(
    .clk_120MHz(clk_120MHz),
    .reset_n(reset_n),
    .start(start),
    .rounds_mux1(rounds_mux1),
    .rounds_mux2(rounds_mux2),
    .key_en(key_en),
    .rounds_en(rounds_en),
    .rc_sig(rc_sig),
    .data_valid(data_valid)
);
key_expansion ke1(
    .clk_120MHz(clk_120MHz),
    .reset_n(reset_n),
    .key_vector(key_vector),
    .rc_sig(rc_sig),
    .ff1_en(key_en),
    .round_key(round_key1)
);
rounds_op ro1(
    .clk_120MHz(clk_120MHz),
    .reset_n(reset_n),
    .input_vector(data_in),
    .round_key(round_key1),
    .rounds_mux1(rounds_mux1),
    .rounds_mux2(rounds_mux2),
    .ff2_en(rounds_en),
    .ff1_en(rounds_en),
    .cipher_text(cipher_text)
);

endmodule
