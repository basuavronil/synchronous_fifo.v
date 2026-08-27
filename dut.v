module sync_fifo(
  input clk, rst, wr_en, rd_en, 
  input [7:0] data_in,
  output reg [7:0] data_out,
  output empty, full
);
  reg [7:0] mem [1023:0];
  reg [10:0]  wr_ptr, rd_ptr;
  integer i, j;
  
  // write logic
  always@(posedge clk or negedge rst)
    begin
      if (!rst) begin
        wr_ptr <= 11'd0;
        for (i=0; i<1024; i= i +1)
          begin 
            mem[i] <= 8'd0;
          end
      end
      else
        begin
          if ((wr_en == 1) && !full)
            begin
              mem[wr_ptr] <= data_in;
              wr_ptr <= wr_ptr + 1;
            end
        end
    end
  
  // read logic 
  always@(posedge clk or negedge rst)
    begin
      if (!rst) begin
        rd_ptr <= 11'd0;
        for (j = 0; j< 1024; j = j + 1)
          begin
            mem[j] <= 8'd0;
          end
      end
      else 
        begin
          if (rd_en && !empty)
            begin
              data_out <= mem[rd_ptr];
              rd_ptr <= rd_ptr + 1;
            end
        end
    end
  assign empty = (rd_ptr == wr_ptr);
  assign full = ((rd_ptr[10] != wr_ptr[10]) && (rd_ptr[9:0] == wr_ptr[9:0]));
endmodule 
        
        
