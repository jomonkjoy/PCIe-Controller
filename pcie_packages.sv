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
  }mem_s; 
  
  typedef struct {
    float i, r;
  }Complex;
  
  typedef enum logic [1:0] {
    gen1 = 2'b00, // 2.5Gbps
    gen2 = 2'b01, // 5Gbps
    gen3 = 2'b10  // 8Gbps
  }pcie_gen;
  
  typedef enum logic [7:0] {
    ACK          = 8'h00,
    NAK          = 8'h10,
    PM_ENTER_L1  = 8'h20,
    PM_ENTER_L23 = 8'h21
  }dllp_type;
  
  typedef enum logic [2:0] {
    nodata_3dw = 3'b000,
    nodata_4dw = 3'b001,
    data_3dw   = 3'b010,
    data_4dw   = 3'b011,
    tlp_prefix = 3'b100
  }tlp_fmt_type;
  
  typedef struct {
    tlp_fmt_type Fmt;
    logic [4:0]  Type;
    logic        RES2;
    logic        TC;
    logic        RES1;
    logic        Attr1;
    logic        RES0;
    logic        TH;
    logic        TD;
    logic        EP;
    logic [1:0]  Attr0;
    logic [1:0]  AT;
    logic [9:0]  Length; // MAX(tlp paylod size) = 1024
  }tlp_dw0_struct;
  
  typedef struct {
    logic [15:0] RequesterID;
    logic [7:0]  Tag;
    logic [3:0]  LastDWBE;
    logic [3:0]  FirstDWBE;
  }tlp_dw1_struct;
  
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
