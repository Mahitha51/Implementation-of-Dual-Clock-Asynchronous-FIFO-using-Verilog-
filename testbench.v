module testbench;

	// Inputs
	reg [7:0] write_data;
	reg winc;
	reg write_clk;
	reg wrst_n;
	reg rinc;
	reg rclk;
	reg rrst_n;

	// Outputs
	wire [7:0] read_data;
	wire full;
	wire rempty;

	
	asyn_fifo dut (
		.read_data(read_data), 
		.full(full), 
		.rempty(rempty), 
		.write_data(write_data), 
		.winc(winc), 
		.write_clk(write_clk), 
		.wrst_n(wrst_n), 
		.rinc(rinc), 
		.rclk(rclk), 
		.rrst_n(rrst_n)
	);

	initial begin
		// Initialize Inputs
		write_data = 0;
		winc = 0;
		write_clk = 0; //5ns
		wrst_n = 0; 
		rinc = 0;
		rclk = 0; //10ns
		rrst_n = 0;

		
		#4;
		write_data = 1;
		
		winc = 1;
		rinc = 1;
		wrst_n = 1;
		rrst_n = 1;
		#10 write_data=2;
		#6 write_data=3;
	end
	always begin 
		#5;
		write_clk = ~write_clk;
	end
	always begin 
		#10;
		rclk = ~rclk;
	end

initial 
#100 $finish;
      
endmodule