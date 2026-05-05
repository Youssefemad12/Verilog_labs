module register_file(
input clk,
input rst_n,
input wr_en,rd_en,
input [2:0]adr,
input [15:0]wr_data,
output reg [15:0]rd_data
);

reg [15:0]reg_file[7:0];

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n) begin
        for(integer i = 0; i < 8; i = i + 1)begin
            reg_file[i] <= 16'b0;
    end
    end
    else if(wr_en) begin
        reg_file[adr] <= wr_data;
    end
    else if(rd_en) begin
        rd_data <= reg_file[adr];
    end
end
endmodule
