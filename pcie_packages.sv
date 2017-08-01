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

parameter COM = K28p5;
parameter STP = K27p7;
parameter SDP = K28p2;
parameter END = K29p7;
parameter EDB = K30p7;
parameter PAD = K23p7;
parameter SKP = K28p0;
parameter FTS = K28p1;
parameter IDL = K28p3;
parameter EIE = K28p7;
  
endpackage
