module pole (
    rst,clk,Yin,Yout
);
    
    input rst;
    input clk;
    input signed[11:0] Yin;
    output signed [11:0] Yout;
     //将数据存在寄存器Yin_reg 中
    reg signed[11:0] Yin_reg[6:0]; // 一共有七个这个的11bit的数字
    reg[3:0] i,j;
    always @(posedge clk or posedge rst) begin
        if(rst)
            begin
            for(i=0;i<7;i=i+1)
            Yin_reg[i] = 12'd0;
            end
        
        else
            begin 
            for(j=0;j<6;j=j+1)
            Yin_reg[j+1] <= Yin_reg[j];
            Yin_reg[0] <= Yin; //高的存的就是最先的数
            end
    end
 
 wire signed[11:0] coe[7:0];
 wire signed[22:0] mult_reg[6:0];
assign coe[1] = -12'd922;
assign coe[2] = 12'd1163;
assign coe[3] = -12'd811;
assign coe[4] = 12'd412;
assign coe[5] = -12'd122;
assign coe[6] = 12'd24;
assign coe[7] = -12'd2;

multc12 Umult1 (
    .dataa_0(coe[1]),
    .datab_0(Yin_reg[0]),
    .result(mult_reg[0])
);

multc12 Umult2 (
    .dataa_0(coe[2]),
    .datab_0(Yin_reg[1]),
    .result(mult_reg[1])
);

multc12 Umult3 (
    .dataa_0(coe[3]),
    .datab_0(Yin_reg[2]),
    .result(mult_reg[2])
);

multc12 Umult4 (
    .dataa_0(coe[4]),
    .datab_0(Yin_reg[3]),
    .result(mult_reg[3])
);


multc12 Umult5 (
    .dataa_0(coe[5]),
    .datab_0(Yin_reg[4]),
    .result(mult_reg[4])
);

multc12 Umult6 (
    .dataa_0(coe[6]),
    .datab_0(Yin_reg[5]),
    .result(mult_reg[5])
);

multc12 Umult7 (
    .dataa_0(coe[7]),
    .datab_0(Yin_reg[6]),
    .result(mult_reg[6])
);

assign Yout = {{3{mult_reg[0][22]}},mult_reg[0]} + {{3{mult_reg[1][22]}},mult_reg[1]} +
              {{3{mult_reg[2][22]}},mult_reg[2]} + {{3{mult_reg[3][22]}},mult_reg[3]} +
              {{3{mult_reg[4][22]}},mult_reg[4]} + {{3{mult_reg[5][22]}},mult_reg[5]} +
              {{3{mult_reg[6][22]}},mult_reg[6]};

endmodule