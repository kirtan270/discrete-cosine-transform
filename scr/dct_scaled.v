// 16-point DCT-II, ?-scaling is already inside the ROM
module dct16_scaled #(
    parameter N = 16
)(
    input  wire                    ck,

    input  wire signed [15:0] xin0,  xin1,  xin2,  xin3,
    input  wire signed [15:0] xin4,  xin5,  xin6,  xin7,
    input  wire signed [15:0] xin8,  xin9,  xin10, xin11,
    input  wire signed [15:0] xin12, xin13, xin14, xin15,

    output reg  signed [15:0] X0,  X1,  X2,  X3,
    output reg  signed [15:0] X4,  X5,  X6,  X7,
    output reg  signed [15:0] X8,  X9,  X10, X11,
    output reg  signed [15:0] X12, X13, X14, X15
);

    // ---------- flat ROM : coeff_scaled.mem ----------
    reg signed [15:0] rom [0:N*N-1];
    initial $readmemh("coeff_scaled.mem", rom);

    // ---------- local buffers ----------
    reg signed [15:0] x [0:N-1];
    reg signed [47:0] acc;
    integer k,n;

    always @(posedge ck) begin
        // latch inputs
        {x[0],  x[1],  x[2],  x[3],
         x[4],  x[5],  x[6],  x[7],
         x[8],  x[9],  x[10], x[11],
         x[12], x[13], x[14], x[15]} <=
        {xin0,  xin1,  xin2,  xin3,
         xin4,  xin5,  xin6,  xin7,
         xin8,  xin9,  xin10, xin11,
         xin12, xin13, xin14, xin15};

        // MAC with scaled coefficients (no ? multiply)
        for (k = 0; k < N; k = k + 1) begin
            acc = 0;
            for (n = 0; n < N; n = n + 1)
                acc = acc + x[n] * rom[k*N + n];   // Q2.30
            acc = acc >>> 15;                      // ? Q1.15

            // pack
            case (k)
                0:  X0  <= acc[15:0];
                1:  X1  <= acc[15:0];
                2:  X2  <= acc[15:0];
                3:  X3  <= acc[15:0];
                4:  X4  <= acc[15:0];
                5:  X5  <= acc[15:0];
                6:  X6  <= acc[15:0];
                7:  X7  <= acc[15:0];
                8:  X8  <= acc[15:0];
                9:  X9  <= acc[15:0];
                10: X10 <= acc[15:0];
                11: X11 <= acc[15:0];
                12: X12 <= acc[15:0];
                13: X13 <= acc[15:0];
                14: X14 <= acc[15:0];
                15: X15 <= acc[15:0];
            endcase
        end
    end
endmodule
