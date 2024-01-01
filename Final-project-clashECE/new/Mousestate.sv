//simple state machine to convert a pushbutton input to one clock cycle long event
//similar to the hold->reset portion of the serial logic processor


module Mousestate (	input logic Clk, Reset,
                    input logic infield,
                    input logic otherinz, otherino,otherint,
                    input logic [9:0] X,Y,
                    input logic [9:0] lowerX, lowerY,upperX, upperY,
                    input logic [4:0] elixircost,
                    input logic [3:0] click,
                    input logic [4:0] eli,
                    output logic [4:0] elixirin,
                    output logic idle, instate, deploy);
	   			
	   enum logic [2:0] {A, B, C, D} curr_state, next_state; //States: A = Loading; B = Idle; C = Deploying; D = Infield
	   
	   //Always FF block for FSMs
	   always_ff @ (posedge Clk or posedge Reset ) 
		begin
            if (Reset) begin
                curr_state <= A;
            end 
            else begin
                curr_state <= next_state;                           
            end
		end
		
		// Assign 'next_state' based on 'state' and 'Execute'
		always_comb
		begin
            // Default needed to stay in the same state
            next_state = curr_state; 
            
            unique case (curr_state)
                A : if (click == 1 && Y <= upperY && Y >= lowerY && X <= upperX && X >= lowerX && !otherinz && !otherino && !otherint)
                        next_state = B;
                B : if (click == 0 && X >= 300 && X <= 500 && eli >= (elixircost / 3))
                        next_state = C;
                    else if (click == 3 || click == 2) //Either click with both left and right or right can cancel the selection
                        next_state = A;
                C :  next_state = D;
                D: if (infield == 0)
                    next_state = A;
            endcase
        end
        
		// Assign outputs based on current state
		always_comb
		begin
		    idle = 1;
		    instate = 0;
		    deploy = 0;
		    elixirin = 0;
            case (curr_state)
                A: ;
                B: 
                    begin
                    idle = 0;
                    instate = 1;
                    end
                C: 
                    begin
                    idle = 0;
                    deploy = 1;
                    elixirin = elixircost;
                    end
                D: 
                    begin
                    idle = 0;
                    deploy = 0;
                    elixirin = 0;
                    end
            endcase
		end
		
endmodule