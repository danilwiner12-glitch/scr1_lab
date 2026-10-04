/// Full AXI interface used by the data cache.
interface scr1_axi_if_dc #(
    parameter int unsigned ID_WIDTH   = 4,
    parameter int unsigned ADDR_WIDTH = 32,
    parameter int unsigned DATA_WIDTH = 32,
    parameter int unsigned USER_WIDTH = 4
);

    localparam int unsigned STRB_WIDTH = DATA_WIDTH / 8;


    logic [ID_WIDTH-1:0]   awid;
    logic [ADDR_WIDTH-1:0] awaddr;
    logic [7:0]            awlen;
    logic [2:0]            awsize;
    logic [1:0]            awburst;
    logic                  awlock;
    logic [3:0]            awcache;
    logic [2:0]            awprot;
    logic [3:0]            awregion;
    logic [USER_WIDTH-1:0] awuser;
    logic [3:0]            awqos;
    logic                  awvalid;
    logic                  awready;

    logic [DATA_WIDTH-1:0] wdata;
    logic [STRB_WIDTH-1:0] wstrb;
    logic                  wlast;
    logic [USER_WIDTH-1:0] wuser;
    logic                  wvalid;
    logic                  wready;

    logic [ID_WIDTH-1:0]   bid;
    logic [1:0]            bresp;
    logic                  bvalid;
    logic [USER_WIDTH-1:0] buser;
    logic                  bready;

    logic [ID_WIDTH-1:0]   arid;
    logic [ADDR_WIDTH-1:0] araddr;
    logic [7:0]            arlen;
    logic [2:0]            arsize;
    logic [1:0]            arburst;
    logic                  arlock;
    logic [3:0]            arcache;
    logic [2:0]            arprot;
    logic [3:0]            arregion;
    logic [USER_WIDTH-1:0] aruser;
    logic [3:0]            arqos;
    logic                  arvalid;
    logic                  arready;

    logic [ID_WIDTH-1:0]   rid;
    logic [DATA_WIDTH-1:0] rdata;
    logic [1:0]            rresp;
    logic                  rlast;
    logic [USER_WIDTH-1:0] ruser;
    logic                  rvalid;
    logic                  rready;

  
    modport initiator (
        output awid,
        output awaddr,
        output awlen,
        output awsize,
        output awburst,
        output awlock,
        output awcache,
        output awprot,
        output awregion,
        output awuser,
        output awqos,
        output awvalid,
        input  awready,

        output wdata,
        output wstrb,
        output wlast,
        output wuser,
        output wvalid,
        input  wready,

        input  bid,
        input  bresp,
        input  bvalid,
        input  buser,
        output bready,

        output arid,
        output araddr,
        output arlen,
        output arsize,
        output arburst,
        output arlock,
        output arcache,
        output arprot,
        output arregion,
        output aruser,
        output arqos,
        output arvalid,
        input  arready,

        input  rid,
        input  rdata,
        input  rresp,
        input  rlast,
        input  ruser,
        input  rvalid,
        output rready
    );
    // Memory or an interconnect answers read and write transactions.
    modport target (
        input  awid,
        input  awaddr,
        input  awlen,
        input  awsize,
        input  awburst,
        input  awlock,
        input  awcache,
        input  awprot,
        input  awregion,
        input  awuser,
        input  awqos,
        input  awvalid,
        output awready,

        input  wdata,
        input  wstrb,
        input  wlast,
        input  wuser,
        input  wvalid,
        output wready,

        output bid,
        output bresp,
        output bvalid,
        output buser,
        input  bready,

        input  arid,
        input  araddr,
        input  arlen,
        input  arsize,
        input  arburst,
        input  arlock,
        input  arcache,
        input  arprot,
        input  arregion,
        input  aruser,
        input  arqos,
        input  arvalid,
        output arready,

        output rid,
        output rdata,
        output rresp,
        output rlast,
        output ruser,
        output rvalid,
        input  rready
    );

endinterface : scr1_axi_if_dc
