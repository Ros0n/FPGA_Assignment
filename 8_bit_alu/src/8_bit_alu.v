/* 8 bit alu implementation */

module alu_8(
    input  [7:0] A,
    input  [7:0] B,
    input  [2:0] alu_sel,
    output [7:0] Result,
    output Carry,
    output Zero,
    output Sign,
    output Overflow
);

wire [7:0] add_out, sub_out, B_neg;
wire [7:0] and_out, or_out, xor_out, not_out;
wire [7:0] shl_out, shr_out;
wire add_carry, sub_carry;

assign B_neg  = ~B;
assign and_out = A & B;
assign or_out  = A | B;
assign xor_out = A ^ B;
assign not_out = ~A;
assign shl_out = A << 1;
assign shr_out = A >> 1;

// for adder
parallel_adder_8 ADD (.A(A),.B(B),.Cin(1'b0),.Sum(add_out),.Cout(add_carry)
);

//for subtractor
parallel_adder_8 SUB (.A(A),.B(B_neg),.Cin(1'b1),.Sum(sub_out),.Cout(sub_carry)
);

// 8 bit mux 
mux_8 MUX (.I0(add_out),
    .I1(sub_out),
    .I2(and_out),
    .I3(or_out),
    .I4(xor_out),
    .I5(not_out),
    .I6(shl_out),
    .I7(shr_out),
    .Sel(alu_sel),
    .O(Result)
);

assign Carry =
    (alu_sel == 3'b000) ? add_carry :
    (alu_sel == 3'b001) ? sub_carry :
                          1'b0;

assign Zero = (Result == 8'b00000000);
assign Sign = Result[7];

assign Overflow =
    (alu_sel == 3'b000) ? ((A[7] == B[7]) && (Result[7] != A[7])) : //for addition
    (alu_sel == 3'b001) ? ((A[7] != B[7]) && (Result[7] != A[7])) : //for subtraction
                          1'b0;

endmodule