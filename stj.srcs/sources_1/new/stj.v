`timescale 1ns/1ps
module RPN_Module(
    input wire clk,
    input wire reset,
    input wire dIn, // 1-bit input (1: operator, 0: number)
    input wire [7:0] dataIn, // 8-bit input
    input wire [1:0] operatorIn, // 2-bit operator input
    output wire [7:0] result // 8-bit output
);

    // Stack size and other parameters 
    parameter STACK_SIZE = 8;
    
	/* 
	parameter OPERATOR_ADD = 2'b01;
    parameter OPERATOR_MUL = 2'b10;
    parameter OPERATOR_CHECK = 2'b11;
    */
	
    // 8-bit stack, 3-bit pointer and 1-bit proccess bit definition
    reg [7:0] stack [0:STACK_SIZE-1];
    reg [2:0] stack_ptr = 3'b000;
    reg [7:0] result_reg;
	reg [7:0] num1;
	reg [7:0] num2;
	
	
	
	// Feeds the value on the stack to the data according to the sent ptr value.
	task automatic pop(input [2:0] ptr, output reg [7:0] data);
		begin
		    //$display("pop func ptr: %d", ptr); // Control test of ptr value
		    ptr = ptr - 1;
		    //$display("pop func ptr: %d", ptr); // Control test of ptr value
			case (ptr)
			
			  3'b000: begin
			   data = stack[0];
			   stack[0] = 8'b0;
			   end
			   
			  3'b001: begin 
			  data = stack[1];
			  stack[1] = 8'b0;
			  end
			  
			  3'b010:begin 
			  data = stack[2];
			  stack[2] = 8'b0;
			  end
			  
			  3'b011: begin
			  data = stack[3];
			  stack[3] = 8'b0;
			  end
			  3'b100:begin
			  data = stack[4];
			  stack[4] = 8'b0;
			  end
			  3'b101: begin
			  data = stack[5];
			  stack[5] = 8'b0;
			  end
			  3'b110: begin
			  data = stack[6];
			  stack[6] = 8'b0;
			  end
			  3'b111: begin
			  data = stack[7];
			  stack[7] = 8'b0;
			  end
			  //default: data = 8'h0; // Default value for error status.
			endcase
		end
	endtask
  
  // According to the sent ptr value, it pushes the value in the data to the stack.
  task automatic push;
        input [2:0] ptr;
        input [7:0] data;
        begin
            case (ptr)
                3'b000: stack[0] = data;
                3'b001: stack[1] = data;
                3'b010: stack[2] = data;
                3'b011: stack[3] = data;
                3'b100: stack[4] = data;
                3'b101: stack[5] = data;
                3'b110: stack[6] = data;
                3'b111: stack[7] = data;
            endcase
            //$display("test: %d", data); // Control test of data
        end
    endtask

	// Reset ptr and stack values
    integer i; // Local variable
    task automatic clear_stack;
	begin
        for (i = 0; i < STACK_SIZE; i = i + 1) begin
          stack[i] = 8'b0;
        end
        stack_ptr = 3'b000;
    end
  endtask
  
  
  
  always @(posedge clk) begin
        if (reset) begin
            clear_stack();
			//dIn <= 0;
            result_reg <= 0;
        end else begin 
			if(dIn) begin // dIn == 1 case 
				// Take action based on the given operator
				case (operatorIn)
					2'b01: begin // SUM
                            //$display("Sum Begin"); // Case Check
                            /* Stack Check
                            $display("Stack Check Begin");
                            for (i = 0; i < STACK_SIZE; i = i + 1) begin
                                $display("Stack %d. variable: %d", i, stack[i]);
                            end
                            $display("End of Stack Check");
                            */
                            pop(stack_ptr, num1);
                            //$display("stackptr: %d | num1: %d", stack_ptr, num1); // Check: Succeed
                            stack_ptr = stack_ptr - 1;
                            //$display("stackptr: %d", stack_ptr); //Check: Succeed
                            pop(stack_ptr, num2);
                            //$display("stackptr: %d | num2: %d", stack_ptr, num2); // Check: Succeed
                            result_reg = num1 + num2;
                            //$display("num1: %d | num2: %d | result_reg: %d ", num1, num2, result_reg); // Check: Succeed
                            push(stack_ptr-1, result_reg);
                            /* Stack Check after Sum
                            $display("Sum-Stack Check Begin");
                            for (i = 0; i < STACK_SIZE; i = i + 1) begin
                                $display("Stack %d. variable: %d", i, stack[i]);
                            end
                            $display("End of Sum-Stack Check");
                            */
                            //$display("stackptr: %d | resultreg: %d", stack_ptr, result_reg); // Check: Succeed
                          
                            $display("stackptr: %d", stack_ptr);
						end
					2'b10: begin // MUL
						pop(stack_ptr, num1);
						stack_ptr = stack_ptr - 1;
								
						pop(stack_ptr, num2);
						result_reg = num1 * num2;
								
						push(stack_ptr-1, result_reg);
						/* Begin of MUL-Stack Check
						   $display(" MUL-Stack Check Begin");
                            for (i = 0; i < STACK_SIZE; i = i + 1) begin
                                $display("Stack %d. variable: %d", i, stack[i]);
                            end
                            $display("End of MUL-Stac Check");
                            */
						end
						
					2'b11: begin // Check
						pop(stack_ptr, result_reg);
						$display("Result_Reg = %d", result_reg);
						push(stack_ptr, result_reg);
						end
							/*
							default: begin
								// Error Case, reset everything
								clear_stack();
								dIn <= 0;
								result_reg <= 0;
							end
							*/
				endcase
            end else begin // dIn == 0 case
					// Push operation is performed to add the incoming number to the stack.
					push(stack_ptr, dataIn);
					stack_ptr <= stack_ptr + 1;
				end
            end
        end

    assign result = result_reg; // Output 

endmodule
