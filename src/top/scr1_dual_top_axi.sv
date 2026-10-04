/// Two-hart SCR1 cluster before memory arbitration is added.
/// Each hart has private instruction and data caches and four independent AXI
/// connections are intentionally exposed at this level.

`include "scr1_arch_description.svh"
`ifdef SCR1_IPIC_EN
`include "scr1_ipic.svh"
`endif

module scr1_dual_top_axi (
    input logic pwrup_rst_n,
    input logic rst_n,
    input logic cpu_rst_n,
    input logic test_mode,
    input logic test_rst_n,
    input logic clk,
    input logic rtc_clk,

`ifdef SCR1_IPIC_EN
    input logic [SCR1_IRQ_LINES_NUM-1:0] hart0_irq_lines,
    input logic [SCR1_IRQ_LINES_NUM-1:0] hart1_irq_lines,
`else
    input logic                          hart0_ext_irq,
    input logic                          hart1_ext_irq,
`endif
    input logic                          hart0_soft_irq,
    input logic                          hart1_soft_irq,

    scr1_axi_if_ic.initiator             hart0_imem_axi,
    scr1_axi_if_dc.initiator             hart0_dmem_axi,
    scr1_axi_if_ic.initiator             hart1_imem_axi,
    scr1_axi_if_dc.initiator             hart1_dmem_axi
);

    localparam logic [`SCR1_XLEN-1:0] HART0_ID = 0;
    localparam logic [`SCR1_XLEN-1:0] HART1_ID = 1;

    scr1_hart_axi #(
        .HART_ID (HART0_ID)
    ) i_hart0 (
        .pwrup_rst_n (pwrup_rst_n),
        .rst_n       (rst_n),
        .cpu_rst_n   (cpu_rst_n),
        .test_mode   (test_mode),
        .test_rst_n  (test_rst_n),
        .clk         (clk),
        .rtc_clk     (rtc_clk),
`ifdef SCR1_IPIC_EN
        .irq_lines   (hart0_irq_lines),
`else
        .ext_irq     (hart0_ext_irq),
`endif
        .soft_irq    (hart0_soft_irq),
        .imem_axi    (hart0_imem_axi),
        .dmem_axi    (hart0_dmem_axi)
    );

    scr1_hart_axi #(
        .HART_ID (HART1_ID)
    ) i_hart1 (
        .pwrup_rst_n (pwrup_rst_n),
        .rst_n       (rst_n),
        .cpu_rst_n   (cpu_rst_n),
        .test_mode   (test_mode),
        .test_rst_n  (test_rst_n),
        .clk         (clk),
        .rtc_clk     (rtc_clk),
`ifdef SCR1_IPIC_EN
        .irq_lines   (hart1_irq_lines),
`else
        .ext_irq     (hart1_ext_irq),
`endif
        .soft_irq    (hart1_soft_irq),
        .imem_axi    (hart1_imem_axi),
        .dmem_axi    (hart1_dmem_axi)
    );

endmodule : scr1_dual_top_axi
