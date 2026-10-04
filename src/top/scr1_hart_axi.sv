/// Adapter between the flat AXI ports of scr1_top_axi and grouped interfaces.
/// One instance of this module represents one complete SCR1 hart with private
/// instruction and data caches.

`include "scr1_arch_description.svh"
`ifdef SCR1_IPIC_EN
`include "scr1_ipic.svh"
`endif

module scr1_hart_axi #(
    parameter logic [`SCR1_XLEN-1:0] HART_ID = '0
) (
    input logic pwrup_rst_n,
    input logic rst_n,
    input logic cpu_rst_n,
    input logic test_mode,
    input logic test_rst_n,
    input logic clk,
    input logic rtc_clk,

`ifdef SCR1_IPIC_EN
    input logic [SCR1_IRQ_LINES_NUM-1:0] irq_lines,
`else
    input logic                          ext_irq,
`endif
    input logic                          soft_irq,

    scr1_axi_if_ic.initiator             imem_axi,
    scr1_axi_if_dc.initiator             dmem_axi
);

    scr1_top_axi i_scr1 (
        .pwrup_rst_n          (pwrup_rst_n),
        .rst_n                (rst_n),
        .cpu_rst_n            (cpu_rst_n),
        .test_mode            (test_mode),
        .test_rst_n           (test_rst_n),
        .clk                  (clk),
        .rtc_clk              (rtc_clk),

`ifdef SCR1_DBG_EN
        .sys_rst_n_o          (),
        .sys_rdc_qlfy_o       (),
`endif

        .fuse_mhartid          (HART_ID),
`ifdef SCR1_DBG_EN
        .fuse_idcode          (`SCR1_TAP_IDCODE),
`endif

`ifdef SCR1_IPIC_EN
        .irq_lines            (irq_lines),
`else
        .ext_irq              (ext_irq),
`endif
        .soft_irq             (soft_irq),

        // Debug transport is deliberately disabled during initial dual-hart
        // bring-up. Each hart still contains its normal SCR1 debug logic.
`ifdef SCR1_DBG_EN
        .trst_n               (1'b1),
        .tck                  (1'b0),
        .tms                  (1'b0),
        .tdi                  (1'b0),
        .tdo                  (),
        .tdo_en               (),
`endif

        // Instruction memory is read-only. Unused AXI write channels are
        // terminated here instead of being repeated at every higher level.
        .io_axi_imem_awid     (),
        .io_axi_imem_awaddr   (),
        .io_axi_imem_awlen    (),
        .io_axi_imem_awsize   (),
        .io_axi_imem_awburst  (),
        .io_axi_imem_awlock   (),
        .io_axi_imem_awcache  (),
        .io_axi_imem_awprot   (),
        .io_axi_imem_awregion (),
        .io_axi_imem_awuser   (),
        .io_axi_imem_awqos    (),
        .io_axi_imem_awvalid  (),
        .io_axi_imem_awready  (1'b0),
        .io_axi_imem_wdata    (),
        .io_axi_imem_wstrb    (),
        .io_axi_imem_wlast    (),
        .io_axi_imem_wuser    (),
        .io_axi_imem_wvalid   (),
        .io_axi_imem_wready   (1'b0),
        .io_axi_imem_bid      ('0),
        .io_axi_imem_bresp    ('0),
        .io_axi_imem_bvalid   (1'b0),
        .io_axi_imem_buser    ('0),
        .io_axi_imem_bready   (),

        .io_axi_imem_arid     (imem_axi.arid),
        .io_axi_imem_araddr   (imem_axi.araddr),
        .io_axi_imem_arlen    (imem_axi.arlen),
        .io_axi_imem_arsize   (imem_axi.arsize),
        .io_axi_imem_arburst  (imem_axi.arburst),
        .io_axi_imem_arlock   (imem_axi.arlock),
        .io_axi_imem_arcache  (imem_axi.arcache),
        .io_axi_imem_arprot   (imem_axi.arprot),
        .io_axi_imem_arregion (imem_axi.arregion),
        .io_axi_imem_aruser   (imem_axi.aruser),
        .io_axi_imem_arqos    (imem_axi.arqos),
        .io_axi_imem_arvalid  (imem_axi.arvalid),
        .io_axi_imem_arready  (imem_axi.arready),
        .io_axi_imem_rid      (imem_axi.rid),
        .io_axi_imem_rdata    (imem_axi.rdata),
        .io_axi_imem_rresp    (imem_axi.rresp),
        .io_axi_imem_rlast    (imem_axi.rlast),
        .io_axi_imem_ruser    (imem_axi.ruser),
        .io_axi_imem_rvalid   (imem_axi.rvalid),
        .io_axi_imem_rready   (imem_axi.rready),

        .io_axi_dmem_awid     (dmem_axi.awid),
        .io_axi_dmem_awaddr   (dmem_axi.awaddr),
        .io_axi_dmem_awlen    (dmem_axi.awlen),
        .io_axi_dmem_awsize   (dmem_axi.awsize),
        .io_axi_dmem_awburst  (dmem_axi.awburst),
        .io_axi_dmem_awlock   (dmem_axi.awlock),
        .io_axi_dmem_awcache  (dmem_axi.awcache),
        .io_axi_dmem_awprot   (dmem_axi.awprot),
        .io_axi_dmem_awregion (dmem_axi.awregion),
        .io_axi_dmem_awuser   (dmem_axi.awuser),
        .io_axi_dmem_awqos    (dmem_axi.awqos),
        .io_axi_dmem_awvalid  (dmem_axi.awvalid),
        .io_axi_dmem_awready  (dmem_axi.awready),
        .io_axi_dmem_wdata    (dmem_axi.wdata),
        .io_axi_dmem_wstrb    (dmem_axi.wstrb),
        .io_axi_dmem_wlast    (dmem_axi.wlast),
        .io_axi_dmem_wuser    (dmem_axi.wuser),
        .io_axi_dmem_wvalid   (dmem_axi.wvalid),
        .io_axi_dmem_wready   (dmem_axi.wready),
        .io_axi_dmem_bid      (dmem_axi.bid),
        .io_axi_dmem_bresp    (dmem_axi.bresp),
        .io_axi_dmem_bvalid   (dmem_axi.bvalid),
        .io_axi_dmem_buser    (dmem_axi.buser),
        .io_axi_dmem_bready   (dmem_axi.bready),
        .io_axi_dmem_arid     (dmem_axi.arid),
        .io_axi_dmem_araddr   (dmem_axi.araddr),
        .io_axi_dmem_arlen    (dmem_axi.arlen),
        .io_axi_dmem_arsize   (dmem_axi.arsize),
        .io_axi_dmem_arburst  (dmem_axi.arburst),
        .io_axi_dmem_arlock   (dmem_axi.arlock),
        .io_axi_dmem_arcache  (dmem_axi.arcache),
        .io_axi_dmem_arprot   (dmem_axi.arprot),
        .io_axi_dmem_arregion (dmem_axi.arregion),
        .io_axi_dmem_aruser   (dmem_axi.aruser),
        .io_axi_dmem_arqos    (dmem_axi.arqos),
        .io_axi_dmem_arvalid  (dmem_axi.arvalid),
        .io_axi_dmem_arready  (dmem_axi.arready),
        .io_axi_dmem_rid      (dmem_axi.rid),
        .io_axi_dmem_rdata    (dmem_axi.rdata),
        .io_axi_dmem_rresp    (dmem_axi.rresp),
        .io_axi_dmem_rlast    (dmem_axi.rlast),
        .io_axi_dmem_ruser    (dmem_axi.ruser),
        .io_axi_dmem_rvalid   (dmem_axi.rvalid),
        .io_axi_dmem_rready   (dmem_axi.rready)
    );

endmodule : scr1_hart_axi
