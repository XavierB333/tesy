//Name: Xavier Beasley
//Date: 11/26/25
//Assignment: FINAL PROJECT
//Purpose of Program: Design file for a theater system that switches between modes (PLAY, MUSIC, SPEAKER, and HOUSE)
//It also has a master enable switch that will transition the system into a state of all off.
//For SPEAKER and PLAY modes, an spotlight sensor input controls a spotlight.
//******************************************************

//Main module that modifies the inputs for the fsms and constructs the outputs
module main(clk, rst, SysEN, PM, MM, SM, HM, TL, TC, TR, V, HL, SPO);
  
  input clk, rst;
  input SysEN, PM, MM, SM, HM, TL, TC, TR; //System Enable, Play, Music, Speaker, and House modes, Left, Center, and Right sensors
  output V, HL; //Visualization and House Light outputs
  output [2:0] SPO; //3 bit output for spotlight control SPO[2] is On/Off, while SPO[1-0] are for position
  
  //Enable used in fsm1 (Allows for all switch inputs to be zero and will transition into alloff/transition mode)
  wire T1, EN;
  or (T1, PM, MM, SM, HM);
  and (EN, SysEN, T1);
  
  //Notted Sensor terms since they are active low
  wire nTL, nTC, nTR;
  not (nTL, TL);
  not (nTC, TC);
  not (nTR, TR);
  
  //Binary encoding for the mode switches
  wire [1:0] M;
  BEncoder be1(PM, MM, SM, HM, M); //00 = PM, 01 = MM, 10 = SM, 11 = HM
  
  //Binary encoding for the sensors
  wire [1:0] SPS;
  BEncoder be2(nTL, nTC, 1'b0, nTR, SPS); //00 = Right, 01 = Center, 10 = Unsused, 11 = Right
  
  //FSM Instantiations
  
  //Master module 
  wire SEN;
  fsm1 mfsm(clk, rst, EN, M, V, HL, SEN);
  
  //Spotlight control module 
  fsm2 sfsm(clk, rst, SEN, SPS, SPO[1:0]);
  
  //Assigning SEN to SPO[2]
  buf (SPO[2], SEN);
  
endmodule

//FSM Modules

//Module for FSM1 (The master fsm)
module fsm1(clk, rst, EN, M, V, HL, SEN);
  
  input clk, rst;
  input EN;
  input [1:0] M;
  output V, HL, SEN;
  
  wire [2:0]  Q;
  wire [2:0] QS; //Q*
  
  //Nots
  wire nQ2, nQ1, nQ0, nM1, nM0;
  not (nQ2, Q[2]);
  not (nQ1, Q[1]);
  not (nQ0, Q[0]);
  not (nM1, M[1]);
  not (nM0, M[0]);
  
  //Next State Logic
  
  //Q2*
  and (QS[2], EN, nQ1, nQ0, M[1], M[0]);
  
  //Q1*
  wire T1, T2, T3;
  and (T1, EN, nQ2, nQ0, nM1, M[0]);
  and (T2, EN, nQ2, nQ1, nQ0, M[1], nM0);
  and (T3, EN, nQ2, Q[1], Q[0], M[1], nM0);
  or (QS[1], T1, T2, T3);
  
  //Q0*
  wire T4, T5, T6;
  and (T4, EN, nQ2, nQ1, nQ0, nM0);
  and (T5, EN, nQ2, nQ1, nM1, nM0);
  and (T6, EN, nQ2, Q[1], Q[0], M[1], nM0);
  or (QS[0], T4, T5, T6);
  
  //Output Logic
  
  //Visuals
  wire T7, T8;
  and (T7, nQ1, Q[0]);
  and (T8, Q[1], nQ0);
  or (V, T7, T8);
  
  //House Lights
  buf (HL, Q[2]);
  
  //Spotlight Enable
  buf (SEN, Q[0]);
  
  //dffs
  dff ff2(clk, rst, QS[2], Q[2]);
  dff ff1(clk, rst, QS[1], Q[1]);
  dff ff0(clk, rst, QS[0], Q[0]);
  
endmodule

//Module for fsm2 (spotlight control)
module fsm2(clk, rst, SEN, SPS, SL);
  
  input clk, rst;
  input SEN; //Spotlight Enable
  input [1:0] SPS; //Sensor input
  output [1:0] SL; //Position Control
  
  wire [1:0] Q;
  wire [1:0] QS;
  
  //Nots
  wire nSEN;
  not (nSEN, SEN);
  
  //Next State Equations 
  
  //Q1*
  and (QS[1], Q[0], SEN, SPS[1], SPS[0]);
  
  //Q0*
  or (QS[0], Q[1], nSEN, SPS[1], SPS[0]);
  
  //Output Equations
  
  //SL[1]
  buf (SL[1], Q[1]);
  
  //SL[0]
  buf (SL[0], Q[0]);
  
  //dffs
  dff ff1(clk, rst, QS[1], Q[1]);
  dff1 ff0(clk, rst, QS[0], Q[0]); //Reset has to change this bit to 1 so dff1 is used
  
endmodule

//Utility modules

//Module for dff that resets to 0
module dff(clk, rst, D, Q);
  //Inputs/Outputs
  input clk, rst, D;
  output Q; reg Q;
  
  always@(posedge clk or posedge rst)
    begin
      if (rst)
        Q <= 1'b0;
      else
        Q <= D;
    end
  
endmodule 

//Module for dff that resets to 1
module dff1(clk, rst, D, Q);
  //Inputs/Outputs
  input clk, rst, D;
  output Q; reg Q;
  
  always@(posedge clk or posedge rst)
    begin
      if (rst)
        Q <= 1'b1;
      else
        Q <= D;
    end
  
endmodule 

//Module for the binary encoder
module BEncoder(D0, D1, D2, D3, A);
  
  input D0, D1, D2, D3; //Inputted mutually exclusive values
  output [1:0] A; //Output encoded value
  
  or (A[1], D2, D3);
  or (A[0], D1, D3);
  
endmodule
