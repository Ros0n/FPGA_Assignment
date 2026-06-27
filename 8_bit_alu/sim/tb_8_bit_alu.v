`timescale 1ns / 1ps

module tb_alu_8;

    // Inputs
    reg [7:0] A;
    reg [7:0] B;
    reg [2:0] alu_sel;

    // Outputs
    wire [7:0] Result;
    wire       Carry;
    wire       Zero;
    wire       Sign;
    wire       Overflow;

    // Instantiate the Unit Under Test (UUT)
    alu_8 uut (
        .A(A),
        .B(B),
        .alu_sel(alu_sel),
        .Result(Result),
        .Carry(Carry),
        .Zero(Zero),
        .Sign(Sign), // Mapped to 'Sign' for your testbench wire
        .Overflow(Overflow)
    );

    // Continuous Monitoring Block
    initial begin
        // Prints a header line for readability
        $display("\nTime | Sel |   A    |   B    | Result | C Z S O");
        $display("------------------------------------------------");
        
        // This monitors specified signals and prints whenever any of them change
        $monitor("%4dns | %b | %d (0x%h) | %d (0x%h) | %d (0x%h) | %b %b %b %b", 
                 $time, alu_sel, A, A, B, B, Result, Result, Carry, Zero, Sign, Overflow);
    end

    initial begin
        // Setup file generation for GTKWave
        $dumpfile("alu_8_sim.vcd");
        $dumpvars(0, tb_alu_8);

        // Initialize Inputs
        A = 8'h00; B = 8'h00; alu_sel = 3'b000;
        #10;
        
        // --- Test Case 1: Addition (3'b000) ---
        $display("\n--- Testing Addition ---");
        A = 8'd45;  B = 8'd15;  alu_sel = 3'b000; #10; // Normal Add: Result=60
        A = 8'd200; B = 8'd100; alu_sel = 3'b000; #10; // Carry out: Result=44, Carry=1
        A = 8'd120; B = 8'd10;  alu_sel = 3'b000; #10; // Overflow: 120+10=130

        // --- Test Case 2: Subtraction (3'b001) ---
        $display("\n--- Testing Subtraction ---");
        A = 8'd50;  B = 8'd20;  alu_sel = 3'b001; #10; // Normal Sub: Result=30
        A = 8'd10;  B = 8'd20;  alu_sel = 3'b001; #10; // Sign Result: Result=-10 (8'hF6), Sign=1
        A = 8'd120; B = -8'd10; alu_sel = 3'b001; #10; // Overflow: 120 - (-10) = 130 

        // --- Test Case 3: AND (3'b010) ---
        $display("\n--- Testing AND ---");
        A = 8'b10101010; B = 8'b11110000; alu_sel = 3'b010; #10;

        // --- Test Case 4: OR (3'b011) ---
        $display("\n--- Testing OR ---");
        A = 8'b10101010; B = 8'b11110000; alu_sel = 3'b011; #10;

        // --- Test Case 5: XOR (3'b100) ---
        $display("\n--- Testing XOR ---");
        A = 8'b10101010; B = 8'b11110000; alu_sel = 3'b100; #10;

        // --- Test Case 6: NOT A (3'b101) ---
        $display("\n--- Testing NOT ---");
        A = 8'hF0; alu_sel = 3'b101; #10;

        // --- Test Case 7: Shift Left (3'b110) ---
        $display("\n--- Testing Shift Left ---");
        A = 8'h81; alu_sel = 3'b110; #10;

        // --- Test Case 8: Shift Right (3'b111) ---
        $display("\n--- Testing Shift Right ---");
        A = 8'h81; alu_sel = 3'b111; #10;
        
        // --- Test Case 9: Zero Flag Check ---
        $display("\n--- Testing Zero Flag ---");
        A = 8'd25; B = 8'd25; alu_sel = 3'b001; #10;

        $display("\nSimulation Finished.");
        $finish;
    end
      
endmodule