// 零点系数实现

module zero (
    rst,
    clk,
    Xin,
    Xout
);
    input rst;
    input clk;
    input signed [11:0] Xin;
    output signed [20:0] Xout;

    //将数据存在寄存器Xin_reg 中
    reg signed[11:0] Xin_reg[6:0];
    reg[3:0] i,j;
    always @(posedge clk or posedge rst) begin
        if(rst)
            begin
				//清空寄存器
            for(i=0;i<7;i=i+1)
            Xin_reg[i] = 12'd0;
            end
        
        else
            begin 
            for(j=0;j<6;j=j+1)
            Xin_reg[j+1] <= Xin_reg[j];
            Xin_reg[0] <= Xin;
            end
    end
	 
	 
	 /*Qb的数据是对称的 7 21 42 56 56 42 21 7*/
    // 将对称输入相加起来
    wire signed[12:0] add_reg[3:0];
    assign add_reg[0] = {Xin[11],Xin} + {Xin_reg[6][11],Xin_reg[6]};
    assign add_reg[1] = {Xin_reg[0][11],Xin_reg[0]} + {Xin_reg[5][11],Xin_reg[5]};
    assign add_reg[2] = {Xin_reg[1][11],Xin_reg[1]} + {Xin_reg[4][11],Xin_reg[4]};
    assign add_reg[3] = {Xin_reg[2][11],Xin_reg[2]} + {Xin_reg[3][11],Xin_reg[3]};

    //移位运算 加法运算 实现乘法
    wire signed[20:0] mult_reg[3:0];
    assign mult_reg[0] = {{6{add_reg[0][12]}},add_reg[0],2'd0} + {{7{add_reg[0][12]}},add_reg[0],1'd0} + {{8{add_reg[0][12]}},add_reg[0]}; // *7 
    assign mult_reg[1] = {{4{add_reg[1][12]}},add_reg[1],4'd0} + {{6{add_reg[1][12]}},add_reg[1],2'd0} + {{8{add_reg[1][12]}},add_reg[1]}; // *21
    assign mult_reg[2] = {{3{add_reg[2][12]}},add_reg[2],5'd0} + {{5{add_reg[2][12]}},add_reg[2],3'd0} + {{7{add_reg[2][12]}},add_reg[2],1'd0}; // *42 
    assign mult_reg[3] = {{3{add_reg[3][12]}},add_reg[3],5'd0} + {{7{add_reg[3][12]}},add_reg[3],4'd0} + {{5{add_reg[3][12]}},add_reg[3],3'd0}; // *56
    
    assign Xout = mult_reg[0] + mult_reg[1] + mult_reg[2] + mult_reg[3] ;
endmodule