module ShiftRows_tb;
    reg  [63:0] inState;
    wire [63:0] outState;

    ShiftRows uut (
        .currentState(inState),
        .nextState(outState)
    );

    initial begin
        $display("Time\t\tInput State\t\tOutput State");
        $monitor("%0t\t%h\t%h", $time, inState, outState);

        inState = 64'h0123456789ABCDEF; #10;
        inState = 64'h0011223344556677; #10;
        inState = 64'hFFEEDDCCBBAA9988; #10;

        $finish;
    end

endmodule
