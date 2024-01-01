//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI Lab                                --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input logic Reset, frame_clk,
			   input logic [15:0] keycode,
               output logic [9:0]  BallX, BallY, BallS );
    
    logic [9:0] Ball_X_Motion, Ball_Y_Motion;
	logic[1:0] Xdir, Ydir;
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=479;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=639;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

    assign BallS = 16;  // default ball size
    always_comb
    begin
                   if (keycode[7])
                       Xdir = 1;
                   else if (keycode[7:0] != 8'b0)
                       Xdir = 2;
                   else
                       Xdir = 0;
                   if (keycode[15])
                       Ydir = 1;
                   else if (keycode[15:8] != 8'b0)
                       Ydir = 2;
                   else
                       Ydir = 0;
    end
    logic[1:0] bt, bb, bl, br;
    always_ff @ (posedge frame_clk or posedge Reset) //make sure the frame clock is instantiated correctly
    begin: Move_Ball
        if (Reset)  // asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
			Ball_X_Motion <= 10'd0; //Ball_X_Step;
			bt <= 0;
			bb <= 0;
			bl <= 0;
			br <= 0;
			BallY <= Ball_Y_Center;
			BallX <= Ball_X_Center;
        end
       else 
        begin 
//				 if ( (BallY + BallS) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
//				 begin
//					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
//			     end
//				 else if ( (BallY - BallS) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
//				 begin
//					  Ball_Y_Motion <= Ball_Y_Step;
//			     end
//				 else if ( (BallX + BallS) >= Ball_X_Max )  // Ball is at the Right edge, BOUNCE!
//				 begin
//					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
//			     end
//				 else if ( (BallX - BallS) <= Ball_X_Min )  // Ball is at the Left edge, BOUNCE!
//				 begin
//					  Ball_X_Motion <= Ball_X_Step;
//			     end
//				 else 
//					  Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
				 //modify to control ball motion with the keycode
//				 if (keycode == 8'h1A)
//				 begin
//				     Ball_X_Motion <= 10'd0;
//                 if ( (BallY - BallS) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
//                     begin
//                        Ball_Y_Motion <= Ball_Y_Step;
//                     end
//                 else
//                     begin
//                        Ball_Y_Motion <= -10'd1;
//                     end
//                 end
//				 else if (keycode == 8'h16)
//				 begin
//				     Ball_X_Motion <= 10'd0;
//				     if ( (BallY + BallS) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
//				     begin
//					   Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
//			         end
//				     else
//                         begin
//                         Ball_Y_Motion <= 10'd1;
//                         end
//                 end
//                 else if (keycode == 8'h7)
//                 begin
//				     Ball_Y_Motion <= 10'd0;
//                     if ( (BallX + BallS) >= Ball_X_Max )  // Ball is at the Right edge, BOUNCE!
//                         begin
//                              Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
//                         end
//                     else
//                         begin
//                         Ball_X_Motion <= 10'd1;
//                         end
//                 end
//                 else if(keycode == 8'h4)
//                 begin
//				     Ball_Y_Motion <= 10'd0;
//				 if ( (BallX - BallS) <= Ball_X_Min )  // Ball is at the Left edge, BOUNCE!
//				 begin
//					  Ball_X_Motion <= Ball_X_Step;
//			     end
//			     else
//			         begin
//			         Ball_X_Motion <= -10'd1;
//			         end
//                 end   
                if (Xdir == 1)
                begin
                Ball_X_Motion <= {2'b11, keycode[7:0]};
                br <= 1;
                if ( BallX < BallS )  // Ball is at the Left edge, BOUNCE!
					bl <= 2;
			    else
                    bl <= 1;
                end
                else if (Xdir == 2)
                begin
                Ball_X_Motion <= {2'b00, (keycode[7:0])};
                bl <= 1;
                if ( (BallX + BallS) > Ball_X_Max )  // Ball is at the Right edge, BOUNCE!
					br <= 2;
			    else
                    br <= 1;
                end
                else
                begin
                    Ball_X_Motion <= 10'b0;
                end
                
                if (Ydir == 1)
                begin
                Ball_Y_Motion <= {2'b11, keycode[15:8]};
                bb <= 1;
                if ( BallY < BallS )  // Ball is at the top edge, BOUNCE!
					  bt <= 2;
			    else
                    bt <= 1;
                    
                    
//                      Ball_Y_Motion <= 10'd1;
                end
                else if (Ydir == 2)
                begin
                 Ball_Y_Motion <= {2'b00, (keycode[15:8])};
                 bt <= 1;
                 if ( (BallY + BallS) > Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
                 begin
					  bb <= 2;
			     end
			     else 
			         bb <= 1;
//                    Ball_Y_Motion <= -10'd1;
                end
                else
                begin
                    Ball_Y_Motion <= 10'b0;
                end
                if (bl == 2)
                BallX <= BallS;
                else if (br == 2)
                BallX <= Ball_X_Max - BallS;
                else
                BallX <= (BallX + Ball_X_Motion);
                if (bt == 2)
                BallY <= BallS;
                else if (bb == 2)
                BallY <= Ball_Y_Max - BallS;
                else
                BallY <= (BallY + Ball_Y_Motion);
		end  
    end
      
endmodule
