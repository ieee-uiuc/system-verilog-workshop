// Code your testbench here
// or browse Examples
module testbench();

timeunit 10ns;

timeprecision 1ns;

logic clk;
logic reset;
logic button;

logic light;

light_switch light_switch0(.*);

always begin : CLOCK_GENERATION
  #1 clk = ~clk;
end

initial begin: CLOCK_INITIALIZATION
  clk = 0;
end

initial begin
    $dumpfile("dump.vcd"); $dumpvars;
end

initial begin: TEST
  #0 reset = 1;
     button = 0;

  #2 reset = 0;

  #2 button = 1;

  #2 button = 0;

  #4 button = 1;

  #2 button = 0;

  #4 button = 1;

  #8 button = 0;

  #6 reset = 1;

  #2 reset = 0;

  #2 reset = 1;

  $finish;
end

endmodule