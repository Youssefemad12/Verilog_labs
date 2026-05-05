module control_unit(
    input clk_120MHz,
    input reset_n,
    input start,
    output reg rounds_mux1,
    output reg rounds_mux2,
    output reg key_en,
    output reg rounds_en,
    output reg[0:3] rc_sig,
    output reg data_valid
);
localparam idle = 0, round0 = 1, round1 = 2, round2 = 3, round3 = 4,
round4 = 5, round5 = 6, round6 = 7, round7 = 8, round8 = 9,
round9 = 10, round10 = 11, round11 = 12;
reg [3:0] current_state, next_state;
reg [0:3] current_count, next_count;

always @(posedge clk_120MHz or negedge reset_n) begin
    if (!reset_n) begin
        current_state <= idle;
        current_count <= 0;
    end
    else begin
        current_state <= next_state;
        current_count <= next_count;
    end
end

always @(*) begin
    rc_sig = 0;
    rounds_mux1 = 0;
    rounds_mux2 = 0;
    key_en = 0;
    rounds_en = 0;
    next_count = 0;
    data_valid = 0;
    next_state = current_state;
    case (current_state)
        idle: begin
            if (start)
                next_state = round0;
            else
                next_state = idle;
        end
        round0: begin
            key_en = (current_count < 3) ? 1 : 0;
            rounds_en = 0;
            rounds_mux1 = 0;
            rounds_mux2 = 0;
            rc_sig = 4'b0000;
            rounds_en = (current_count >= 4) ? 1 : 0;
            if (current_count == 5) begin
                next_state = round1;
                next_count = 0;
            end
            else begin
                next_count = current_count + 1;
                next_state = round0;
            end
        end
        round1: begin
            key_en = (current_count < 3) ? 1 : 0;
            rounds_mux1 = 1;
            rounds_mux2 = 0;
            rc_sig = 4'b0001;
            rounds_en = (current_count >= 4) ? 1 : 0;
            if (current_count == 5) begin
                next_state = round2;
                next_count = 0;
            end
            else begin
                next_count = current_count + 1;
                next_state = round1;
            end
        end
        round2: begin
            key_en = (current_count < 3) ? 1 : 0;
            rounds_mux1 = 1;
            rounds_mux2 = 0;
            rc_sig = 4'b0010;
            rounds_en = (current_count >= 4) ? 1 : 0;
            if (current_count == 5) begin
                next_state = round3;
                next_count = 0;
            end
            else begin
                next_count = current_count + 1;
                next_state = round2;
            end
        end
        round3: begin
            key_en = (current_count < 3) ? 1 : 0;
            rounds_mux1 = 1;
            rounds_mux2 = 0;
            rc_sig = 4'b0011;
            rounds_en = (current_count >= 4) ? 1 : 0;
            if (current_count == 5) begin
                next_state = round4;
                next_count = 0;
            end
            else begin
                next_count = current_count + 1;
                next_state = round3;
            end
        end
        round4: begin
            key_en = (current_count < 3) ? 1 : 0;
            rounds_mux1 = 1;
            rounds_mux2 = 0;
            rc_sig = 4'b0100;
            rounds_en = (current_count >= 4) ? 1 : 0;
            if (current_count == 5) begin
                next_state = round5;
                next_count = 0;
            end
            else begin
                next_count = current_count + 1;
                next_state = round4;
            end
        end
        round5: begin
            key_en = (current_count < 3) ? 1 : 0;
            rounds_mux1 = 1;
            rounds_mux2 = 0;
            rc_sig = 4'b0101;
            rounds_en = (current_count >= 4) ? 1 : 0;
            if (current_count == 5) begin
                next_state = round6;
                next_count = 0;
            end
            else begin
                next_count = current_count + 1;
                next_state = round5;
            end
        end
        round6: begin
            key_en = (current_count < 3) ? 1 : 0;
            rounds_mux1 = 1;
            rounds_mux2 = 0;
            rc_sig = 4'b0110;
            rounds_en = (current_count >= 4) ? 1 : 0;
            if (current_count == 5) begin
                next_state = round7;
                next_count = 0;
            end
            else begin
                next_count = current_count + 1;
                next_state = round6;
            end
        end
        round7: begin
            key_en = (current_count < 3) ? 1 : 0;
            rounds_mux1 = 1;
            rounds_mux2 = 0;
            rc_sig = 4'b0111;
            rounds_en = (current_count >= 4) ? 1 : 0;
            if (current_count == 5) begin
                next_state = round8;
                next_count = 0;
            end
            else begin
                next_count = current_count + 1;
                next_state = round7;
            end
        end
        round8: begin
            key_en = (current_count < 3) ? 1 : 0;
            rounds_mux1 = 1;
            rounds_mux2 = 0;
            rc_sig = 4'b1000;
            rounds_en = (current_count >= 4) ? 1 : 0;
            if (current_count == 5) begin
                next_state = round9;
                next_count = 0;
            end
            else begin
                next_count = current_count + 1;
                next_state = round8;
            end
        end
        round9: begin
            key_en = (current_count < 3) ? 1 : 0;
            rounds_mux1 = 1;
            rounds_mux2 = 0;
            rc_sig = 4'b1001;
            rounds_en = (current_count >= 4) ? 1 : 0;
            if (current_count == 5) begin
                next_state = round10;
                next_count = 0;
            end
            else begin
                next_count = current_count + 1;
                next_state = round9;
            end
        end
        round10: begin
            key_en = (current_count < 3) ? 1 : 0;
            rounds_mux1 = 1;
            rounds_mux2 = (current_count < 2) ? 0 : 1;
            rounds_en = (current_count >= 4) ? 1 : 0;
            rc_sig = 4'b1010;
            if (current_count == 5) begin
                next_state = round11;
                next_count = 0;
            end
            else begin
                next_count = current_count + 1;
                next_state = round10;
            end
        end
        round11: begin
            rounds_mux1 = 0;
            rounds_mux2 = 0;
            rounds_en = 0;
            rc_sig = 4'b0000;
            data_valid = 1;
            next_state = idle;
        end
        default: begin
            next_state = idle;
        end
    endcase
end

endmodule
