`timescale 1ns/1ps

module tb_key_expansion();

  // DUT signals
  reg clk_120MHz;
  reg reset_n;
  reg [0:127] key_vector;
  reg [0:3]   rc_sig;
  reg ff1_en;
  wire [0:127] round_key;

  // Instantiate DUT
  key_expansion uut (
    .clk_120MHz(clk_120MHz),
    .reset_n(reset_n),
    .key_vector(key_vector),
    .rc_sig(rc_sig),
    .ff1_en(ff1_en),
    .round_key(round_key)
  );

    initial #2000 $finish;

  // Clock generation (120 MHz ≈ 8.3 ns period, just use 10 ns for sim)
  always #5 clk_120MHz = ~clk_120MHz;

  // Test procedure
  initial begin
    // Initialize
    clk_120MHz = 0;
    reset_n = 0;
    ff1_en = 0;
    key_vector = 128'b0;
    rc_sig = 4'b0000;

    // Reset
    #20;
    reset_n = 1;

    // Apply initial key (AES-128 test vector)
    key_vector = 128'h2b7e151628aed2a6abf7158809cf4f3c;

    // Enable FFs to load key
    ff1_en = 1;
    rc_sig = 4'b0000;  // initial load
    #10; ff1_en = 0;
    #40 ff1_en = 1;
    rc_sig = 4'b0001;
    #10; ff1_en = 0;
    rc_sig = 4'b0010;
    #40; ff1_en = 1;
    rc_sig = 4'b0011;
    #10; ff1_en = 0;
    
    /*@(posedge clk_120MHz);
    @(posedge clk_120MHz);
    $display("Round 0 key = %h", round_key);

    // ---- Round 1 ----
    rc_sig = 4'b0001;
    @(posedge clk_120MHz);
    @(posedge clk_120MHz);
    $display("Round 1 key = %h", round_key);

    // ---- Round 2 ----
    rc_sig = 4'b0010;
    @(posedge clk_120MHz);
    //@(posedge clk_120MHz);
    $display("Round 2 key = %h", round_key);

    // ---- Round 3 ----
    rc_sig = 4'b0011;
    @(posedge clk_120MHz);
    //@(posedge clk_120MHz);
    $display("Round 3 key = %h", round_key);

    #50;
    $finish;*/
  end

endmodule
