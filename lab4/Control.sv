//Two-always example for state machine

module control (input  logic Clk, Reset, Run, M,
                output logic Sub_En, Shift_En, Load, Add_En);

    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [4:0] {Reseted, Idle, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, Halt}   curr_state, next_state; 


	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (~Reset)
            curr_state <= Reseted;
        else 
            curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
		next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 
        Reseted: if(~Run)
            next_state = Idle;
        Idle : next_state = S1;
        S1: next_state = S2;
        S2: next_state = S3;
        S3: next_state = S4;
        S4: next_state = S5;
        S5: next_state = S6;
        S6: next_state = S7;
        S7: next_state = S8;
        S8: next_state = S9;
        S9: next_state = S10;
        S10: next_state = S11;
        S11: next_state = S12;
        S12: next_state = S13;
        S13: next_state = S14;
        S14: next_state = S15;
        S15: next_state = S16;
        S16: next_state = Halt;
        Halt: if (Run)
                next_state = Reseted;
        
//            Reseted: next_state = Idle;
//            Idle : 
//            if (Run)
//            begin
//                if (M == 1'b0)
//                    next_state = S2;
//                else 
//                    next_state = S1;
//            end
//            else 
//            begin
//            next_state = Halt;
//            end
//            S1 :    next_state = S2;
//            S2 :                           
//            begin
//                if (M == 1'b0)
//                    next_state = S4;
//                else 
//                    next_state = S3;
//            end
//            S3 :    next_state = S4;
//            S4 :                           
//            begin
//                if (M == 1'b1)
//                    next_state = S5;
//                else 
//                    next_state = S6;
//            end
//            S5 :    next_state = S6;
//            S6 :    
//            begin
//                if (M == 1'b1)
//                    next_state = S7;
//                else 
//                    next_state = S8;
//            end
//            S7 :    next_state = S8;
//            S8 : 
//            begin
//                if (M == 1'b1)
//                    next_state = S9;
//                else 
//                    next_state = S10;
//            end
//            S9:     next_state = S10;
//            S10:
//            begin      
//                if (M == 1'b1)
//                    next_state = S11;
//                else 
//                    next_state = S12;
//            end
//            S11:    next_state = S12;
//            S12:    
//            begin
//                if (M == 1'b1)
//                    next_state = S13;
//                else 
//                    next_state = S14;
//            end
//            S13:    next_state = S14;
//            S14:             
//            begin
//                if (M == 1'b1)
//                    next_state = S15;
//                else 
//                    next_state = S16;
//            end
//            S15:    next_state = S16;
//            S16:    next_state = Halt; 
//            Halt: 
//                if (~Run)
//                    next_state = Idle;
//                else 
//                    next_state = Halt;
        endcase
   
		  // Assign outputs based on 'state'
        case (curr_state) 
	   	   S1,S3,S5,S7,S9,S11,S13: 
	        begin
	        if (M == 1'b1) 
	           begin
	           Add_En = 1'b1;
	           Sub_En = 1'b0;
               Shift_En = 1'b0;
               Load = 1'b0;
	           end
	        else 
	           begin
	           Add_En = 1'b0;
	           Sub_En = 1'b0;
               Shift_En = 1'b0;
               Load = 1'b0;
	           end
		    end
	   	   S2,S4,S6,S8,S10,S12,S14,S16: 
		    begin
		        Add_En = 1'b0;
                Shift_En = 1'b1;
                Sub_En = 1'b0;
                Load = 1'b0;
		    end
           S15:
            begin 
            if (M == 1'b1) 
	           begin
	           Add_En = 1'b0;
	           Sub_En = 1'b1;
               Shift_En = 1'b0;
               Load = 1'b0;
	           end
	        else 
	           begin
	           Add_En = 1'b0;
	           Sub_En = 1'b0;
               Shift_En = 1'b0;
               Load = 1'b0;
	           end
            end
           Halt:
            begin
                Add_En = 1'b0;
                Shift_En = 1'b0;
                Sub_En = 1'b0;
                Load = 1'b0;
            end
           Reseted:
            begin
                Add_En = 1'b0;
                Shift_En = 1'b0;
                Sub_En = 1'b0;
                Load = 1'b0;
            end
           Idle:
           begin
                Add_En = 1'b0;
                Shift_En = 1'b0;
                Sub_En = 1'b0;
                Load = 1'b1;
		   end
	   	   default: //Idle
		      begin 
		        Add_En = 1'b0;
                Shift_En = 1'b0;
                Sub_En = 1'b0;
                Load = 1'b0;
		      end
        endcase
    end

endmodule
