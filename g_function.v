module g_function(
    input clk_120MHz,
    input reset_n,
    input [31:0] g_input,
    input [3:0]rc_sig,
    output reg [31:0]g_output
);

reg [7:0] box0,box1,box2,box3;
reg [7:0]sbox [0:255];

reg [7:0]rcon[0:10];
initial begin
    $readmemh("g_function.txt", sbox);
end

initial begin
    $readmemh("rcon.txt", rcon);
end

always @(posedge clk_120MHz, negedge reset_n) begin
if(~reset_n) begin
    g_output <= 32'b0;
end
else begin

box0 <= sbox[g_input[15:8]];
box1 <= sbox[g_input[23:16]] ^ rcon[rc_sig];
box2 <= sbox[g_input[31:24]];
box3 <= sbox[g_input[7:0]];
g_output <= {box1, box0, box3, box2};
end
end
endmodule
