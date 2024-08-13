module sync_wtor#(parameter address_size=4)
                 (output reg [address_size:0] wptr_q2,
					   input [address_size:0] wptr,
                  input rclk, rrst_n);
 reg [address_size:0] wptr_q1;
 always @(posedge rclk or negedge rrst_n)
 if (!rrst_n) {wptr_q2,wptr_q1} <= 0;
 else {wptr_q2,wptr_q1} <= {wptr_q1,wptr};
endmodule 