module fifo_mem#(parameter datasize=8,parameter address = 4,parameter depth =16)
					 (output [datasize-1:0] read_data, 
					  input [datasize-1:0]  write_data, 
					  input [address-1:0] write_addr,read_addr,
					  input write_en,write_clk,full);

reg [datasize-1:0] mem [depth-1:0]; 			  
assign read_data = mem[read_addr];

always@(posedge write_clk)
	begin
		if(write_en && !full)
			mem[write_addr] = write_data;
	end

endmodule
					   