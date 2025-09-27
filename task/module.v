module Encrypt(
    input  [63:0] plaintext,
    input  [63:0] secretKey,
    output [63:0] ciphertext
);
    wire [63:0] state [0:10];
    wire [63:0] key [0:10];
    assign key[0] = secretKey;
    AddRoundKey a(plaintext, secretKey, state[0]);
    genvar i;
    generate
        for (i=1; i<=10; i=i+1) begin
            NextKey nk(key[i-1], key[i]);
            Round r(state[i-1], key[i], state[i]);
        end
    endgenerate
    assign ciphertext = state[10];
endmodule

module Round(
    input  [63:0] currentState ,
    input  [63:0] roundKey     ,
    output [63:0] nextState    
);
    wire [63:0] tmp1, tmp2;
    genvar i;
    generate
        for (i=0; i<16; i=i+1) begin
            SBox s(currentState[63-4*i -: 4], tmp1[63-4*i -: 4]);
        end
    endgenerate
    ShiftRows sh(tmp1, tmp2);
    AddRoundKey r(tmp2, roundKey, nextState);
endmodule

module SBox(
    input [3:0]in ,
    output [3:0]out
);
    assign out[3] = (~in[2]&~in[1]&(in[3]^in[0])) | (in[2]&((~in[3]&~in[0]) | (in[3]&in[0]))) | in[1]&in[0]&(in[3] | in[2]);
    assign out[2] = (~in[3]&~in[1]&~in[0]) | (~in[3]&in[2]&~in[0]) | (in[3]&in[2]&~in[1]) | (in[3]&~in[2]&in[1]) | (~in[2]&in[1]&in[0]);
    assign out[1] = (~in[1]&in[0]) | (~in[2]&~in[1]&~in[0]) | (in[3]&~in[2]&~in[0]) | (~in[3]&in[2]&in[1]&~in[0]);
    assign out[0] = (in[2]&~in[1]&~in[0]) | (~in[3]&~in[1]&in[0]) | (in[3]&in[2]&in[1]) | (in[2]&in[1]&~in[0]) | (in[3]&in[1]&~in[0]);
endmodule

module NextKey(
    input  [63:0] currentKey,
    output [63:0] nextKey
);
    assign nextKey = { currentKey[59:0], currentKey[63:60] };
endmodule

module ShiftRows(
    input  [63:0] currentState ,
    output [63:0] nextState    
);
    assign nextState = { currentState[59:48], 
                         currentState[63:60],
                         currentState[39:32],
                         currentState[47:40],
                         currentState[19:16],
                         currentState[31:20],
                         currentState[15:0] };

endmodule

module AddRoundKey(
    input  [63:0] currentState ,
    input  [63:0] roundKey     ,
    output [63:0] nextState    
);
    assign nextState = currentState^roundKey;
endmodule
