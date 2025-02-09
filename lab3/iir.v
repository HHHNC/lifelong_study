module iir (
    rst,clk,din,dout
);
    input rst;
    input clk;
    input signed [11:0] din;
    output signed [11:0] dout;

    wire signed[20:0] Xout;
    zero zeroparallel(
        .rst(rst),
        .clk(clk),
        .Xin(din),
        .Xout(Xout)
    );
    wire signed[11:0] Yin;
    wire signed[25:0] Yout;
    
	 pole pole(
        .rst(rst),
        .clk(clk),
        .Yin(Yin),
        .Yout(Yout)    
    );

    wire signed[25:0] Ysum;
    assign Ysum = {{5{Xout[20]}},Xout} - Yout;

    wire signed [25:0] Ydiv;
    assign Ydiv = {{9{Ysum[25]}},Ysum[25:9]};

    assign Yin = (rst ?12'd0 : Ydiv[11:0]);
    assign dout = Yin;



endmodule






