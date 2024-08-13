module asyn_fifo #(parameter DSIZE = 8,
					parameter ASIZE = 4)
  (output [DSIZE-1:0] read_data,
	output full,
	output rempty,
	input [DSIZE-1:0] write_data,
	input winc, write_clk, wrst_n,
	input rinc, rclk, rrst_n);

	wire [ASIZE-1:0] write_addr, read_addr;
	wire [ASIZE:0] wptr, read_ptr, rptr_q2, wptr_q2;
	
	sync_rtow instance1 (.rptr_q2(rptr_q2), .read_ptr(read_ptr),
							.write_clk(write_clk), .wrst_n(wrst_n));
	
	sync_wtor instance2 (.wptr_q2(wptr_q2), .wptr(wptr),
							.rclk(rclk), .rrst_n(rrst_n));
							
	fifo_mem #(DSIZE, ASIZE) instance3
								(.read_data(read_data), .write_data(write_data),
								.write_addr(write_addr), .read_addr(read_addr),
								.write_en(winc), .full(full),
								.write_clk(write_clk));
	rptr_empty #(ASIZE) instance4
								(.rempty(rempty), .read_addr(read_addr),
								.read_ptr(read_ptr), .wptr_q2(wptr_q2),
								.rinc(rinc), .rclk(rclk),
								.rrst_n(rrst_n));
	wptr_full #(ASIZE) instance5
								(.full(full), .write_addr(write_addr),
								.wptr(wptr), .rptr_q2(rptr_q2),
								.winc(winc), .write_clk(write_clk),
								.wrst_n(wrst_n));
endmodule 