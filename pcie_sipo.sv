module pcie_sipo #(
  parameter TIMEOUT = 16*1024;
  parameter DATA_WIDTH = 10
) (
  input  logic clk,
  input  logic reset,
  input  logic data_in,
  input  logic [DATA_WIDTH-1:0] comma_char,
  output logic allign,
  output logic [DATA_WIDTH-1:0] data_out,
  output logic data_out_valid
);

  typedef enum {IDLE,ALLIGN} state_type;
  state_type state = IDLE;
  
  localparam TIMEOUT_WIDTH = $clog2(TIMEOUT);
  localparam COUNT_WIDTH = $clog2(DATA_WIDTH);
  
  logic [TIMEOUT_WIDTH-1:0] timeout = {TIMEOUT_WIDTH{1'b0}};
  logic [COUNT_WIDTH-1:0] count = {COUNT_WIDTH{1'b0}};
  
  always_ff @(posedge clk) begin
    if (reset) begin
      timeout <= {TIMEOUT_WIDTH{1'b0}};
    end else if (data_out == comma_char && data_out_valid) begin
      timeout <= {TIMEOUT_WIDTH{1'b0}};
    end else if (state == ALLIGN) begin
      timeout <= timeout + 1;
    end else begin
      timeout <= {TIMEOUT_WIDTH{1'b0}};
    end
  end
  
  always_ff @(posedge clk) begin
    data_out <= {data_out[DATA_WIDTH-2:0],data_in};
  end
  
  always_ff @(posedge clk) begin
    if (reset) begin
      allign <= 1'b0;
    end else if (timeout >= TIMEOUT-1) begin
      allign <= 1'b0;
    end else if (state == IDLE && data_out == comma_char) begin
      allign <= 1'b1;
    end
  end
  
  always_ff @(posedge clk) begin
    if (state == ALLIGN && count >= DATA_WIDTH-1) begin
      count <= {COUNT_WIDTH{1'b0}};
    end else if (state == ALLIGN) begin
      count <= count + 1;
    end else begin
      count <= {COUNT_WIDTH{1'b0}};
    end
  end
  
  always_ff @(posedge clk) begin
    if (state == ALLIGN && count >= DATA_WIDTH-1) begin
      data_out_valid <= 1'b1;
    end else begin
      data_out_valid <= 1'b0;
    end
  end
  
  always_ff @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      case (state)
        IDLE : begin
          if (data_out == comma_char) begin
            state <= ALLIGN;
          end
        end
        ALLIGN : begin
          if (timeout >= TIMEOUT-1) begin
            state <= IDLE;
          end
        end
        default : begin
          state <= IDLE;
        end
      endcase
    end
  end
  
endmodule
