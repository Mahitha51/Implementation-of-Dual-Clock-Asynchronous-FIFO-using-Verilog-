module sync_rtow #(parameter address_size=4)
						(output reg [address_size:0] rptr_q2,
						 input [address_size:0] read_ptr,
                   input write_clk, wrst_n);
						 
reg [address_size:0] rptr_q1;
 always @(posedge write_clk or negedge wrst_n)
 if (!wrst_n) {rptr_q2,rptr_q1} <= 0;
 else {rptr_q2,rptr_q1} <= {rptr_q1,read_ptr};
 
endmodule 