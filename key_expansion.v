module key_expansion(
    input clk_120MHz,
    input reset_n,
    input [127:0]key_vector,
    input [3:0] rc_sig,
    input ff1_en,
    output reg [127:0] round_key
);
// reg,wire declarattion
wire [31:0] g_out;
reg [31:0] g_input;
reg [31:0] r1,r2,r3,r4;
wire [31:0] t4,t5,t6,t7;
reg key_mux1,key_mux2;
reg [127:0] key_next;
reg [1:0] hold_cnt;


g_function g1(
    .clk_120MHz(clk_120MHz),
    .reset_n(reset_n),
    .g_input(g_input),
    .rc_sig(rc_sig),
    .g_output(g_out)
);


always @(posedge clk_120MHz, negedge reset_n) begin

    if(~reset_n) begin
        round_key <= 128'b0;
        key_mux1 <= 1'b0;
        key_mux2 <= 1'b0;
        hold_cnt <= 2'b00;
    end
    else if(ff1_en) begin
        if (hold_cnt == 2'd2) begin
                round_key <= key_next;
                hold_cnt  <= 2'd0;
            end else begin
                round_key <= round_key;
                hold_cnt  <= hold_cnt + 1'b1;
            end

    if(rc_sig == 4'b0000) begin
        key_mux1 = 1'b0;
        key_mux2 = 1'b0;
    end
    else begin
        key_mux1 = 1'b1;
        key_mux2 = 1'b1;
    end
end
end
always @(*) begin

        r4 = round_key[31:0];
        r3 = round_key[63:32];
        r2 = round_key[95:64];
        r1 = round_key[127:96];

        if(~key_mux1)begin
            key_next = key_vector;
        end
        else begin
        key_next = {t4,t5,t6,t7};
        end
    if(~key_mux2)
        g_input = key_vector[31:0];
    else
        g_input = round_key[31:0];
end
assign t4 = r1 ^ g_out;
assign t5 = t4 ^ r2;
assign t6 = t5 ^ r3;
assign t7 = t6 ^ r4;
endmodule
