module up_dn_counter(
    input clk,
    input load,up,down,
    input [4:0] in,
    output  high,low,
    output  reg [4:0] counter
);

always@(posedge clk) begin
    if (load) begin
        counter <= in;
    end else if (down) begin
        if (counter == 5'b00000)begin
            counter <= 5'b00000;
        end else begin
            counter <= counter - 1;
        end
    end else if (up) begin
        if (counter == 5'b11111) begin
            counter <= 5'b11111;
        end else begin
            counter <= counter + 1;
        end
    end
end

assign low = (counter == 5'b00000);
assign high = (counter == 5'b11111);

endmodule
