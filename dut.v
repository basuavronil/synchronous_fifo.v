module fifo (
    input  clk, rst_n, wr_en, rd_en,
    input  [7:0]  din, 
    output reg [7:0] dout,
    output full, empty
);

    reg [7:0] mem [0:15];  
    reg [3:0] wr_ptr, rd_ptr;
          



    // Write logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= 4'd0;
        end else if (wr_en && !full) begin
            mem[wr_ptr] <= din;
            wr_ptr <= wr_ptr + 1;
        end
    end

    // Read logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rd_ptr <= 4'd0;
            dout <= 8'd0;
        end else if (rd_en && !empty) begin
            dout <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
        end
    end
    assign full  = ((wr_ptr + 1) == rd_ptr);
    assign empty = (wr_ptr == rd_ptr);
    
    

endmodule
