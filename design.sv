// Top-level circuit
module light_switch (
	input		logic		clk,
	input		logic		reset,
	input		logic		button,
	
	output	logic		light
);
	
	logic ff1_out0, ff1_out1, and_out, not_out, mux_out, ff2_out0, ff2_out1;
	
	flip_flop ff0(.clk(clk), .reset(reset), .in(button), .q(ff1_out0), .not_q(ff1_out1));
	
	assign and_out = button & ff1_out1;
	
	mux2to1 mux0(.in0(ff2_out0), .in1(ff2_out1), .select(and_out), .out(mux_out));
	
	flip_flop ff1(.clk(clk), .reset(reset), .in(mux_out), .q(ff2_out0), .not_q(ff2_out1));
	
	assign light = ff2_out0;
	
endmodule

// D-Flip Flop (for state transitions)
module flip_flop(
	input logic 	clk,
	input logic 	reset,
	input logic 	in,
	
	output logic 	q,
	output logic 	not_q
);
	
	logic data;
	
	always_ff @(posedge clk or posedge reset) begin
		if(reset) begin
			q <= 1'b0;
		end else begin
			q <= data;
		end
	end
	
	always_comb begin
		data = in;
	end
	
	assign not_q = ~q;

endmodule

// 2:1 Mux
module mux2to1(
	input logic	 	in0,
	input logic 	in1,
	input logic		select,
	
	output logic 	out
);

	always_comb begin
		unique case(select)
			0:
				out = in0;
			1:
				out = in1;
		endcase
	end

endmodule
