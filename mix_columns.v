module mix_columns(
    input [31:0] in,
    output reg [31:0] out
);

    reg [7:0] first, second, third, fourth;
    reg [7:0] r1 = 0, r2 = 0, r3 = 0, r4 = 0;
    reg [7:0] t1_1 = 0, t1_2 = 0, t2_1 = 0, t2_2 = 0, t3_1 = 0, t3_2 = 0, t4_1 = 0, t4_2 = 0;

    always @(*) begin
    out = 32'b0;
    r4 = in[7:0];
    r3 = in[15:8];
    r2 = in[23:16];
    r1 = in[31:24];

    if(r1[7] == 1'b1) t1_1 = ({r1[6:0],1'b0}) ^ 8'h1b;
    else t1_1 = ({r1[6:0],1'b0});

    if (r2[7] == 1'b1) t1_2 = ({r2[6:0],1'b0}) ^ 8'h1b;
    else t1_2 = ({r2[6:0],1'b0});
    t1_2 = t1_2 ^ r2;

    first = t1_1 ^ t1_2 ^ r3 ^ r4;

    if(r2[7] == 1'b1) t2_1 = ({r2[6:0],1'b0}) ^ 8'h1b;
    else t2_1 = ({r2[6:0],1'b0});

    if (r3[7] == 1'b1) t2_2 = ({r3[6:0],1'b0}) ^ 8'h1b;
    else t2_2 = ({r3[6:0],1'b0});
    t2_2 = t2_2 ^ r3;

    second = t2_1 ^ t2_2 ^ r1 ^ r4;

    if(r3[7] == 1'b1) t3_1 = ({r3[6:0],1'b0}) ^ 8'h1b;
    else t3_1 = ({r3[6:0],1'b0});

    if (r4[7] == 1'b1) t3_2 = ({r4[6:0],1'b0}) ^ 8'h1b;
    else t3_2 = ({r4[6:0],1'b0});
    t3_2 = t3_2 ^ r4;

    third = t3_1 ^ t3_2 ^ r1 ^ r2;

    if(r4[7] == 1'b1) t4_1 = ({r4[6:0],1'b0}) ^ 8'h1b;
    else t4_1 = ({r4[6:0],1'b0});

    if (r1[7] == 1'b1) t4_2 = ({r1[6:0],1'b0}) ^ 8'h1b;
    else t4_2 = ({r1[6:0],1'b0});
    t4_2 = t4_2 ^ r1;

    fourth = t4_1 ^ t4_2 ^ r3 ^ r2;

    out = {first,second,third,fourth};
    end

endmodule
