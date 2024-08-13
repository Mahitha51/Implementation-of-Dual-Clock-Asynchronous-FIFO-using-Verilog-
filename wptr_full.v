module wptr_full #(parameter ADDRSIZE = 4)
 (output reg full,
 output [ADDRSIZE-1:0] write_addr,
 output reg [ADDRSIZE :0] wptr,
 input [ADDRSIZE :0] rptr_q2,
 input winc, write_clk, wrst_n);
 reg [ADDRSIZE:0] wbin;
 wire [ADDRSIZE:0] wgraynext, wbinnext;

 always @(posedge write_clk or negedge wrst_n)
 if (!wrst_n) {wbin, wptr} <= 0;
 else {wbin, wptr} <= {wbinnext, wgraynext};

 assign write_addr = wbin[ADDRSIZE-1:0];
 assign wbinnext = wbin + (winc & ~full);
 assign wgraynext = (wbinnext>>1) ^ wbinnext;
 
 assign full_val = (wgraynext=={~rptr_q2[ADDRSIZE:ADDRSIZE-1],
 rptr_q2[ADDRSIZE-2:0]});
 always @(posedge write_clk or negedge wrst_n)
 if (!wrst_n) full <= 1'b0;
 else full <= full_val;
endmodule