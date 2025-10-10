`timescale 1ns/1ps

module slt_tb;

  // Testbench signals
  logic [31:0] a, b;
  logic [31:0] out;

  // DUT
  slt dut (
    .a   (a),
    .b   (b),
    .out (out)
  );

  // Simple task to apply a test and check the result
  task run_test(input int signed a_in, input int signed b_in);
    logic [31:0] expected;
    begin
      a = a_in;
      b = b_in;
      #1; // small delay to allow signals to propagate

      expected = (a_in < b_in) ? 32'hFFFF_FFFF : 32'h0000_0000;

      if (out !== expected) begin
        $error("FAIL: a=%0d b=%0d -> out=%h, expected %h",
                a_in, b_in, out, expected);
      end else begin
        $display("PASS: a=%0d b=%0d -> out=%h",
                  a_in, b_in, out);
      end
    end
  endtask

  initial begin
    $display("Starting SLT tests...");

    // Basic cases
    run_test( 10,  20);   // a < b
    run_test( 20,  10);   // a > b
    run_test( 15,  15);   // equal
    run_test(-5,   7);    // negative < positive
    run_test( 7,  -5);    // positive > negative
    run_test(-8,  -2);    // negative < less-negative
    run_test(-2,  -8);    // negative > more-negative

    // Edge values
    run_test(32'sh7FFF_FFFF, -1);  // largest positive vs -1
    run_test(-1, 32'sh7FFF_FFFF);  // -1 vs largest positive
    run_test(-32'sh8000_0000, 0);  // most negative vs 0
    run_test(0, -32'sh8000_0000);  // 0 vs most negative

    $display("All tests complete.");
    $finish;
  end

endmodule