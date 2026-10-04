/// Read-only AXI interface used by the instruction cache.
/// SCR1 fetches instructions through the AR and R channels only.
interface scr1_axi_if_ic #(
    parameter int unsigned ID_WIDTH   = 4,
    parameter int unsigned ADDR_WIDTH = 32,
    parameter int unsigned DATA_WIDTH = 32,
    parameter int unsigned USER_WIDTH = 4
);


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


    modport target (
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

endinterface : scr1_axi_if_ic
