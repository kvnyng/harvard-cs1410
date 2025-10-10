module and32_tb;
  logic [31:0] x, y;
  logic [31:0] z;

  // DUT instance
  and32 dut (
    .x(x),
    .y(y),
    .z(z)
  );

  initial begin
    // Case 1: all zeros
    x = 32'h00000000;
    y = 32'h00000000;
    #1;
    $display("x=%h y=%h z=%h", x, y, z);
    assert(z == (x & y)) else $error("Mismatch: x=%08x y=%08x z=%08x expected=%08x", x, y, z, (x & y));

    // Case 2: all ones
    x = 32'hFFFFFFFF;
    y = 32'hFFFFFFFF;
    #1;
    $display("x=%h y=%h z=%h", x, y, z);
    assert(z == (x & y)) else $error("Mismatch: x=%08x y=%08x z=%08x expected=%08x", x, y, z, (x & y));

    // Case 3: all 1's and then 0

    x = 32'hFFFFFFFF;
    y = 32'h00000000;
    #1;
    $display("x=%h y=%h z=%h", x, y, z);
    assert(z == (x & y))
    else $error("Mismatch: x=%08x y=%08x z=%08x expected=%08x", x, y, z, (x & y));

    // Case 4: alternating bits
    x = 32'hAAAAAAAA;  // 1010...
    y = 32'h55555555;  // 0101...
    #1;
    $display("x=%h y=%h z=%h", x, y, z);
    assert(z == (x & y))
    else $error("Mismatch: x=%08x y=%08x z=%08x expected=%08x", x, y, z, (x & y));

    // Case 5: random test
    repeat (5) begin
      x = $urandom();
      y = $urandom();
      #1;
      $display("x=%h y=%h z=%h", x, y, z);
      assert(z == (x & y)) else $error("Mismatch: x=%08x y=%08x z=%08x expected=%08x", x, y, z, (x & y));
    end

    $display("All tests passed.");
    $finish;
  end
endmodule