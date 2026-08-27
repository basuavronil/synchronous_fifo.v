module tb;
  reg clk, rst, wr_en, rd_en;
  reg [7:0] data_in;
  wire empty, full;
  wire [7:0] data_out;
  sync_fifo dut (.clk(clk), .rst(rst), .wr_en(wr_en), .rd_en(rd_en), .data_in(data_in), .data_out(data_out), .empty(empty), .full(full));
  initial begin
    clk = 1'd0;
    forever #5 clk = ~clk;
  end
  initial begin
    rst = 1'd0;
    wr_en = 1'd0;
    rd_en = 1'd0;
    data_in = 8'd0;
    $monitor(" wr_en = %0d rd_en = %0d data in = %0d data out = %0d empty = %0d full = %0d", wr_en , rd_en, data_in, data_out, empty, full);
    #10;
    rst = 1'd1;
    wr_en = 1'd1;
    repeat(1025) begin;
      data_in = data_in + 10;
      #10;
    end
    #15;
    $finish;
  end
endmodule 
      
