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

parameter COM = K28p5; // Comma char ised for lane&link initialization and management
parameter STP = K27p7; // Marker for start of a Transaction layer packet
parameter SDP = K28p2; // Marker for start of a Data link layer packet
parameter END = K29p7; // Marker for end of a DLP/TLP
parameter EDB = K30p7; // Marker for end of a Bad or nullified TLP
parameter PAD = K23p7; // pad used in fraiming and link width & lane ordering negotiation
parameter SKP = K28p0; // skip order set for difference in data-rate btw links
parameter FTS = K28p1; // fast training sequence used in an ordered set to exit from L0s to L0
parameter IDL = K28p3; // electrical idle order set
parameter EIE = K28p7; // electrical idle exit order set
  
endpackage
