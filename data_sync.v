module data_sync #( parameter width = 8, parameter num_stages = 2 ) (
    input [width-  1 : 0] async,
    input clk,
    input rst_n,
    input bus_enable,
    output reg [width - 1 : 0] sync,
    output reg enable_pulse
);

reg [num_stages - 1 : 0] stage;

integer i;

reg en_n;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for ( i = 0; i < num_stages; i = i + 1) begin
            stage[i] <= 0;
        end
        en_n <= 0;
        enable_pulse <= 0;
        sync <= {width{1'b0}};
    end
    else begin
        stage[0] <= bus_enable;
        for ( i = 1 ; i < num_stages; i = i + 1) begin
            stage[i] <= stage[i - 1];
        end
        en_n <= stage[num_stages - 1];
        enable_pulse <= stage[num_stages - 1] & !en_n;
    end
    if (enable_pulse) begin
        sync <= async;
    end
    else begin
        sync <= sync;
    end
end

endmodule
