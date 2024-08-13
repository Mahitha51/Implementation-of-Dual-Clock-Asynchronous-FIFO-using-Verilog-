module rptr_empty #(parameter ADDRSIZE = 4)
 (output reg rempty,
 output [ADDRSIZE-1:0] read_addr,
 output reg [ADDRSIZE :0] read_ptr,
 input [ADDRSIZE :0] wptr_q2,
 input rinc, rclk, rrst_n);
 reg [ADDRSIZE:0] rbin;
 wire [ADDRSIZE:0] rgraynext, rbinnext;
 
 always @(posedge rclk or negedge rrst_n)
 if (!rrst_n) {rbin, read_ptr} <= 0;
 else {rbin, read_ptr} <= {rbinnext, rgraynext};

 assign read_addr = rbin[ADDRSIZE-1:0];
 assign rbinnext = rbin + (rinc & ~rempty);
 assign rgraynext = (rbinnext>>1) ^ rbinnext;
 
 assign rempty_val = (rgraynext == wptr_q2);
 always @(posedge rclk or negedge rrst_n)
 if (!rrst_n) rempty <= 1'b1;
 else rempty <= rempty_val;
endmodule