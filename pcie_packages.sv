package packages;
  //=================================================
  // TypeDefs declaration
  //=================================================
typedef enum  {FALSE, TRUE} bool;
typedef struct {
  bit   [7:0]   addr;
  bit   [7:0]   data;
  bit           wr;
  bit           rd;
} mem_s; 

typedef struct {
  float i, r;
} Complex;

typedef enum {
  gen1 = 2'b00, // 2.5Gbps
  gen2 = 2'b01, // 5Gbps
  gen3 = 2'b10  // 8Gbps
} pcie_gen;

endpackage
