module bit_sync #( parameter width = 1, parameter num_stages = 2 ) (
    input [width-  1 : 0] async,
    input clk,
    input rst_n,
    output [width - 1 : 0] sync
);

reg [width - 1 : 0] stage [num_stages - 1 : 0];
integer i;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for ( i = 0; i < num_stages; i = i + 1) begin
            stage[i] <= 0;
        end
    end
    else begin
        stage[0] <= async;
        for ( i = 1 ; i < num_stages; i = i + 1) begin
            stage[i] <= stage[i - 1];
        end
    end
end

assign sync = stage[num_stages - 1];

endmodule
