`timescale 1ns/1ps
module RPN_Module_Testbench;

    // Parameters ve I/O signals
    parameter CLK_PERIOD = 10; // ns
    parameter STACK_SIZE = 8;
    
    reg clk = 0;
    reg reset = 1;
    reg dIn;
    reg [7:0] dataIn;
    reg [1:0] operatorIn;
    wire [7:0] result;
    
    // RPN module 
    RPN_Module rpn_module(
        .clk(clk),
        .reset(reset),
        .dIn(dIn),
        .dataIn(dataIn),
        .operatorIn(operatorIn),
        .result(result)
    );
    
    // Test Scenarios
    initial begin
        #50; // Wait
        
        // Scenario 1: 3 + 4 * 5
        $display("Senaryo 1: 4 + 5 * 3");
        reset = 0;
        
        // Adding numbers and operators
        dIn = 0; dataIn = 3; #CLK_PERIOD;
        dIn = 0; dataIn = 4; #CLK_PERIOD;
        dIn = 0; dataIn = 5; #CLK_PERIOD;
        dIn = 1; operatorIn = 2'b01; #CLK_PERIOD; // '+' operator
        dIn = 1; operatorIn = 2'b10; #CLK_PERIOD; // '*' operator
        dIn = 1; operatorIn = 2'b00; #CLK_PERIOD; // Clear stack
        
        // Result Check
        if (result === 27) $display("Scenario 1 successful: 3 + 4 * 5 = %d", result);
        else $display("Scenario 1 Failed: Expected result: 27, Result: %d", result);
		
		
        // Scenario 2: 10 * 2 + 7
        $display("Scenario 2: 10 * 2 + 7");
        reset = 1; #CLK_PERIOD; // Reset case
        reset = 0;
        
        // Adding numbers and operators
        dIn = 0; dataIn = 10; #CLK_PERIOD;
        dIn = 0; dataIn = 2;  #CLK_PERIOD;
        dIn = 1; operatorIn = 2'b10; #CLK_PERIOD; // '*' operator
        dIn = 0; dataIn = 7; #CLK_PERIOD;
        dIn = 1; operatorIn = 2'b01; #CLK_PERIOD; // '+' operator
        
        // Result Check
        if (result === 27) $display("Scenario 2 successful: 10 * 2 + 7 = %d", result);
        else $display("Scenario 2 Failed : Expected Result 27, Result %d", result);
        
        // Scenario 3: 5 * 6 + 8 * 2
        $display("Senaryo 3: 5 * 6 + 8 * 2");
        reset = 1; #CLK_PERIOD; // Reset
        reset = 0;
        
        // Adding numbers and operators
        dIn = 0; dataIn = 5; #CLK_PERIOD;
        dIn = 0; dataIn = 6; #CLK_PERIOD;
        dIn = 1; operatorIn = 2'b10; #CLK_PERIOD; // '*' operator
        dIn = 0; dataIn = 8; #CLK_PERIOD;
        dIn = 0; dataIn = 2; #CLK_PERIOD;
        dIn = 1; operatorIn = 2'b10; #CLK_PERIOD; // '*' operator
        dIn = 1; operatorIn = 2'b01; #CLK_PERIOD; // '+' operator
        
        // Result Check
        if (result === 46) $display("Scenario 3 successful: 5 * 6 + 8 * 2 = %d", result);
        else $display("Scenario 3 Failed: Expected Result 46, Result %d", result);
        //
        reset = 1; #CLK_PERIOD; // Reset
        reset = 0;
        
        // Scenario 4: 3 + (6 * 7 * 5) + 6 * 7
        $display("Senaryo 4: 3 + (6 * 7 * 5) + 6 * 7");
        
        // Adding numbers and operators
        dIn = 0; dataIn = 3; #CLK_PERIOD;
        dIn = 0; dataIn = 6; #CLK_PERIOD;
        dIn = 0; dataIn = 7; #CLK_PERIOD;
        dIn = 0; dataIn = 5; #CLK_PERIOD;
        dIn = 1; operatorIn = 2'b10; #CLK_PERIOD; // '*' operator
        dIn = 1; operatorIn = 2'b10; #CLK_PERIOD; // '*' operator
        dIn = 0; dataIn = 6; #CLK_PERIOD;
        dIn = 0; dataIn = 7; #CLK_PERIOD;
        dIn = 1; operatorIn = 2'b10; #CLK_PERIOD; // '*' operator
        dIn = 1; operatorIn = 2'b01; #CLK_PERIOD; // '+' operator
        dIn = 1; operatorIn = 2'b01; #CLK_PERIOD; // '+' operator
        
        // Result Check
        if (result === 255) $display("Scenario 4 successful: 3 + (6 * 7 * 5) + 6 * 7 = %d", result);
        else $display("Scenario 4 Failed: Expected Result 255, Result %d", result);

        $finish; 
    end

    // Clock
    always #5 clk = !clk; //#CLK_PERIOD/2

endmodule