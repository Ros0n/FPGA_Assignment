module parallel_adder_8(
    input [7:0] A,
    input [7:0] B,
    input Cin,
    output [7:0] Sum,
    output Cout
);

    wire c1, c2, c3, c4, c5, c6, c7;

    full_adder fa1(
        .a(A[0]),
        .b(B[0]),
        .cin(Cin),
        .sum(Sum[0]),
        .cout(c1)
    );

    full_adder fa2(
        .a(A[1]),
        .b(B[1]),
        .cin(c1),
        .sum(Sum[1]),
        .cout(c2)
    );

    full_adder fa3(
        .a(A[2]),
        .b(B[2]),
        .cin(c2),
        .sum(Sum[2]),
        .cout(c3)
    );

    full_adder fa4(
        .a(A[3]),
        .b(B[3]),
        .cin(c3),
        .sum(Sum[3]),
        .cout(c4)
    );

    full_adder fa5(
        .a(A[4]),
        .b(B[4]),
        .cin(c4),
        .sum(Sum[4]),
        .cout(c5)
    );

    full_adder fa6(
        .a(A[5]),
        .b(B[5]),
        .cin(c5),
        .sum(Sum[5]),
        .cout(c6)
    );

    full_adder fa7(
        .a(A[6]),
        .b(B[6]),
        .cin(c6),
        .sum(Sum[6]),
        .cout(c7)
    );

    full_adder fa8(
        .a(A[7]),
        .b(B[7]),
        .cin(c7),
        .sum(Sum[7]),
        .cout(Cout)
    );

endmodule


