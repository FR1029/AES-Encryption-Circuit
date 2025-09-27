`timescale 1ns/1ps

module encrypt_tb;
    
    reg  [63:0] plaintext;
    reg  [63:0] secretKey;
    wire [63:0] ciphertext;

    Encrypt dut (
        .plaintext (plaintext),
        .secretKey (secretKey),
        .ciphertext(ciphertext)
    );

    initial begin

        $display("==============================================");

        plaintext = 64'h0000_0000_0000_0000;
        secretKey = 64'h0000_0000_0000_0000;
        #1;
        $display("Expected = 0000000000000000, Got = %h", ciphertext);

        plaintext = 64'h1111_1111_1111_1111;
        secretKey = 64'h2222_2222_2222_2222;
        #1;
        $display("Expected = 4444444444444444, Got = %h", ciphertext);

        plaintext = 64'h0123_4567_89AB_CDEF;
        secretKey = 64'hFEDC_BA98_7654_3210;
        #1;
        $display("Expected = 45bc9893e023ce4c, Got = %h", ciphertext);

        plaintext = 64'hFFFF_FFFF_FFFF_FFFF;
        secretKey = 64'h0000_0000_0000_0000;
        #1;
        $display("Expected = ffffffffffffffff, Got = %h", ciphertext);

        plaintext = 64'h1234_5678_9ABC_DEF0;
        secretKey = 64'h0F0E_0D0C_0B0A_0908;
        #1;
        $display("Expected = d3c1dd245d97f54a, Got = %h", ciphertext);

        plaintext = 64'h0A1B_2C3D_4E5F_6071;
        secretKey = 64'h89AB_CDEF_0123_4567;
        #1;
        $display("Expected = 3848329f921f3b90, Got = %h", ciphertext);

        $display("==============================================");
        $finish;

    end

endmodule
