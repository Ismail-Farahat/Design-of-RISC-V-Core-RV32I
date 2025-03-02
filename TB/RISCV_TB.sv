`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2024 05:49:01 PM
// Design Name: 
// Module Name: RISCV_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module RISCV_TB();


    //================================================================//
    //======================    PARAMETERS    ========================//
    //================================================================//
    localparam DEPTH      = 255;
    localparam CLK_PERIOD = 2;



    //================================================================//
    //======================    SIGNALS DECLRATION    ================//
    //================================================================//
    logic   CLK;
    logic   RST;



    //================================================================//
    //======================    DUT INTERNAL SIGNALS (DEBUG)    ======//
    //================================================================//
    // Data Signals
    logic   [31 : 0]    PCNextF;

    logic   [31 : 0]    PCF,
                        PCD,
                        PCE;

    logic   [31 : 0]    PCPlus4F,
                        PCPlus4D,
                        PCPlus4E,
                        PCPlus4M,
                        PCPlus4W;

    logic   [31 : 0]    PCTargetE;

    logic   [31 : 0]    InstrF,
                        InstrD;

    logic   [31 : 0]    RD1D,
                        RD2D,
                        RD1E,
                        RD2E;

    logic   [4 : 0]     Rs1D,
                        Rs2D,
                        Rs1E,
                        Rs2E;

    logic   [4 : 0]     RdD,
                        RdE,
                        RdM,
                        RdW;

    logic   [31 : 0]    ImmExtD,
                        ImmExtE;

    logic   [31 : 0]    SrcAE,
                        SrcBE;

    logic   [31 : 0]    WriteDataE,
                        WriteDataM;

    logic   [31 : 0]    ALUResultE,
                        ALUResultM,
                        ALUResultW;

    logic   [31 : 0]    ReadDataM,
                        ReadDataW;

    logic   [31 : 0]    ResultW;

    // Control Signals
    logic               ZeroE;

    logic               PCSrcE;

    logic               RegWriteD,
                        RegWriteE,
                        RegWriteM,
                        RegWriteW;

    logic   [1 : 0]     ResultSrcD,
                        ResultSrcE,
                        ResultSrcM,
                        ResultSrcW;

    logic               MemWriteD,
                        MemWriteE,
                        MemWriteM;

    logic               JumpD,
                        JumpE,
                        BranchD,
                        BranchE;

    logic   [2 : 0]     ALUControlD,
                        ALUControlE;

    logic               ALUSrcD,
                        ALUSrcE;

    logic   [1 : 0]     ImmSrcD;

    // Hazard Signals
    logic               StallF,
                        StallD;

    logic               FlashD,
                        FlashE;

    logic   [1 : 0]     ForwardAE,
                        ForwardBE;


    // INTERNAL NETS ASSIGNMENTS
    // Data Signals
    assign PCNextF = DUT.PCNextF;

    assign PCF = DUT.PCF;
    assign PCD = DUT.PCD;
    assign PCE = DUT.PCE;

    assign PCPlus4F = DUT.PCPlus4F;
    assign PCPlus4D = DUT.PCPlus4D;
    assign PCPlus4E = DUT.PCPlus4E;
    assign PCPlus4M = DUT.PCPlus4M;
    assign PCPlus4W = DUT.PCPlus4W;

    assign PCTargetE = DUT.PCTargetE;

    assign InstrF = DUT.InstrF;
    assign InstrD = DUT.InstrD;

    assign RD1D = DUT.RD1D;
    assign RD2D = DUT.RD2D;
    assign RD1E = DUT.RD1E;
    assign RD2E = DUT.RD2E;

    assign Rs1D = DUT.Rs1D;
    assign Rs2D = DUT.Rs2D;
    assign Rs1E = DUT.Rs1E;
    assign Rs2E = DUT.Rs2E;

    assign RdD = DUT.RdD;
    assign RdE = DUT.RdE;
    assign RdM = DUT.RdM;
    assign RdW = DUT.RdW;

    assign ImmExtD = DUT.ImmExtD;
    assign ImmExtE = DUT.ImmExtE;

    assign SrcAE = DUT.SrcAE;
    assign SrcBE = DUT.SrcBE;

    assign WriteDataE = DUT.WriteDataE;
    assign WriteDataM = DUT.WriteDataM;

    assign ALUResultE = DUT.ALUResultE;
    assign ALUResultM = DUT.ALUResultM;
    assign ALUResultW = DUT.ALUResultW;

    assign ReadDataM = DUT.ReadDataM;
    assign ReadDataW = DUT.ReadDataW;

    assign ResultW = DUT.ResultW;

    // Control Signals
    assign ZeroE = DUT.ZeroE;

    assign PCSrcE = DUT.PCSrcE;

    assign RegWriteD = DUT.RegWriteD;
    assign RegWriteE = DUT.RegWriteE;
    assign RegWriteM = DUT.RegWriteM;
    assign RegWriteW = DUT.RegWriteW;

    assign ResultSrcD = DUT.ResultSrcD;
    assign ResultSrcE = DUT.ResultSrcE;
    assign ResultSrcM = DUT.ResultSrcM;
    assign ResultSrcW = DUT.ResultSrcW;

    assign MemWriteD = DUT.MemWriteD;
    assign MemWriteE = DUT.MemWriteE;
    assign MemWriteM = DUT.MemWriteM;

    assign JumpD = DUT.JumpD;
    assign JumpE = DUT.JumpE;
    assign BranchD = DUT.BranchD;
    assign BranchE = DUT.BranchE;

    assign ALUControlD = DUT.ALUControlD;
    assign ALUControlE = DUT.ALUControlE;

    assign ALUSrcD = DUT.ALUSrcD;
    assign ALUSrcE = DUT.ALUSrcE;

    assign ImmSrcD = DUT.ImmSrcD;

    // Hazard Signals
    assign StallF = DUT.StallF;
    assign StallD = DUT.StallD;

    assign FlashD = DUT.FlashD;
    assign FlashE = DUT.FlashE;

    assign ForwardAE = DUT.ForwardAE;
    assign ForwardBE = DUT.ForwardBE;




    //================================================================//
    //======================    DUT    ===============================//
    //================================================================//
    RISC_V_TOP #(.DEPTH(DEPTH)) DUT (
        .CLK(CLK),
        .RST(RST)
    );



    //================================================================//
    //======================    TESTS    =============================//
    //================================================================//
    initial begin
        $dumpfile("riscv_tb_wf.vcd");
        $dumpvars(1, RISCV_TB.DUT);
        // Initial Values
        RST = 1'b0;
        CLK = 1'b0;

        #(CLK_PERIOD*1.5) RST = 1'b1;
    end

    always @(posedge CLK)
    begin
        if(MemWriteM & ALUResultM == 100 & WriteDataM == 25) begin
            $display("+-------------+--------------    RESULT    -----------------------------+");
            $display("| ProgramTest |   PASSED - PASSED - PASSED - PASSED - PASSED - PASSED   |");
            $display("+-------------+---------------------------------------------------------+");
            $stop;
        end
        else if(MemWriteM & ALUResultM != 96) begin
            $display("+-------------+--------------    RESULT    -----------------------------+");
            $display("| ProgramTest |   FAILED - FAILED - FAILED - FAILED - FAILED - FAILED   |");
            $display("+-------------+---------------------------------------------------------+");
            $stop;
        end
    end

    

    //================================================================//
    //======================    CLOCK    =============================//
    //================================================================//
    // REF_CLK
    always #(CLK_PERIOD*0.5)  CLK  = ~CLK;

    // Simulation Time
    initial #(CLK_PERIOD*120) $finish;



    //================================================================//
    //================================================================//
    //================================================================//


endmodule
