//Name: Xavier Beasley
//Date: 11/26/25
//Assignment: FINAL PROJECT
//Purpose of Program: Test bech for each fsm and full system
//******************************************************

//Test Bench for fsm1
// module fsm1_tb;
  
//   reg clk_tb, rst_tb, EN_tb;
//   reg [1:0] M_tb;
//   wire V_tb, HL_tb, SEN_tb;
  
//   //Instantiate Module
//   fsm1 dut(clk_tb, rst_tb, EN_tb, M_tb, V_tb, HL_tb, SEN_tb);
  
//   //Clock
//   always
//     begin 
//     	#2 clk_tb =~ clk_tb;
//     end
  
//   //Log
//   initial
//     $display("Time\tPS\t\tEN\tM1\tM0\t|\tNS\t\tV\tHL\tSEN");
//   always@(posedge clk_tb) 
//     begin
//       $display("%0d\t\t%b\t\t%b\t%b\t%b\t|\t%b\t\t%b\t%b\t%b", $time, dut.Q, EN_tb, M_tb[1], M_tb[0], dut.QS, V_tb, HL_tb, SEN_tb);
   
//     end
  
//   //Test Cases
//   initial 
//     begin
//       //Initializing
//       clk_tb = 0; rst_tb =1; EN_tb = 0; M_tb = 2'b00;
//       #4 rst_tb = 0;
      
//       //Changing modes wile enable is off
//       #4 EN_tb = 0; M_tb = 2'b00;
//       #4 EN_tb = 0; M_tb = 2'b01;
//       #4 EN_tb = 0; M_tb = 2'b10;
//       #4 EN_tb = 0; M_tb = 2'b11;
      
//       //To PLAY and back to ALL OFF/Transition
//       #4 EN_tb = 1; M_tb = 2'b00; //Go to PLAY
//       #4 EN_tb = 1; M_tb = 2'b00; //Hold PLAY
//       #4 EN_tb = 0; M_tb = 2'b00; //Since the enable int this module is tied to all the switches being off, EN = 0 is the same as having all the switches off 
      
//       //To MUSIC and back to ALL OFF/Transition
//       #4 EN_tb = 1; M_tb = 2'b01;
//       #4 EN_tb = 1; M_tb = 2'b01; 
//       #4 EN_tb = 0; M_tb = 2'b00;
      
//       //To SPEAKER and back to ALL OFF/Transition
//       #4 EN_tb = 1; M_tb = 2'b10;
//       #4 EN_tb = 1; M_tb = 2'b10; 
//       #4 EN_tb = 0; M_tb = 2'b00;
      
//       //To HOUSE and back to ALL OFF/Transition
//       #4 EN_tb = 1; M_tb = 2'b11;
//       #4 EN_tb = 1; M_tb = 2'b11; 
//       #4 EN_tb = 0; M_tb = 2'b00;
      
//       #4 $finish;
//     end
  
//   //Waveform
//   initial
//     begin
//       $dumpfile("fsm1.vcd"); //File for wave form
//       $dumpvars(0, fsm1_tb); //Specify scope to get rid of error message
//     end
  
  
// endmodule

//Test Bench for FSM2
// module fsm2_tb;
  
//   reg clk_tb, rst_tb;
//   reg SEN_tb;
//   reg [1:0] SPS_tb;
//   wire [1:0] SL_tb;
  
//   //Instantiate Module 
//   fsm2 dut(clk_tb, rst_tb, SEN_tb, SPS_tb, SL_tb);
  
//   //Clock
//   always
//     begin 
//       #2 clk_tb =~ clk_tb;
//     end
  
//   //Log
//   initial
//     $display("Time\tPS\tSEN\tSPS1\tSPS0\t|\tNS\t\tSL1\tSL0");
//   always@(posedge clk_tb) 
//     begin
//       $display("%0d\t\t%b\t%b\t%b\t\t%b\t\t|\t%b\t\t%b\t%b", $time, dut.Q, SEN_tb, SPS_tb[1], SPS_tb[0], dut.QS, SL_tb[1], SL_tb[0]);
//     end
  
//   //Test Cases
//   initial
//     begin
      
//       //Initializing
//       clk_tb = 0; rst_tb = 1; SEN_tb = 0; SPS_tb = 2'b00; //When no input given defaults to zero
//       #4 rst_tb = 0;
      
//       //Center OFF
//       #4 SEN_tb = 0; SPS_tb = 2'b01; //Stay
//       #4 SEN_tb = 0; SPS_tb = 2'b00; //Try left
//       #4 SEN_tb = 0; SPS_tb = 2'b11; //Try right
      
//       //Left
//       #4 SEN_tb = 1; SPS_tb = 2'b00; //Move left
//       #4 SEN_tb = 1; SPS_tb = 2'b00; //Stay left
      
//       //Right
//       #4 SEN_tb = 1; SPS_tb = 2'b11; //Move right (2 cycles)
//       #4 SEN_tb = 1; SPS_tb = 2'b11;
//       #4 SEN_tb = 1; SPS_tb = 2'b11; //Stay right
      
//       //Back to Left
//       #4 SEN_tb = 1; SPS_tb = 2'b00; //Move left (2 cycles)
//       #4 SEN_tb = 1; SPS_tb = 2'b00;
//       #4 SEN_tb = 0; SPS_tb = 2'b01; //Enable Off
      
//       //Back to Right
//       #4 SEN_tb = 1; SPS_tb = 2'b11; //Move right
//       #4 SEN_tb = 0; SPS_tb = 2'b11; //Enable Off
      
//       //To center from right
//       #4 SEN_tb = 1; SPS_tb = 2'b11; //Set back to right
//       #4 SEN_tb = 1; SPS_tb = 2'b01; //Move to center
      
    
      
//       #4 $finish;
      
//     end
  
//     //Waveform
//     initial
//       begin
//         $dumpfile("fsm2.vcd"); //File for wave form
//         $dumpvars(0, fsm2_tb); //Specify scope to get rid of error message
//       end  

// endmodule

//Testbench for full system
module main_tb;
  
  reg clk_tb, rst_tb, SysEN_tb, PM_tb, MM_tb, SM_tb, HM_tb, TL_tb, TC_tb, TR_tb;
  wire V_tb, HL_tb;
  wire [2:0] SPO_tb;
  
  //Instantiate Module
  main dut(clk_tb, rst_tb, SysEN_tb, PM_tb, MM_tb, SM_tb, HM_tb, TL_tb, TC_tb, TR_tb, V_tb, HL_tb, SPO_tb);
  
  //Clock
  always
    begin 
      #2 clk_tb =~ clk_tb;
    end 
  
  //Log
  initial
    $display("Time\tSysEN\tP M S H\t\tTL TC TR\t|\tV\tHL\tSPO");
  always@(posedge clk_tb)
    begin
      $display("%0d\t\t%b\t\t%b %b %b %b\t\t%b  %b  %b\t\t|\t%b\t%b\t%b", $time, SysEN_tb, PM_tb, MM_tb, SM_tb, HM_tb, TL_tb, TC_tb, TR_tb, V_tb, HL_tb, SPO_tb);
    end
  
  //Test Cases
  initial
    begin
      
      //Initialiizing
      clk_tb = 0; rst_tb = 1; SysEN_tb = 0; PM_tb = 0; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 1;
      #4 rst_tb = 0; //Reset off
      
      //Music Mode 
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 1; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 1; //Move to
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 1; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 1; //Stay
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 1; //Transition
      
      //House Mode
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 0; HM_tb = 1; TL_tb = 1; TC_tb = 1; TR_tb = 1; //Move to
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 0; HM_tb = 1; TL_tb = 1; TC_tb = 1; TR_tb = 1; //Stay
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 1; //Transition
      
      //Speaker Mode
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 1; TC_tb = 0; TR_tb = 1; //Move to
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 1; TC_tb = 0; TR_tb = 1; //Stay
      
      //Spotlight Tests
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 0; TC_tb = 1; TR_tb = 1; //To Left
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 0; //To Right
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 0;
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 0; TC_tb = 1; TR_tb = 1; //To Left
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 0; TC_tb = 1; TR_tb = 1;
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 1; TC_tb = 0; TR_tb = 1; //To Center
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 0; //To Right
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 1; TC_tb = 0; TR_tb = 1; //To Center
      
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 0; TR_tb = 1; //Transistion
      
      //Play Mode
      #4 SysEN_tb = 1; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 0; TR_tb = 1; //Move to
      #4 SysEN_tb = 1; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 0; TR_tb = 1; //Stay
      
      //Spotlight Tests
      #4 SysEN_tb = 1; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 0; TC_tb = 1; TR_tb = 1; //To Left
      #4 SysEN_tb = 1; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 0; //To Right
      #4 SysEN_tb = 1; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 0;
      #4 SysEN_tb = 1; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 0; TC_tb = 1; TR_tb = 1; //To Left
      #4 SysEN_tb = 1; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 0; TC_tb = 1; TR_tb = 1;
      #4 SysEN_tb = 1; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 0; TR_tb = 1; //To Center
      #4 SysEN_tb = 1; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 0; //To Right
      #4 SysEN_tb = 1; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 0; TR_tb = 1; //To Center
      
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 0; TR_tb = 1; //Transistion
      
      //Testing System Shutdown for each Mode
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 1; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 1; //Music
      #4 SysEN_tb = 0; PM_tb = 0; MM_tb = 1; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 1; //Off
      
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 0; HM_tb = 1; TL_tb = 1; TC_tb = 1; TR_tb = 1; //House
      #4 SysEN_tb = 0; PM_tb = 0; MM_tb = 0; SM_tb = 0; HM_tb = 1; TL_tb = 1; TC_tb = 1; TR_tb = 1; //Off
      
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 1; //Speaker
      #4 SysEN_tb = 1; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 0; TC_tb = 1; TR_tb = 1; //To Left
      #4 SysEN_tb = 0; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 0; TC_tb = 1; TR_tb = 1; //Off
      #4 SysEN_tb = 0; PM_tb = 0; MM_tb = 0; SM_tb = 1; HM_tb = 0; TL_tb = 0; TC_tb = 1; TR_tb = 1; //Stay Off
      
      #4 SysEN_tb = 1; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 1; //Play
      #4 SysEN_tb = 1; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 0; //to Right
      #4 SysEN_tb = 0; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 0; //Off
      #4 SysEN_tb = 0; PM_tb = 1; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 0; //Stay Off
      #4 SysEN_tb = 0; PM_tb = 0; MM_tb = 0; SM_tb = 0; HM_tb = 0; TL_tb = 1; TC_tb = 1; TR_tb = 1; //Final Off to show finalized outputs
      
      
      #4 $finish;
    end
	  
	//Waveform
    initial
      begin
        $dumpfile("main.vcd"); //File for wave form
        $dumpvars(0, main_tb); //Specify scope to get rid of error message
      end  
  
  
  
endmodule
