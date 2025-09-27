module NextKey_tb;
	reg  [63:0] currentKey;
	wire [63:0] nextKey;

	NextKey uut (
		.currentKey(currentKey),
		.nextKey(nextKey)
	);

	initial begin
		$display("Time\tcurrentKey\t\tnextKey");
		$monitor("%0t\t%h\t%h", $time, currentKey, nextKey);

		currentKey = 64'h0123456789ABCDEF;
		#10;

		currentKey = 64'h0F0E0D0C0B0A0908;
		#10;

		$finish;
	end

endmodule
