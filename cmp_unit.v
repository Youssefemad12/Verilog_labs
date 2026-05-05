module cmp_unit #( parameter width = 16)(
    input clk,
    input [width-1:0] a,b,
    input [1:0] cu_fun,
    input cu_en,
    output reg [width-1:0] cu_result
);

always @(posedge clk) begin
    if (cu_en) begin
        case(cu_fun)
            2'b00: cu_result <= 16'h0000;
            2'b01: begin if (a == b) cu_result <= 16'h0001; else cu_result <= 16'h0000; end
            2'b10: begin if (a > b) cu_result <= 16'h0002; else cu_result <= 16'h0000; end
            2'b11: begin if (a < b) cu_result <= 16'h0003; else cu_result <= 16'h0000; end
            default: cu_result <= 16'h0000;
        endcase
    end else begin
        cu_result <= 16'h0000;
    end
end

endmodule
