`timescale 1ns/100ps
module fft8 (clk,rstn,en,seg8,BT,key);

	 input                    clk;
	 input                    rstn;
	 input                    en;
	 input              		  key;
	 output     				  seg8;
	 output      				  BT;
	 reg [7:0]       			  seg8;
	 reg [7:0]   				  BT;
	 reg [2:0]                 cnt8;
	 reg [3:0]                a;
	 reg [3:0]                r1,m1;
	 reg [3:0]                r2,m2;
	 reg [3:0]                r3,m3;
	 reg [3:0]                r4,m4;
	 reg                     counter ;

	//operating data
	wire signed [23:0]             xm_real [3:0] [7:0];
	wire signed [23:0]             xm_imag [3:0] [7:0];
	wire                           en_connect [15:0] ;
	assign                         en_connect[0] = en;
	assign                         en_connect[1] = en;
	assign                         en_connect[2] = en;
	assign                         en_connect[3] = en;

	//factor, multiplied by 0x2000
	wire signed [15:0]             factor_real [3:0] ;
	wire signed [15:0]             factor_imag [3:0];
	assign factor_real[0]        = 16'h2000; //1
	assign factor_imag[0]        = 16'h0000; //0
	assign factor_real[1]        = 16'h16a0; //sqrt(2)/2
	assign factor_imag[1]        = 16'he95f; //-sqrt(2)/2
	assign factor_real[2]        = 16'h0000; //0
	assign factor_imag[2]        = 16'he000; //-1
	assign factor_real[3]        = 16'he95f; //-sqrt(2)/2
	assign factor_imag[3]        = 16'he95f; //-sqrt(2)/2

	
	 wire signed [23:0]      x0_real;
	 wire signed [23:0]      x0_imag;
	 wire signed [23:0]      x1_real;
	 wire signed [23:0]      x1_imag;
	 wire signed [23:0]      x2_real;
	 wire signed [23:0]      x2_imag;
	 wire signed [23:0]      x3_real;
	 wire signed [23:0]      x3_imag;
	 wire signed [23:0]      x4_real;
	 wire signed [23:0]      x4_imag;
	 wire signed [23:0]      x5_real;
	 wire signed [23:0]      x5_imag;
	 wire signed [23:0]      x6_real;
	 wire signed [23:0]      x6_imag;
	 wire signed [23:0]      x7_real;
	 wire signed [23:0]      x7_imag;


	 wire                   valid;
	 wire signed [23:0]     y0_real;
	 wire signed [23:0]     y0_imag;
	 wire signed [23:0]     y1_real;
	 wire signed [23:0]     y1_imag;
	 wire signed [23:0]     y2_real;
	 wire signed [23:0]     y2_imag;
	 wire signed [23:0]     y3_real;
	 wire signed [23:0]     y3_imag;
	 wire signed [23:0]     y4_real;
	 wire signed [23:0]     y4_imag;
	 wire signed [23:0]     y5_real;
	 wire signed [23:0]     y5_imag;
	 wire signed [23:0]     y6_real;
	 wire signed [23:0]     y6_imag;
	 wire signed [23:0]     y7_real;
	 wire signed [23:0]     y7_imag;


	assign x0_real = 0;
	assign x0_imag = 1;

	assign x1_real = 0;
	assign x1_imag = 1;

	assign x2_real = 0;
	assign x2_imag = 1;

	assign x3_real = 0;
	assign x3_imag = 1;

	assign x4_real = 0;
	assign x4_imag = 1;

	assign x5_real = 0;
	assign x5_imag = 1;

	assign x6_real = 0;
	assign x6_imag = 1;

	assign x7_real = 0;
	assign x7_imag = 1;


   //input initial
   assign xm_real[0][0] = x0_real;
   assign xm_real[0][1] = x4_real;
   assign xm_real[0][2] = x2_real;
   assign xm_real[0][3] = x6_real;
   assign xm_real[0][4] = x1_real;
   assign xm_real[0][5] = x5_real;
   assign xm_real[0][6] = x3_real;
   assign xm_real[0][7] = x7_real;

   assign xm_imag[0][0] = x0_imag;
   assign xm_imag[0][1] = x4_imag;
   assign xm_imag[0][2] = x2_imag;
   assign xm_imag[0][3] = x6_imag;
   assign xm_imag[0][4] = x1_imag;
   assign xm_imag[0][5] = x5_imag;
   assign xm_imag[0][6] = x3_imag;
   assign xm_imag[0][7] = x7_imag;

   //butter instantiaiton
   //integer              index[11:0] ;
   genvar               m, k;
   generate
      //3 stage
      for(m=0; m<=2; m=m+1) begin: stage
         for (k=0; k<=3; k=k+1) begin: unit
            /*
            always@ (*) begin
               index[4*m+k] = (k[m:0]) < (1<<m) ?
                              //<<(m+1), * 2^(m+1), length outside of group
                              (k[3:m] << (m+1)) + k[m:0] :
                              //1<<m, * 2^m, unit num in group
                              (k[3:m] << (m+1)) + (k[m:0]-(1<<m)) ;
            end
            */

            butterfly           u_butter(
               .clk         (clk                                      ) ,
               .rstn        (rstn                                     ) ,
               .en          (en_connect[m*4 + k]                      ) ,

                //input data
               .xp_real     (xm_real[ m ] [k[m:0] < (1<<m) ?
                                           (k[3:m] << (m+1)) + k[m:0] :
                                           (k[3:m] << (m+1)) + (k[m:0]-(1<<m))] ),
               .xp_imag     (xm_imag[ m ] [k[m:0] < (1<<m) ?
                                           (k[3:m] << (m+1)) + k[m:0] :
                                           (k[3:m] << (m+1)) + (k[m:0]-(1<<m))] ),
               .xq_real     (xm_real[ m ] [(k[m:0] < (1<<m) ?
                                           (k[3:m] << (m+1)) + k[m:0] :
                                           (k[3:m] << (m+1)) + (k[m:0]-(1<<m))) + (1<<m) ]),
               .xq_imag     (xm_imag[ m ] [(k[m:0] < (1<<m) ?
                                            (k[3:m] << (m+1)) + k[m:0] :
                                            (k[3:m] << (m+1)) + (k[m:0]-(1<<m))) + (1<<m) ]),

               .factor_real (factor_real[k[m:0]<(1<<m)? k[m:0] : k[m:0]-(1<<m) ]),
               .factor_imag (factor_imag[k[m:0]<(1<<m)? k[m:0] : k[m:0]-(1<<m) ]),

               //output data
               .valid       (en_connect[ (m+1)*4 + k ]                ),
               .yp_real     (xm_real[ m+1 ][k[m:0] < (1<<m) ?
                                            (k[3:m] << (m+1)) + k[m:0] :
                                            (k[3:m] << (m+1)) + (k[m:0]-(1<<m))] ),
               .yp_imag     (xm_imag[ m+1 ][(k[m:0]) < (1<<m) ?
                                            (k[3:m] << (m+1)) + k[m:0] :
                                            (k[3:m] << (m+1)) + (k[m:0]-(1<<m))] ),
               .yq_real     (xm_real[ m+1 ][(k[m:0] < (1<<m) ?
                                            (k[3:m] << (m+1)) + k[m:0] :
                                            (k[3:m] << (m+1)) + (k[m:0]-(1<<m))) + (1<<m) ]),
               .yq_imag     (xm_imag[ m+1 ][((k[m:0]) < (1<<m) ?
                                            (k[3:m] << (m+1)) + k[m:0] :
                                            (k[3:m] << (m+1)) + (k[m:0]-(1<<m))) + (1<<m) ])
             );
         end
      end
   endgenerate

   assign     valid = en_connect[12];
   assign     y0_real = xm_real[3][0] ;
   assign     y0_imag = xm_imag[3][0] ;
   assign     y1_real = xm_real[3][1] ;
   assign     y1_imag = xm_imag[3][1] ;
   assign     y2_real = xm_real[3][2] ;
   assign     y2_imag = xm_imag[3][2] ;
   assign     y3_real = xm_real[3][3] ;
   assign     y3_imag = xm_imag[3][3] ;
   assign     y4_real = xm_real[3][4] ;
   assign     y4_imag = xm_imag[3][4] ;
   assign     y5_real = xm_real[3][5] ;
   assign     y5_imag = xm_imag[3][5] ;
   assign     y6_real = xm_real[3][6] ;
   assign     y6_imag = xm_imag[3][6] ;
   assign     y7_real = xm_real[3][7] ;
   assign     y7_imag = xm_imag[3][7] ;
	
	
	
	/*
	  按键
	  1.不按下时，会显示第一二组的实部 和虚部
	  2.第一次按下会显示第三四组的实部 和虚部
	
	*/
	always@(posedge clk ) begin 
	
//	   cnt8<=cnt8 + 1'b1; 
		
		if(!rstn)
		begin
			r1<= 4'b0000;
			m1<= 4'b0000;
			r2<= 4'b0000;
			m2<= 4'b0000;
			r3<= 4'b0000;
			m3<= 4'b0000;
			r4<= 4'b0000;
			m4<= 4'b0000;

		end

		
//			counter <= counter + 1;
			else if(counter == 0) begin
				r1 <= y0_real/1;
				m1 <= y0_imag/1;
				r2 <= y1_real/1;
				m2 <= y1_imag/1;
				r3 <= y2_real/1;
				m3 <= y2_imag/1;
				r4 <= y3_real/1;
				m4 <= y3_imag/1;
			end
			else if(counter ==1) begin
				r1 <= y4_real/1;
				m1 <= y4_imag/1;
				r2 <= y5_real/1;
				m2 <= y5_imag/1;
				r3 <= y6_real/1;
				m3 <= y6_imag/1;
				r4 <= y7_real/1;
				m4 <= y7_imag/1;
//				counter <= 0;
			end
			
	end 
	
	always@(posedge key )
	begin
	counter <= counter + 1;
//	if (counter>=2) begin counter<=0;end
	end
	
	
	always @(cnt8)//扫描数字  
		begin
			case(cnt8)
				3'b000:begin BT<=8'b00000001;a<=m4;end
				3'b001:begin BT<=8'b00000010;a<=r4;end
				3'b010:begin BT<=8'b00000100;a<=m3;end
				3'b011:begin BT<=8'b00001000;a<=r3;end 
				3'b100:begin BT<=8'b00010000;a<=m2;end
				3'b101:begin BT<=8'b00100000;a<=r2;end
				3'b110:begin BT<=8'b01000000;a<=m1;end
				3'b111:begin BT<=8'b10000000;a<=r1;end
				default :begin BT<=8'b00000000; end
		   endcase
		end 
	always@(posedge clk) cnt8<=cnt8 + 1'b1; 
	
	always@(a)//显示部分
		begin 
			case(a)
				0: seg8<=8'b00111111;
				1: seg8<=8'b00000110;
				2: seg8<=8'b01011011;
				3: seg8<=8'b01001111;
				4: seg8<=8'b01101101;
				5: seg8<=8'b01101101;
				6: seg8<=8'b01111101;
				7: seg8<=8'b00000111;
				8: seg8<=8'b01111111;
				9: seg8<=8'b01101111;
				10: seg8<=8'b01110111;
				11: seg8<=8'b01111100;
				12: seg8<=8'b00111001;
				13: seg8<=8'b01111110;
				14: seg8<=8'b01111001;
				15: seg8<=8'b01110001;
				default :seg8<=8'b00111111;
			endcase
		end
	
	
	
	

	
endmodule
