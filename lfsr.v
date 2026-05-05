module lfsr(
    input clk,
    input reset_n,
    input [3:0]seed,
    output reg [3:0]q
);

always @(posedge clk , negedge reset_n) begin
    if(!reset_n)
        q <= seed;
    else
    begin
        q[0] <= q[2] ^ q[3];
        q[1] <= q[0];
        q[2] <= q[1];
        q[3] <= q[2];
    end
end

endmodule
