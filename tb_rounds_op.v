`timescale 1ns/1ps

module tb_rounds_op;

    reg clk_120MHz;
    reg reset_n;
    reg [127:0] input_vector;
    reg [127:0] round_key;
    reg rounds_mux1, rounds_mux2;
    reg ff1_en, ff2_en;
    wire [127:0] cipher_text;

    // Instantiate the DUT
    rounds_op uut (
        .clk_120MHz(clk_120MHz),
        .reset_n(reset_n),
        .input_vector(input_vector),
        .round_key(round_key),
        .rounds_mux1(rounds_mux1),
        .rounds_mux2(rounds_mux2),
        .ff2_en(ff2_en),
        .ff1_en(ff1_en),
        .cipher_text(cipher_text)
    );

    // 120 MHz clock (8.33 ns period)
    initial clk_120MHz = 0;
    always #5 clk_120MHz = ~clk_120MHz;

    // AES Round Keys
    reg [127:0] roundkeys [0:10];
    initial begin
    roundkeys[0]  = 128'h2b7e151628aed2a6abf7158809cf4f3c;
    roundkeys[1]  = 128'ha0fafe1788542cb123a339392a6c7605;
    roundkeys[2]  = 128'hf2c295f27a96b9435935807a7359f67f;
    roundkeys[3]  = 128'h3d80477d4716fe3e1e237e446d7a883b;
    roundkeys[4]  = 128'hef44a541a8525b7fb671253bdb0bad00;
    roundkeys[5]  = 128'hd4d1c6f87c839d87caf2b8bc11f915bc;
    roundkeys[6]  = 128'h6d88a37a110b3efddbf98641ca0093fd;
    roundkeys[7]  = 128'h4e54f70e5f5fc9f384a64fb24ea6dc4f;
    roundkeys[8]  = 128'head27321b58dbad2312bf5607f8d292f;
    roundkeys[9]  = 128'hac7766f319fadc2128d12941575c006e;
    roundkeys[10] = 128'hd014f9a8c9ee2589e13f0cc8b6630ca6;
    end

initial begin
    reset_n = 0;
    rounds_mux1 = 0;
    rounds_mux2 = 0;
    ff1_en = 1;
    ff2_en = 0
    ;
    input_vector = 128'h3243f6a8885a308d313198a2e0370734;
    round_key = roundkeys[0];
    #20;
    reset_n = 1;
    #20;
    rounds_mux1 = 1;
    round_key = roundkeys[1];
    #20;
    round_key = roundkeys[2];
    #20;
    round_key = roundkeys[3];
    #20;
    round_key = roundkeys[4];
    #20;
    round_key = roundkeys[5];
    #20;
    round_key = roundkeys[6];
    #20;
    round_key = roundkeys[7];
    #20;
    round_key = roundkeys[8];
    #20;
    round_key = roundkeys[9];
    #10;
    rounds_mux2 = 1;
    #10
    ff2_en = 1;
    round_key = roundkeys[10];
    #20;
    $stop;
end


endmodule
