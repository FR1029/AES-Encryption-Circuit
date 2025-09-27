module SBox_tb;
	reg  [3:0] in;
	wire [3:0] out;

	SBox uut (
		.in(in),
		.out(out)
	);

	integer i;

	initial begin
		$display("Time\tInput\tOutput");
		$monitor("%0t\t%h\t%h", $time, in, out);

		// Apply all 16 possible 4-bit inputs
		for (i = 0; i < 16; i = i + 1) begin
		in = i[3:0];
		#10;
		end

		$finish;
	end

endmodule
