module tb_mix_columns();
    reg [0:31] in;
    wire [0:31] out;

    mix_columns uut(.in(in), .out(out));

    initial begin
        // Explicitly set bytes top->bottom: r1=0xD4, r2=0xE0, r3=0xB8, r4=0x1E
        in = 32'hD4E0B81E;
        #1;
        $display("in bytes : %02h %02h %02h %02h", in[0:7], in[8:15], in[16:23], in[24:31]);
        $display("out bytes: %02h %02h %02h %02h", out[0:7], out[8:15], out[16:23], out[24:31]);
        $stop;
    end
endmodule
