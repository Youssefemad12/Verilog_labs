module alu_16bit(
    input clk,
    input [15:0] a,b,
    input [3:0] fun,
    output reg  [15:0] alu_result,
    output reg carry_flag ,arith_flag, logic_flag, cmp_flag, shift_flag
);

reg [15:0] result;
always @(*) begin
    carry_flag = 0;
    arith_flag = 0;
    logic_flag = 0;
    cmp_flag = 0;
    shift_flag = 0;

    case(fun)
        4'b0000: begin {carry_flag, result} = a + b; arith_flag = 1'b1; end
        4'b0001: begin {carry_flag, result} = a - b; arith_flag = 1'b1; end
        4'b0010: begin result = a * b; arith_flag = 1'b1; end
        4'b0011: begin result = a / b; arith_flag = 1'b1; end
        4'b0100: begin result = a & b; logic_flag = 1'b1; end
        4'b0101: begin result = a | b; logic_flag = 1'b1; end
        4'b0110: begin result = ~(a & b); logic_flag = 1'b1; end
        4'b0111: begin result = ~(a | b); logic_flag = 1'b1; end
        4'b1000: begin result = a ^ b; logic_flag = 1'b1; end
        4'b1001: begin result = ~(a ^ b); logic_flag = 1'b1; end
        4'b1010: begin result = (a == b) ? 16'b0001 : 16'b0000; cmp_flag = 1'b1; end
        4'b1011: begin result = (a > b) ? 16'b0010 : 16'b0000; cmp_flag = 1'b1; end
        4'b1100: begin result = (a < b) ? 16'b0011 : 16'b0000; cmp_flag = 1'b1; end
        4'b1101: begin result = a >> 1; shift_flag = 1'b1; end
        4'b1110: begin result = a << 1; shift_flag = 1'b1; end
        4'b1111: result = 16'b0000;
        default: result = 16'h0000;
    endcase
end

always @(posedge clk) begin
alu_result <= result;
end

endmodule