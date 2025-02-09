module ex303(clk_i,seg8,BT,rst);
	input clk_i,rst;
	output [7:0]seg8;
	output [7:0]BT;
	reg [7:0]seg8;
	reg [7:0]BT;
	reg[2:0] cnt8;
	reg [3:0]a,c=1;
	reg  b=0;
	reg clk2;
	
	always@(posedge clk_i or negedge rst )
		begin 
			if(!rst) begin clk2 <= 0;b <= 0;end
			else if (b==2047)begin clk2<=~clk2;b<=0;end
			else begin b<=b+1;end
		end
	
	always @(cnt8)//扫描数字
		begin
			case(cnt8)
				3'b000:begin BT<=8'b00000001;a<=c;end
				3'b001:begin BT<=8'b00000010;a<=c;end
				3'b010:begin BT<=8'b00000100;a<=c;end
				3'b011:begin BT<=8'b00001000;a<=c;end 
				3'b100:begin BT<=8'b00010000;a<=c;end
				3'b101:begin BT<=8'b00100000;a<=c;end
				3'b110:begin BT<=8'b01000000;a<=c;end
				3'b111:begin BT<=8'b10000000;a<=c;end
				default :begin BT<=8'b00000000; end
		   endcase
		end 
	always@(posedge clk_i) cnt8<=cnt8 + 1'b1;

	begin
		    
	end
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
				