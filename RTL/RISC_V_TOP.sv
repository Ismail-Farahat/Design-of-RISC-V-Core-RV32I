`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2024 02:53:26 AM
// Design Name: 
// Module Name: RISC-V_TOP
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
module RISC_V_TOP #(DEPTH = 255) (
    input   logic   i_riscv_core_clk,
    input   logic   i_riscv_core_rst_n
    );

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

    logic   [1  : 0]    ForwardAE,
                        ForwardBE;




    //================================================================//
    //======================    FETCH    =============================//
    //================================================================//
    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U_FETCH (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(StallF),
	    .i_pipe_in(PCNextF),
	    .o_pipe_out(PCF)
    );




    //================================================================//
    //======================    DECODE    ============================//
    //================================================================//
    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U0_DECODE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashD),
	    .i_pipe_en_n(StallD),
	    .i_pipe_in(InstrF),
	    .o_pipe_out(InstrD)
    );

    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U1_DECODE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashD),
	    .i_pipe_en_n(StallD),
	    .i_pipe_in(PCF),
	    .o_pipe_out(PCD)
    );

    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U2_DECODE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashD),
	    .i_pipe_en_n(StallD),
	    .i_pipe_in(PCPlus4F),
	    .o_pipe_out(PCPlus4D)
    );


    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    assign RdD  = InstrD[11:7];




    //================================================================//
    //======================    EXCUTE    ============================//
    //================================================================// 
    // Data Pipelines
    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U0_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(PCD),
	    .o_pipe_out(PCE)
    );

    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U1_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(RD1D),
	    .o_pipe_out(RD1E)
    );

    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U2_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(RD2D),
	    .o_pipe_out(RD2E)
    );

    PipelineReg #(
	    .BUS_WIDTH(5)
	                                    ) U3_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(Rs1D),
	    .o_pipe_out(Rs1E)
    );

    PipelineReg #(
	    .BUS_WIDTH(5)
	                                    ) U4_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(Rs2D),
	    .o_pipe_out(Rs2E)
    );

    PipelineReg #(
	    .BUS_WIDTH(5)
	                                    ) U5_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(RdD),
	    .o_pipe_out(RdE)
    );

    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U6_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(ImmExtD),
	    .o_pipe_out(ImmExtE)
    );

    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U7_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(PCPlus4D),
	    .o_pipe_out(PCPlus4E)
    );

    // Control Pipelines
    PipelineReg #(
	    .BUS_WIDTH(1)
	                                    ) U8_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(RegWriteD),
	    .o_pipe_out(RegWriteE)
    );

    PipelineReg #(
	    .BUS_WIDTH(2)
	                                    ) U9_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(ResultSrcD),
	    .o_pipe_out(ResultSrcE)
    );

    PipelineReg #(
	    .BUS_WIDTH(1)
	                                    ) U10_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(MemWriteD),
	    .o_pipe_out(MemWriteE)
    );

    PipelineReg #(
	    .BUS_WIDTH(1)
	                                    ) U11_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(JumpD),
	    .o_pipe_out(JumpE)
    );

    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U12_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(BranchD),
	    .o_pipe_out(BranchE)
    );

    PipelineReg #(
	    .BUS_WIDTH(3)
	                                    ) U13_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(ALUControlD),
	    .o_pipe_out(ALUControlE)
    );

    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U14_EXCUTE (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(FlashE),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(ALUSrcD),
	    .o_pipe_out(ALUSrcE)
    );


    assign PCSrcE = (ZeroE && BranchE) || JumpE;




    //================================================================//
    //======================    MEMORY    ============================//
    //================================================================//
    // Data Pipelines
    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U0_MEMORY (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(ALUResultE),
	    .o_pipe_out(ALUResultM)
    );

    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U1_MEMORY (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(WriteDataE),
	    .o_pipe_out(WriteDataM)
    );

    PipelineReg #(
	    .BUS_WIDTH(5)
	                                    ) U2_MEMORY (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(RdE),
	    .o_pipe_out(RdM)
    );

    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U3_MEMORY (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(PCPlus4E),
	    .o_pipe_out(PCPlus4M)
    );


    // Control Pipelines
    PipelineReg #(
	    .BUS_WIDTH(1)
	                                    ) U4_MEMORY (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(RegWriteE),
	    .o_pipe_out(RegWriteM)
    );

    PipelineReg #(
	    .BUS_WIDTH(2)
	                                    ) U5_MEMORY (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(ResultSrcE),
	    .o_pipe_out(ResultSrcM)
    );

    PipelineReg #(
	    .BUS_WIDTH(1)
	                                    ) U6_MEMORY (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(MemWriteE),
	    .o_pipe_out(MemWriteM)
    );




    //================================================================//
    //======================    WRITE_BACK    ========================//
    //================================================================//
    // Data Pipelines
    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U0_WB (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(ALUResultM),
	    .o_pipe_out(ALUResultW)
    );

    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U1_WB (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(ReadDataM),
	    .o_pipe_out(ReadDataW)
    );

    PipelineReg #(
	    .BUS_WIDTH(32)
	                                    ) U2_WB (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(PCPlus4M),
	    .o_pipe_out(PCPlus4W)
    );

    PipelineReg #(
	    .BUS_WIDTH(5)
	                                    ) U3_WB (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(RdM),
	    .o_pipe_out(RdW)
    );


    // Control Pipelines
    PipelineReg #(
	    .BUS_WIDTH(1)
	                                    ) U4_WB (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(RegWriteM),
	    .o_pipe_out(RegWriteW)
    );

    PipelineReg #(
	    .BUS_WIDTH(2)
	                                    ) U5_WB (
	    .i_pipe_clk(i_riscv_core_clk),
	    .i_pipe_rst_n(i_riscv_core_rst_n),
	    .i_pipe_clr(1'b0),
	    .i_pipe_en_n(1'b0),
	    .i_pipe_in(ResultSrcM),
	    .o_pipe_out(ResultSrcW)
    );




    //================================================================//
    //======================    Control Unit    ======================//
    //================================================================//
    ControlUnit CU (
        .i_cu_op(InstrD[6:0]),
        .i_cu_funct3(InstrD[14:12]),
        .i_cu_funct7_5(InstrD[30]),
        .o_cu_ALUControl(ALUControlD),
        .o_cu_RegWrite(RegWriteD),
        .o_cu_ResultSrc(ResultSrcD),
        .o_cu_MemWrite(MemWriteD),
        .o_cu_Jump(JumpD),
        .o_cu_Branch(BranchD),
        .o_cu_ALUSrc(ALUSrcD),
        .o_cu_ImmSrc(ImmSrcD)
    );



    //================================================================//
    //======================    Hazard Unit    =======================//
    //================================================================// 
    HazardUnit HU(
        .i_hu_Rs1D(Rs1D),
        .i_hu_Rs2D(Rs2D),
        .i_hu_Rs1E(Rs1E),
        .i_hu_Rs2E(Rs2E),
        .i_hu_RdE(RdE),
        .i_hu_RdM(RdM),
        .i_hu_RdW(RdW),
        .i_hu_RegWriteW(RegWriteW),
        .i_hu_RegWriteM(RegWriteM),
        .i_hu_ResultSrcE0(ResultSrcE[0]),
        .i_hu_PCSrcE(PCSrcE),
        .o_hu_StallF(StallF),
        .o_hu_StallD(StallD),
        .o_hu_FlashD(FlashD),
        .o_hu_FlashE(FlashE),
        .o_hu_ForwardAE(ForwardAE),
        .o_hu_ForwardBE(ForwardBE)
    );



    //================================================================//
    //======================    FETCH: PC MUX2    ====================//
    //================================================================// 
    MUX2 PCMux (
        .i_mux2_in1(PCPlus4F),
        .i_mux2_in2(PCTargetE),
        .i_mux2_sel(PCSrcE),
        .o_mux2_out(PCNextF)
    );



    //================================================================//
    //======================    FETCH: Instruction Memory    =========//
    //================================================================//
    InstructionMemory #(.DEPTH(DEPTH)) IM (
        .i_im_A(PCF),
        .i_im_RD(InstrF)
    );



    //================================================================//
    //======================    FETCH: ADDER    ======================//
    //================================================================//
    ADDER PCPlus4Adder (
        .i_adder_in1(PCF),
        .i_adder_in2(32'h4),
        .o_adder_out(PCPlus4F)
    );



    //================================================================//
    //======================    DECODE: Register File    =============//
    //================================================================//
    RegisterFile RF (
        .i_rf_clk(i_riscv_core_clk),
        .i_rf_rst_n(i_riscv_core_rst_n),
        .i_rf_A1(Rs1D),
        .i_rf_A2(Rs2D),
        .i_rf_A3(RdW),
        .i_rf_WD3(ResultW),
        .i_rf_WE3(RegWriteW),
        .o_rf_RD1(RD1D),
        .o_rf_RD2(RD2D)
    );



    //================================================================//
    //======================    DECODE: EXTEND UNIT    ===============//
    //================================================================//
    EXTEND ExtendU (
        .i_extend_Instr(InstrD[31:7]),
        .i_extend_ImmSrc(ImmSrcD),
        .o_extend_ImmExt(ImmExtD)
    );



    //================================================================//
    //======================    EXCUTE: ForwardSrcA MUX3    ==========//
    //================================================================//
    MUX3 ForwardSrcA_MUX (
        .i_mux3_in1(RD1E),
        .i_mux3_in2(ResultW),
        .i_mux3_in3(ALUResultM),
        .i_mux3_sel(ForwardAE),
        .o_mux3_out(SrcAE)
    );



    //================================================================//
    //======================    EXCUTE: ForwardSrcB MUX3    ==========//
    //================================================================//
    MUX3 ForwardSrcB_MUX (
        .i_mux3_in1(RD2E),
        .i_mux3_in2(ResultW),
        .i_mux3_in3(ALUResultM),
        .i_mux3_sel(ForwardBE),
        .o_mux3_out(WriteDataE)
    );



    //================================================================//
    //======================    EXCUTE: SrcB MUX2    =================//
    //================================================================//
    MUX2 SrcB_MUX (
        .i_mux2_in1(WriteDataE),
        .i_mux2_in2(ImmExtE),
        .i_mux2_sel(ALUSrcE),
        .o_mux2_out(SrcBE)
    );



    //================================================================//
    //======================    EXCUTE: ALU    =======================//
    //================================================================//
    ALU ALU_U (
        .i_alu_SrcA(SrcAE),
        .i_alu_SrcB(SrcBE),
        .i_alu_ALUControl(ALUControlE),
        .o_alu_ALUResult(ALUResultE),
        .o_alu_ALUZero(ZeroE)
    );



    //================================================================//
    //======================    EXCUTE: ADDER    =====================//
    //================================================================//
    ADDER SrcBAdder (
        .i_adder_in1(PCE),
        .i_adder_in2(ImmExtE),
        .o_adder_out(PCTargetE)
    );



    //================================================================//
    //======================    MEMORY: Data Memory    ===============//
    //================================================================//
    DataMemory  #(.DEPTH(DEPTH)) DM (
        .i_dm_clk(i_riscv_core_clk),
        .i_dm_rst_n(i_riscv_core_rst_n),
        .i_dm_A(ALUResultM),
        .i_dm_WD(WriteDataM),
        .i_dm_WE(MemWriteM),
        .o_dm_RD(ReadDataM)
    );



    //================================================================//
    //======================    WRITEBACK: Result MUX3    ============//
    //================================================================//
    MUX3 ResultMux (
        .i_mux3_in1(ALUResultW),
        .i_mux3_in2(ReadDataW),
        .i_mux3_in3(PCPlus4W),
        .i_mux3_sel(ResultSrcW),
        .o_mux3_out(ResultW)
    );



    //================================================================//
    //================================================================//
    //================================================================//



endmodule
