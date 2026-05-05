module pass_lock_fsm #(parameter [7:0] pass = 8'b11010010)(
    input clk,
    input reset_n,
    input en,
    input pass_in,
    output reg unlock,
    output reg fail
);
localparam idle = 0,check0 = 1,check1 = 2,check2 = 3,check3 = 4,
check4 = 5,check5 = 6,check6 = 7,check7 = 8,unlock_state = 9,fail_state = 10;


reg [3:0]current_state, next_state;
reg [2:0] current_count = 3'b000, next_count;

always @(posedge clk , negedge reset_n)begin
    if (!reset_n) begin
        current_state <= idle;
        current_count <= 3'b000;
    end
    else begin
        current_state <= next_state;
        current_count <= next_count;
    end
end

always@(*) begin
    unlock = 0;
    fail = 0;
    next_count = 0;
    case(current_state)
        idle: begin
            if(en)
                next_state = check0;
            else
                next_state = idle;
        end
        check0: begin
            if(pass_in == pass[0])
                next_state = check1;
            else
                next_state = fail_state;
        end
        check1: begin
            if(pass_in == pass[1])
                next_state = check2;
            else
                next_state = fail_state;
        end
        check2: begin
            if(pass_in == pass[2])
                next_state = check3;
            else
                next_state = fail_state;
        end
        check3: begin
            if(pass_in == pass[3])
                next_state = check4;
            else
                next_state = fail_state;
        end
        check4: begin
            if(pass_in == pass[4])
                next_state = check5;
            else
                next_state = fail_state;
        end
        check5: begin
            if(pass_in == pass[5])
                next_state = check6;
            else
                next_state = fail_state;
        end
        check6: begin
            if(pass_in == pass[6])
                next_state = check7;
            else
                next_state = fail_state;
        end
        check7: begin
            if(pass_in == pass[7])
                next_state = unlock_state;
            else
                next_state = fail_state;
        end
        unlock_state: begin
            unlock = 1;
            if(current_count == 5) begin
            next_state = idle;
            end
            else begin
            next_count = current_count + 1;
            next_state = unlock_state;
            end
        end
        fail_state: begin
            fail = 1;
            if(current_count == 5)begin
            next_state = idle;
            end
            else begin
            next_count = current_count + 1;
            next_state = fail_state;
            end
        end
        default: begin 
            next_state = idle;
            unlock = 0;
            fail = 0;
            next_count = 0;
        end
    endcase
end

endmodule
