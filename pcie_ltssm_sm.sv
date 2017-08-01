module pcie_ltssm_sm (
  input  logic clk,
  input  logic reset,
  input  logic init_state,
  output logic link_up
);

  typedef enum {
    DETECT,
    POLLING,
    CONFIG,
    RECOVERY,
    L0,
    L0S,
    L1,
    L2,
    DISABLE,
    LOOPBACK,
    HOTRESET
  } state_type;
  state_type state = DETECT;
  
  always_ff @(posedge clk) begin
    if (reset) begin
      state <= DETECT;
    end else if (init_state) begin
      state <= DETECT;
    end else begin
      case (state)
        DETECT : begin
          if (detect_complete) begin
            state <= POLLING;
          end
        end
        POLLING : begin
          if (polling_invalid) begin
            state <= DETECT;
          end else if (polling_complete) begin
            state <= CONFIG;
          end
        end
        CONFIG : begin
          if (config_invalid) begin
            state <= DETECT;
          end else if (disable_valid) begin
            state <= DISABLE;
          end else if (recovery_valid) begin
            state <= RECOVERY;
          end else if (loopback_valid) begin
            state <= LOOPBACK;
          end else if (config_complete) begin
            state <= L0;
          end
        end
        RECOVERY : begin
          if (recovery_invalid) begin
            state <= DETECT;
          end else if (disable_valid) begin
            state <= DISABLE;
          end else if (hotreset_valid) begin
            state <= HOTRESET;
          end else if (loopback_valid) begin
            state <= LOOPBACK;
          end else if (loopback_to_config) begin
            state <= CONFIG;
          end else if (loopback_to_l0) begin
            state <= L0;
          end
        end
        L0 : begin
          if (recovery_vaild) begin
            state <= RECOVERY;
          end else if (l0_complete) begin
            state <= L0S;
          end
        end
        L0S : begin
          if (l0s_complete) begin
            state <= RECOVERY;
          end
        end
        L1 : begin
          if (l1_complete) begin
            state <= RECOVERY;
          end
        end
        L2 : begin
          if (l2_complete) begin
            state <= DETECT;
          end
        end
        DISABLE : begin
          if (disable_complete) begin
            state <= DETECT;
          end
        end
        LOOPBACK : begin
          if (loopback_complete) begin
            state <= DETECT;
          end
        end
        HOTRESET : begin
          if (hotreset_complete) begin
            state <= DETECT;
          end
        end
        default : begin
          state <= DETECT;
        end
      endcase
    end
  end
  
endmodule
