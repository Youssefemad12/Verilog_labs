module clk_gate(
    input clk,
    input clk_en,
    output gated_clk
);

reg latch_en;

always @(clk or clk_en) begin
    if(!clk) begin
        latch_en <= clk_en;
    end
end

assign gated_clk = clk & latch_en;
endmodule
