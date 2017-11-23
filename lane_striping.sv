module byte_striping #(
  parameter integer DATA_LANES = 4
) (
  input  logic [7:0][DATA_LANES-1:0] in,
  output logic [7:0] out[DATA_LANES]
);
  
  genvar i;
  generate for (i=0; i<DATA_LANES; i++) begin : gen_strip
    assign out[i] = in[i];
  end endgenerate
  
endmodule

module byte_destriping #(
  parameter integer DATA_LANES = 4
) (
  input  logic [7:0] in[DATA_LANES],
  output logic [7:0][DATA_LANES-1:0] out
);
  
  genvar i;
  generate for (i=0; i<DATA_LANES; i++) begin : gen_destrip
    assign out[i] = in[i];
  end endgenerate
  
endmodule
