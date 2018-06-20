`timescale 1ns / 1ps

module mem#(parameter N = 64, L = 128)(
    input   logic           clk, 
    input   logic           dword,
    input   logic [1:0]     memwrite,
    input   logic [N-1:0]   dataadr, writedata,
    input   logic [31:0]    instradr,
    output  logic [31:0]    instr,
    output  logic [N-1:0]   readdata,
    input   logic [7:0]     checka,
    output  logic [31:0]    check,
    input   logic [7:0]     rx_data,
    output  logic [31:0]    rx_check,
    output  logic [31:0]    rx_checkh,
    output  logic [31:0]    rx_checkl
);
    logic [N-1:0] RAM [L-1:0];
    logic [31:0]  word;
    initial
        $readmemh("C:/Users/will131/Documents/workspace/MIPS_V3.1/memfile.dat",RAM);
    assign instr = instradr[2] ? RAM[instradr[31:3]][31:0] : RAM[instradr[31:3]][63:32];
    assign readdata = dword ? RAM[dataadr[N-1:3]] : {32'b0,word};
    assign check = checka[0] ? RAM[checka[7:1]][31:0] : RAM[checka[7:1]][63:32];
    assign word = dataadr[2] ? RAM[dataadr[N-1:3]][31:0] : RAM[dataadr[N-1:3]][63:32];
    assign rx_check = rx_data[0] ? RAM[rx_data[7:1]][31:0] : RAM[rx_data[7:1]][63:32];
    assign rx_checkh = RAM[rx_data[7:1]][63:32];
    assign rx_checkl = RAM[rx_data[7:1]][31:0];
    always @(posedge clk)
        begin
        if (memwrite==3)//D
            RAM[dataadr[N-1:3]] <= writedata;
        else if (memwrite==2) //B
                case (dataadr[2:0])
                    3'b111:  RAM[dataadr[N-1:3]][7:0]   <= writedata[7:0];
                    3'b110:  RAM[dataadr[N-1:3]][15:8]  <= writedata[7:0];
                    3'b101:  RAM[dataadr[N-1:3]][23:16] <= writedata[7:0];
                    3'b100:  RAM[dataadr[N-1:3]][31:24] <= writedata[7:0];
                    3'b011:  RAM[dataadr[N-1:3]][39:32] <= writedata[7:0];
                    3'b010:  RAM[dataadr[N-1:3]][47:40] <= writedata[7:0];
                    3'b001:  RAM[dataadr[N-1:3]][55:48] <= writedata[7:0];
                    3'b000:  RAM[dataadr[N-1:3]][63:56] <= writedata[7:0];
                endcase
        else if (memwrite==1) //W
            case (dataadr[2])
                    0:  RAM[dataadr[N-1:3]][63:32]  <= writedata[31:0];
                    1:  RAM[dataadr[N-1:3]][31:0]   <= writedata[31:0];
                endcase
        end 
endmodule