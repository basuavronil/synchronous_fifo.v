`timescale 1ns/1ps

module tb_fifo;

    reg clk, rst_n, wr_en, rd_en;
    reg  [7:0]  din;
    wire [7:0]  dout;
    wire        full, empty;

    fifo dut (.clk(clk), .rst_n(rst_n),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    initial begin
     clk = 0;
     forever #5 clk = ~ clk;
    end
    


    initial begin
        clk   = 0;
        rst_n = 0;
        wr_en = 0;
        rd_en = 0;
        din   = 0;

#20;
        rst_n = 1;


        repeat (10) begin
            @(posedge clk);
            wr_en = 1;
            din = din + 8'd1;
        end
        @(posedge clk);
        wr_en = 0;


        repeat (5) begin
            @(posedge clk);
            rd_en = 1;
        end
        @(posedge clk);
        rd_en = 0;


        while (!full) begin
            @(posedge clk);
            wr_en = 1;
            din = din + 8'd1;
        end
        @(posedge clk);
        wr_en = 0;
        
        while (!empty) begin
            @(posedge clk);
            rd_en = 1;
        end
        @(posedge clk);
        rd_en = 0;
        #20;
        $finish;
    end
endmodule






