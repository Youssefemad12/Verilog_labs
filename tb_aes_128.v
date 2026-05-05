module tb_aes();
    reg clk_120MHz;
    reg reset_n;
    reg start;
    reg [127:0] key_vector;
    reg [127:0] data_in;
    wire [127:0] cipher_text;
    wire data_valid;

 aes_128 uut (
    .clk_120MHz(clk_120MHz),
    .reset_n(reset_n),
    .start(start),
    .key_vector(key_vector),
    .data_in(data_in),
    .cipher_text(cipher_text),
    .data_valid(data_valid)
 );

    initial clk_120MHz = 0;
    always #5 clk_120MHz = ~clk_120MHz;

    initial begin
        reset_n = 0;
        start = 0;
        key_vector = 128'h000102030405060708090a0b0c0d0e0f;
        data_in = 128'h00112233445566778899aabbccddeeff;
        #10;
        reset_n = 1;
        start = 1;
        #570;
        $stop;
    end
endmodule
