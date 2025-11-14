// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Oct 30 17:27:40 2024
// Host        : sec-academic-1.int.seas.harvard.edu running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/jennifersiyuanzhou/cs1410_course_repo/lab4/lab4_server/project_1.gen/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1_sim_netlist.v
// Design      : blk_mem_gen_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a75tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_1,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_1
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    enb,
    web,
    addrb,
    dinb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [3:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [31:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;

  wire [31:0]addra;
  wire [31:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]dinb;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire ena;
  wire enb;
  wire [3:0]wea;
  wire [3:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "32" *) 
  (* C_ADDRB_WIDTH = "32" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "1" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     10.7492 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_1.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1536" *) 
  (* C_READ_DEPTH_B = "1536" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "1536" *) 
  (* C_WRITE_DEPTH_B = "1536" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_1_blk_mem_gen_v8_4_5 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[12:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addrb[12:2],1'b0,1'b0}),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[31:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VHPlDkoDlWlBfBMvPBmGYmaek3s9hXXhjF28kllYPnaNm3TSnzzpXHWHc8Ye9/2L2yiQfJ1hTWou
Ia/zeQ8h9/dtr6QB5YkyW4wlb/LbMgXb+DGIXPSllNl0IMsRQIcQDbcQm1bO/nlhb+2pjxiuaQrl
DbvxoDwPs7z3LunRxsg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lmIhoX8hXuc7tNV1sXY1K2/gXL7Y7Hq73qQF7+x03UWWTRd3uhGmVQtOMVbhIW+66UkWUHiD26zL
fzqGor8bgSNGpSFyS11k4TwLQT4OfAMGO8C9Qmmh4+VENBnpS9TW+wHzCv8oUwht7xYtYRZvOvYK
F3fMppz2sBkUd1lciw98ZE/UmNkhqBuMfIYF43j45DEJ55PBhOZNg91Ls4v3qBHyBAaYPFFoMry3
d5Fw1PZyFQSEOSSpwgyds2aN0g6oIwl7zm0LJrM9VDAOxBUE50hk+oHr4jj8J8UhHQJnlEHm1Idm
rvxKygNKRvfSpa90NYxZJFYgqnrMYg+19+9aZA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VkyCjO2onoeZWEoYQ/4ue7X5mkHyTYVW9xjdoTsGS4GdP/Q64VaCZL/jr6R8DVDXPMnH7tRMrDpo
jpYBnyzSgOkfgqM+96ioC2fDyAaG4gYgGLmrBR6qK3/mxXwAZZX+GJ9R/eWXkc9h8xN+gsSSX6/M
jIQCgeT6q7PB4dWT6KY=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Iub91V+TnhVlZCSLu6iKmFjix71y6/l83OPTs8uewWvkE7WcqYxEKi9fonXEkzAtWzuKwEUqnOlN
VBsNJqPUdKcd22q523mrdt89mpdosWD+hvZdO7ELhJniY5u9h49FFkubpN2JiUTcIcKEYxVNlds4
wyvaYUqbPVH5v2ooJwDdimS4GVn9HerCOgPwfshvQDNlMTxLcYju4v8BHMc5Rub9Q/ihvpQU74v2
ouZ9XIwA+C6pBLwvaqS8jE7HXOokgqJilaX/W/t+KEgiFry/txRTMU9WMD7tCN7lcfjCydmS3Lq+
3u6Hsr0S8BwNjcaDpZDnBTygUJd4JSqREnk33w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
U46EWFmKmpZGaWfyL+dokyQtJtaOYsa7HCW/+fdtw9/yHKTWFpmqKBZngBj5rPkNhtTDDCJkqsYj
tUXg1j4tgIBaCQn9B0q/aG+B3gPLrudp9hLL25mVbsfiTzdekiV2hJMmhuMoavKKPJHC6zyW7kZi
80er82OQy8h+Df/fe6TRjH9xEt3/b80tRKUMbxkLfnnkAyyf1KfOhB6/uyI4mwXuQR+DsAbzybKR
YtXpOiW72tGrXTFlzcwbHamWZefqsilVpBw6V5dh33vYKGx50xwWpj76maAkpQrOpB7zufeldJe4
W1UOEN84AZdRTLkVSxamWo/wp8nP9fiGS/ItRw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qczgIJYpE/SzErzK7eWJBGcDFEzDLm8cKbwJbPXuM6YnJxx44W+E60R3war7K2QGFAkOoCDUtDC7
SghJGF32btaDLzeKm0tQ669sBtQmMIaBrlt7I9QBkNM8zN9GL92qxNC9o3UVWMOYy5BmH8nUPgcE
O6lRubeltlrTuDe7UJQ2nEPHcXjpUJJ8dxktyW+LovBy1OxW8g4GRAsmEJsoOEg0HuDdWcc4IshJ
PvwPJ7LblELAKsdkSt65y9VaklaEm7MlH4ImlgIa74TgRmutLUbWxM1QYhGE5rAzFhGU5i3RJOdx
L3N7GGGvLMW2z9NSHbIFX+/eNII9fNJ9nZbgLA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ti1NUgDv8YPk90APMwfu/mRr38QYwAxZfv0T6zQ89YS55t2EquEGVqrEafYX6rTydLOw8le1Oucv
f2oERpSSSTih/ScZneSZmuPE/Zh2BU1Ajv0j+/+0uEWXU+5lLPbDJjnapTmJXih1MYPf0SHpZZmE
BKj2IEBI9MPZlh6bxpa5BWJnyPdAvHf+UNaMXU9+pmbtrzUVebql4mFJu45Z3+ehmFY4FBW3zXMF
44C4TlHACLwL3vHVMCVfeKhgdVDbpE+/IFhTStz7mZ9h9RKGanQcs6YDVM1R+2RKA1QT1fX4FiQc
1V+FGmrm1ujxmFGXwpfNKByVlfCY0oWhRJCYYQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
HuEXFK0NXt09xU2yxxjng1OLsT+ZEM4EhqBgpr9D2ljw2vDaMBrqEsRQTc2B9soDq3ewDduHJXBd
OGYxkPnoN6LhjULtB2nTgjcH6NxA4puZ1ZNcndDndVBo8rTW5W1OqHq6InAG0CqPpTIkuqz3ECPl
EysI++MCDfH6tIzlekxJFIJ1McJsTq5rFuLzMMcrmkBxgcayDpOcCFuzZzCczxmt/cCCIKmDybwT
OQXmOcLJoYLP4sFu6R9c6xO8i6p++crv2N3eIxZHKbek9xBBZqQM9EYuEtsbkqAs9XZpa16i5njR
BDFxTKcP6r7JgFALJE89AZhBbate5JXWp0v4ECZD18aEL17CipwcWPutNMdG1apzSPP5y59n7rMG
yxBPz1gKHc3Emkl4WcO0hjICxqmO6dMXoY8JvBSf6ry2l0sH9Ihr3Bq5WWmlhPHnoaNr5jl//vNe
KfToWtn97eoVSt1LnmXXnSpdigbHr0UIg8AdkpdkuNRaWdVicDdgSo49

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mokwst2bn6UxD6V9UdIgCIG1QQ/d0FiJqYGOTI2eHPV6YElaLjnJ8DnQmZnGS95o3x93FDOoa58C
RwYsX1fVoVtXkj1LuZq0k7q9vEe4T8xMjpkeYtIHY9k0Xhy1Lq/xRlfzGAf9fvf9e+f4r7aR/Sb/
uCZxxugG5niTwLENY1n3NthYL0jvo8Fmdw4Qg0nTCGWlVCws+09K0g9/lx6I9EcuHHemcHO3fOZG
lMc4NaPNozKwnyDMoWUkwiVxyFEPFaQLNYqzjvR+CqrWfhFLo96JWhL+eaDoNuZoBVYQtNH5ZwBL
BoO27Pw10lgcReGlZBz3BLO7T4ddynCx0+eSnw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PiP7AjOQqqouyQMoBQqgWIDhUSViq94rIvGiIJ/UKMDspM/yXw1caE8AhWHTjYckC4yLpPAz5P6s
1Z6flzDPrzVwg4e59X2cc4IMCHhedna0rDO804njcc6amRDTeLsMLTkWfvomB4xwszm2AgT+PRnB
WHd09ZUDVFjiBXT+Oa9AicgGJHrX3w823yBPuAa704kje/SzgtiDpcTU1eLmLhLW7LpEd9KIHd9s
ER7Uk9Orws0Kq9PMTqMX4hMn5K5mFakOeOURiEbUjdv5RiIJ2g/PlQXSItM8fHsBTQa6fOaJwQTI
vHwK3a8ZBHpfT1YH+n7wNiNUZwD4SFXm1QVx4g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ul5ZfTHJwMctaNhYRortUZizYMPYRef7uYqPSuMkxsArnxI/cjGh+KRMwzV86hyp/6TXSJIjm5ec
2wX2UONdPN+DOJ84jYC4JbgJQrPnTj7ioD8uLX/WlyPcQzyF5keqFgj5eR5s13FskVWCuAWf5m9w
mhFEKFjVXDAr7gVgAJh/hL8P6Psrnf+LGfiM8JhnDepsHEYykGlpD3fzru2BGgqHWqPqFMcnyVGl
vysaIXiJz/eYKvO8RGcgd3DJAM/wPm9A0m/DWcmSnczOgTjoqkHcBg2H5uJMLvufzmjImi6LYEqq
v04ESDEN31cSUzqUYcayvMFOnI/WNsWbFIa5+Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 49888)
`pragma protect data_block
6pCIe9SOHTIXktG1Z0z3u6pGaKbglJMNoIVZtcM+jkAP+96+EnCLGbb6h2n9UXMi0UR5gKLNSFVc
oF6+MEGSOpQZvrwZ7VSeSvbwT3C2nP96HX83BPJ76FPTbzleL8m0YTL+Gdn48UhuHb/H76Bg2Rc4
0iYRO0Q0+Nq8xG/Eb9R3+ruxtt05xKYt/Vn/bDCtErxkiIriTwKUrN+Zl61upsqIecXiFi9MTaFY
Xg2i+9TdUTOVFdwr82wdKWj+7tQtWHDJZtEojZLYRXVr+UMKztdpi+0YNxXGdcG40UvU1SFOmDL/
JoyTm4eukCabPo+RBfWyyBaGNRS5plxnpqNc9R60jujljNXg0scmW86MfQ0Ez6GSTMqo86K/4T9h
56UFGBaPWrRFu2NFVzpQQDONXxLUE7TcchV/TaPKiMRnbYd6/9QQK9UBsyGv9oTKnuYNynxi0OH2
ugx6mXWLWlyPjeOMWnPL4YdruEG0hUUdkQNiYLwwiaqI6/FZERfZJAjLMgSFrnyuUCV0lNH1C2GL
TfHKEWtVb0gzF3jD1kuC/aVPofNfkj6v9Tnp73kZHl7h0At3AxfHVfARUKf/XofbU/kzbpP1MhCA
5W1ggb9MzS1b7hqIj1xyhpvNAK1GfZKUVQcucmqAUjH7nMeFvif3IweN0rZUdVr8A+stcji3QgoJ
UmDUO0xoaFAZvaG/+QkBKpBVpFYg50rWflgdFcITFlNh8iJyhQsa354oBGCg87GO1erzX7g/dfRF
hP14Toe+qUfMWch924xzVVC/Esw6ZkQ5tWPCA8d9WjYISc5w5nD/Lf5G2AQYwaCMNT/TpFVFFsLk
r68u1jtu17dqeHr0aG6CdWpYHraavve4SxqzMhYRMvKFz9afkdXCqqaReS7D6p9EhbJhg1fSLqpa
+U3u26fEq1H0FVD65ZM2+1CPfSDR0ILVKJXtupn+xIegn2qJiyBC6x3TwdZ3mJ5hdShl5ta2fFY2
tRGDPg7gD3FeMTf6Q7KbYk7SVNrScOSA6G0r3s1D4CWK8N0aIJ+X5tJwlfnAWvF61Wzu2qRdLJa4
BpqWzJ/wUKg+SKAOjOWIqzzZ2Gj9o2omntw2vrWf2W3OhzOUgciRI8d1Qoac1ThRFvHouSwJYSZ9
L0Pb2oItfun6g/UzlYv6o5emK8vjIs6So7+TxYZ8bnspcgI/ZrVrbGMB5+HrdglG/hnZxre0a2P1
Zk2Lo9dkBiDq2cvAsTDj/EFX2xAzt9Ysvuib7OdPnuO7jv7GGxQ0oEVAJU2YEndiFiVLxaIC3lHJ
NhqxE5WR9vSknJpUKU1WbmNzDXtKYIqoclQfGesgR2eFfQTtbsTKl2s2gl3W6qvBOuGdXwNNYmni
v7QsWaIYELdKDZmRvVobzJhQKJFBU8NGb8ziFFz6SnI36fgs9nJfYrb3rjOKw4gwO1hwrk7/a5Kt
NhF+y1fEBJwXd7FSe0kQ6KKF9X77JmKSYR1nOQBjzBy3K57PdFt3/rG2naEsRqv40jHWrAlTwG1P
f+UUWPA83takD8DPjirmulghjBtt24KLImX5qZlUgPkyowDlN7E9Vx2iCHnfysl39Ts5Fe5MF/y9
2i92LJ+pC6x9wBZFJW9Z3Wp6xFvdTJ60rYAmQsbEqPUYJAN5aEWjkj5Td+BrRlH8aekeKMlrwF+8
DxRT41q/F3I7BpwsP6s9bKnRPxYuGPKcJg9e/DRMTF7vnBsQq2NaWuGpuRxU8YK7+7WXMafP6E2l
x+o1d5aqgA/2h52La0G35bXlL7bshWa3U2CbNTlXZxPONddZd6wq88BckIJ2PE9792oJmf8cRvfZ
gvmgVjYryTU+TkanoBBIY2r8+bDSij7ISiDrIUZRpOvjC8ZnU8l5X4mRGOnpDme+edhVoCBzYWaF
YtQTk/O44qmmfCcWlySNvjbObcjukuPw2VLa2QOn2Wor6ngCl9LMjj60eeqXjwwm7a+B74FFwwru
035tZHKp5kySKIquoPkZRH9dqtJXh7xvXaRx9d0P9xwGkLQQPDSlIBpgk86DbEq3jbmogbQ0q12p
3y5DXb2+bAEGKNfHMjDVzrUHOSWmTL9k+zRyBuKs9vefRuLItZGQHUl5ef5OTYxds7FNw3I4LtYL
7f7/97pRNYjW7TT6Ur2XL6Abu9vyHORESFWlOfOwsXq/XGINICZg0dIK+6SkCpQQRdbGzyAtb4T9
JvjV09USJVkf5ffiKBBVHTnWhI9HFKQw47kHQ85V8E8C5QbqVyLjwPSU9oFvGEMw/pMDWGmbyz5e
NoFUQuiqpw4PCDSmg4MQfmm1eLha+Z5F5FSd7FJcOg3OGw2uu0cIFILrOM6d0hCLzjnIne0owCqa
aXPPDVnzNUnYTSiuCsZrW8yUgKdF0vqaobAMq2rrAlh5DYU8FYfZWpa8VREjnI8jz6QuoHULwyle
+o6WaDRQrxvoqyquw3o6FF9ZHAxMXUrzPC4Oa3gRGt0HdHpaaeWM7u6BdoSdVe1Htflky3jajfGL
e7K0oRn01v72PSAHWH2VyU4to06rCJIE5w8ylCFd0jrH6T2icN3EcWydNiLFy+UaVjSG0DqGWMht
SDjHAhh9AlIBC2jdwiAfgvO8IIU7XIcbgs8SSajXTFk/BD8+6xMZZMfE1VjXU4aaUyzHuUMsHZsJ
XeyDMm6tgVqvxcewSbsx4qxlJ4E3W4BCGsnX1q71/6ZQB69k5dbRBRpvKr/LGa9gGI1pcpjf7Xhf
QMbHSl+NTjh1YvgFCnChx0i8tKv+65ZIGY+DyZhd6ITHAFkJpR1va7x6AatKcxYAv4Gy9wTAPOCG
Z77nvku/NSbIlIMNBY+KgJiCqWtM+o59MXAtoFDI3B+92VITCxQ36aMKcz5MjB2Y17ShPN1MG4Bz
cr5KA7vvTnCi9CXHdP70cUqhbBRy64GTO1YfBfASdeFvchasfRQvpqmCijmEq5SYN/x6zarWu3fS
bLoDk7f0EeBPXai33EcSxQGl7OEbN36wtoIpv/JoIjf7SmYL0iacCgCwDmYBWwDUiruK9Ed7dBoL
LvxC4wVU+TOdYTa+0jA3FFRJF1sJLccBIPJd8bq+nnf1vzmKvozHgnCvJaIabavRMvD1tbfxy4DB
ZNUIhq0YapywI6PyiK00qG0jqyUtB7TinIfB1B+IphkEspO96WuH8E2xCbaxt1zX04BVmy5YxyrX
YDE4WRH7U5RgIzifnEOKid6A8b1GmD7jt7eFsKbiUvEtwAniXRBX4CLS07Bi9x41qFUDxSNqE8o0
LzL5q7tdTg00k5dc+zfxqhlAS++Z+xhmIivp2e4ITq7T3FbGC4nUyds7PE3O9dJiVQrYrwtiuIz/
Y8u1kpAsNevTLL1eXG5Ora2mPxwb87vmNcPu3Qii1oo7H1z+KKj9SAgfk5ZHpPXOsg8R4Q1Cst/K
jDZD/paCAA/SYZAO5oYcuxudDrbgPIQl0YdheNmVmTCuc7wmny96hZ08VQo++LSKqi2xx58DDuuj
hVJOPxf6Vq3IcluB6c2glzA6cosNkcPmzHhO7IyAE74fpCWIM4GUzagmP6hpO5HuaHGqC/FiCLFf
cpRew/leL7FRBc4Sd+RN2mn+JOQiCZCJwAHiUv/lQv/RiQDs86U8mUGWVp/PjNVvoO3y2xWGU78h
7lDznaE7beaOrLbvEKvEWaMXA3Mo2pHT+3PqXhShz0pPI3Ee7ut6A9mRRuzLlJl/gRbKkWtvEgG4
kOwSqIQg9UomslAGoby3JalsM2oJQKoA47p7J4g0KBd175z0U8Ncc6gBfrSXotr8NKsvM6uddhxb
XCamL4i5lRHN0nm8ROwOrXw1bN3gwrkEYNNH6SZAvWxGRozFw7jTUWvHIzt+TNWyKbftW5tdg6Bp
sd4+5XeQun8uJfIwK3bPSvTcvsG4NjnQQXBfpt2Od15Otg8OP8Dh5kkc3ijLd8QtnT7OcSEqFUFE
RSFme/cXe2jy0pQlOQJiySgxfhT8FT8BF3OQ3GpWRUT28FJs3cDEUia5nxugdo0NeWLK1+gSH5B/
nDVwa4vhkNFEszIgCfzUATM8r9Mn76rB8UdYgM0xYyRFm+P4naGDvdmHqydNw294ZhRGBcpTIT2d
/wGwaPTUVXFLlzRxPSTU9no/5d4/6hhKWQUjjSghVeBajAB8EGpVUrZe784jSXblxrr0b+kcpmIh
UM4K0lc0NBfQTcPORnkDTedZhB/gU08FMAH1BkTdaLiXvK/9c7tXJtANk0Khsd34E5mUYUEDhJWe
OITSc2dHn60WShM/l2ziAK8D6vIt/WtsFgLMMDSwbuH8FUCcRFKnGKbyhvome+wTW0Brpd3WbaMX
Sqgis0WiDYYSfuVlFhm2aKQMLAx6uNV1rMCVyVEg0A5V6DJqQkEpHdBfPNwal18QzQenVkDDzDWs
35kywYmdBW1pfcmFSwZiD6Sfn43vrPezuG4gn/slEOZMOJRyO4f5RODvg1EJWr19sNNdxwUwQqoM
6HwA+cm0J2m2F4pgQ5uBI25JNWNbogN8rmTtyRgwwHMjKieBlQCvSojlfYraEkBOe8HJ/pWnRKlP
EEy/k6/GHCFak3RPXRRUq5/qrg0dMZpteV65FdGVSI6/82S/cpCBvdSHSlZjzAdM8T8ex8zu8AHO
cboCfENIsbB/0wAG78KkoHvi05kl6V/3tU7o8XjBxOMpEf/3uqiLOr+BVrqgpIckauZ6SBTH0aVp
uZYsIswQ4N8Y+F1fH0bO3wgaGAn/eezMWrOnAHnUhoQJ0qJq0sksYxSrlCWYhpdLz3bH8geb7fIU
gmC7AdB58gNVKUNMamNgf5RcCC9rXM0nnuIuTuUmfTqVt4b6ENaSYIrkR5P6Ufv9dC0XaaWHTMK/
BiEm0nQU3yl8wxmLR7QDHVEfpdJQtDesy9bDyM9SHLH3Z0qHoaFooAX3dOjulvnMIyCOcckJZ3dY
ArUq9D61N4Q6tahgkrAfOBhf+PTBuvyJqtwHL/Af84UIhROTonV9KLIeNXGT39SiS8bJkfYUE/ly
kRZMIDcZ/TigQB08AGs7idch0ubkwBm2US6r0kFVj6Nvn19WSQT+qhOWVw4srzP/5n2YUHfvbvCh
cVxF6dx68jKWZxGA3BNiwN1YW7dSbUleusayKEJQE5lFpcyyRBsn3iyrAAczusjhT4xZDdo+VtYW
T911HtKq/8eybA3QbGbUv+eNrhmcmh75RK7R2rJYEzJoCgbpNaS6wOhuHWZ6RT4yZAIeOL98mEa3
qqcDOoBz+7a1xIdvp6Xtwoe9BlAF5qyCgdR4OxmVj9fbClQ/otOQ85bJuzlIonv23jlW6h/yVaM7
1pGau9r/+pOP8rWv4/QK/p/zMYl8BaaAa/b02tNXZ0S/MOQFmRvFLm83JYMTGnORY8jF5adD49GF
JqS3JHV5/oFJv8ToEQJz5ytB+kU1buBXkUaHF5L+WT5mv8qgqmJN12227v1LMuq/H2QOyTFfYfss
nqjjy7D48TsHMPuSeFZVEYc7TNiwY42/VfeyBegEOIFfyl9sfkdbVHhpT9muP/va3IUx+xR8cuIV
CQQJ9JRjc4RbGUA7y0UlIeOx3xa277CJRJ6BA+ffVWJOF2/ublQbl5rkcWH6rzFI5hSt9v9FY1zD
DuxwGR2q/PkMR0RoUlastktA87FJpxHcIpAaLhAsEOWRhtnQr16F/ySKrhlQjtCQqcg8En0ksaUe
auw8uWZILGEMEbgFlxj3XwPA52gA3/3tpHKZRemTDk5ITjYF59HQcbqiKcm5bMmW8a61DKEasEw8
FtioibH6oSv4Ggka6g/uUFPYYSrfdUEEPfW2AAVqmo/oeJrMobq7eRM1eJsJ8SDrOtXxf6C0iagE
waolNf1Iw9Wf1SkXKl3SKkOqvg/Skam2jdW8UL1DKpvhca1pM70ROa4IIxnNITgPruMuUorhY3y3
/11AfyjbjgkVB5d7lQaHzGzOiVZG9wbqXDMCc+tMhjCf5K8XuowDK3XYabTdVyl9JgBGbc2/oRrX
3AQTM93rIj+kWHzxShY42quisb1o7ikxOvW7PTNgFUOLQA56BlbE6nzA1iBXnWhemHevKpyHOv5Y
vmbyIih4uKICW/d6bE7in2zVroo2+DUMyJ3BUFIaL2CxNo1rq0rM7A/Ag8ouPzehlEpA3S+HkXps
VFAH9oEFKH30j6Jm6+eVl2CgUHCO7v1j1lWjYvLRAn19HeotxKHnLowaQsHZWR4WfdrehU99+s2w
8gGfyYQWQt48ilynFbp3aC41Du63GmKeXcn5LHQd1UmUphi752Hila/kQCWiQAP6YHwlDhdHG6et
3WaFuyAREFZsSnlQf1Hc9EqIbdY+KwzX5e6v00CLehDJ5jAeESGDsCBqL4hhQZCYtHE99WrvSNtK
rJAlwBp4puXFX/jPEmLwMraIIvr4T8+9SRrbZaUX190aSN1F+g+9mf11rsxSOfLDqH58o+iKz+tt
qahpY8iz3mxd3S/wZZBtMYQ9hFXWAmRWtfrAHGXacshLojhCfn+VmXD6ZG10pB+r9dqQpLnY8XlM
N4EWoqwKm7Xc5XAlvbhXv1FR9BZlgIYM9fidyL3J2PbxJBREO4owEiYyl5n//aYulIlUCh+/XmJ+
V1+7/WVwYPxVWQjq9eRoum9W47X+wvB2QqS3ebQnuNu/EBk8toA4p9+1eAdOCdSkuX2JTDccsZPD
KyPqwvupU61ShshHmivpwYYb+N0M6g1Wzn5D9/14km7j1uRStB/Qa5ueKlmXSOasrWY9talYBsWJ
6qYITpV/y+sDXSxn6ms239W4woruzKKVWZMfDNTrMrQOWamMl4+GOFQ8dQVmSoJxbBPCPpylCyHa
GYQ0I4bZNzgPu33YJM4xDH6TcrNy4GVK2w0Su8WxkqN7KaMwJJ3rYEw77IwRWPE15AKnexiVQXk4
u1NlQDhljpNQ3rNsISZ/X0qd6bZqKsgYrSyZ2KXRf9mux5mLPmgd/lCIXSkSDVrhLL5Ap+hTATLn
rI9ZgF4839KiUjjMc1al+692SL/8G1u7cdVJYe1kSY4buO5juruqecokEB00uMMWSonMKuKJ2IvO
80t5bbHyIgzElwpa+B59UV/daR4nj9ZD+2DBJEt1Ud+7mmncLUDdDviUBdY+j/uEhcq5rnYbgX/n
VysV0X0q09sQJVV6L8xBNLWCDc9+2lgLiM+Pq5bLaGFFebIM0XAviRl0+uvr5SIL6ptTfxveC8J4
F6blMsyCTBpT4hSwueSS+dxpAdYevuAJJRV0lrOG8pUMhH71zzQFpxJ/G+2rjlyFpac26RE+E7by
77luuXobcN+TWd6cp4OrgH479Qe2tzhXPnqLAEaGipPHqnWs72wdtq5XmDoTJBr8LxwbQE7AljAp
BbXeWT9voJvcgL5v5MnKyxpjo7pQIAaHRuVXUuFNpXkrvZP0Fs25ZfGQIcKUmEniTavB0lUSbE41
UB6iko7j2BgqStE3HxH8oHz00/Se1VC92dVD/M/ZVREsSYhKpGMhkL0zQAnaVVETS0lgI1r1reuk
fPjJ6f/dmzBRxlKxI1zt2s7iOUt/11wUGnqEBB0YfFeCxAvBiWGDJrADDYIJ8daQP9AJn0DIQq5Q
u9FkUdez/3s58bDxlMctECTggXTxVMsRykbeZUWu18C4FWy3QbKyo+kaaS8hXY3uDwxcZ6IODlnJ
VLJdHwC1TA4ig99Z/WSuacmYwLZmQQHAxrGNoF4L4Qleg1CUeVhR3JJUcC6ziDQ4+ZNe6guxVn/4
rWCRQrdiLL9AFwZ3siXGfNu7MGdlhAvR8xbVm6ANN/QHqYh/Ab7UDXTYnuLgtHs/PwUK3JHe3vay
fGDpbGvnp9jpRdTXnj3sUorYFoBPSo5kuP8VcxgF2QCpzNmmgggkGyxaZACYhtLew6YxCszu7FTM
l17hYEDkXEVW61gu3Ccrqs1Jy/wdbj9B0oiPElETbaamN0+XgzfoipmgoKMgPqRNYgc5IKwB0rTt
jOV0GUoWSf0AvaSKPrepJKJldGTUDz6vXE/2V8vBrVZsjjRwV9hDIhpgpWnIkGj3Xt3APAes1yGT
vzgSmiHUmSABQqZAgR/B26x2KjlGvNmSY6js+Ns2lgT+EwEkh8ZfdnUu1aL30eh1ZBK5jC8lG7Gw
giDfN7akjSigoYJYrUWEDq3ardmYEzOCxy9jarAGrmmS4u50itOsKjGObBNtfCERbYcX7c8Ne+Yv
4TSbrW7H/t9dCXsf3tfXY/Dc2cZaxPlXjyyE5dxtMeDAsT7o/i7N1O9gqx+NY11mt3EfJRwHkHix
nwCfIe1eUg7Bn5hMjBBSW+Z9XMfKvuR21CzqcLgWJEz0qPDnYJuE+tYvp6MeLq3DFQjsR7tPt3E/
4G7whYmHuzBEtj/fduLQciavpCmM8nk05rgIeqHwPbr6aIbpcDfp6PrKTDUfnNufRn481eyzOkwQ
4YhVRiO35JYQKNwKBXbhHTt/kBYorYTIZfe7iluyVEQrXcBINBZT6hkihfMhFGCINj7kThno94Tz
TPgdLOp74pTvhwHMDNAM8cmove0lJsZC3KXU53Kavtt9KWHV8tx7w3eroJSeLjeWAb+XtSgSwS9w
cKDckXw0veltcJecNiTK/pzS+H1vUsXd4onE72cK1E+OjZBQZdNF7t4HxB+zanJRnYC+zY7gML7C
hlgjnML8ypIIyx/tdJLpgQQsG9tN+DEX3U1EqTNua3bkCH4oj3w3inSYsF8FjWIWiDZI/ce1WyYf
KIPfq1kb+12RNo3IVatNlahgQqYHVkYaYj9S1lnRkH4S09mHtb8zRsUpOJ/0GgVErqzAStntI8Qm
RkmoKgWmh7WyGOKBV4LU7yt4EdklWIGunIiLmRzSJvLNUHiUqusJc9/gZqFSVc1+aXYLP/MIAXjY
r2UZp+jfQ34N/wh0qqtc7q6modyuf4jUabyxtaRjCSLY9RxZMRjsHBTeQ89zhU8fXASmx1vSYfQc
SjnSHj25pBlsW39aWkZjMK19KWeFo4pG767QImWtFfwRH3Du12QacqtQ+sP4twC9KxJBs3xBj0Mj
zT3Yb/swDkz/Yl8kFBENnZlK9k9jboCGFfULpBlvQhGEEy9RNQmm/+rRn4mt+OTcj/a8B6osCIar
TkUHCilkLURepe2Plj5dksNNKxmPAhmU64K5UAAQb/LmJCeOAjEGB8kTbrSv6qP8xkXK93SYUdEV
D7dd3ixfBZYS3vQr1r+OHOvYFIBnPaiJ5Wody8MShNT1tbJAPjLBvfsypL4XIyupxXqy1wZki31W
b5e0/WkXmlf1rcV+EzzsKJNM6s6dQJmDfByY5Q+MGqHFi5nyf2nd2tY8DjCSt602Q3OYRY2XBRuX
kk7jW/v3Z4ekhWApIwiR/Yqp3aMn3NVwreoBeV/m+HnK5mQSSglIaNv/LHmJeUEPcL39OJzCKroB
hbz0hMF20IGOj7+2+lCFqkYaKdwufSvWs69zj5NXixJ9WY1DXGxq0XWlY0Fx3pNPmvR9KQLZ+nUI
1anKRaLVyvqfBvjn0FQOqWrtvkeSauPMZXZvdf9kTynNx8ISVgB1+/rpO1pW3ltbXvw5xoTNMVki
1mMiXQ3/t2jmTSPr7yj1Z/dR3D8Z1qRfJvcTQlklUb4HIq7DjL8rj4iEzC0tQqr0UisD/4T7mtaY
48a2igZtbXr73aycLj4RyL5hmGZllYRDRBar+u4jELoqfoNHI0itmu4eA6Av0N38uprBXp5WKZxL
kR07wPvWI/CL2/i8xqOfhmc699gyvqxBhi7FR0S2FhXtZCVeGbdsBQpv6pRNwofkxRFudU5OSw6r
cRwdrEmDxETkSx2/acicOMAEbTBod+jYgFeYGATIIwuiRJpaEKC5KiSJqTcnpQSp9qhWnlC1rsV4
jiZazmiHEW8YAEKCPni90kMNykjUsSqdY8zZfPHi4A4kXkx2NKunnGXGd9z9tlXySNiNzKVjW812
3zvw3jfFqUxntAt7OhdW8AtVd957Gf5AfRkfkqriRzBAvKI9CFTgal/DO4BfHC5jxLHxwft+YS6r
w+HMkmLxj7gdw4YFfPyxsHEnfHJZF3HxBaWqKRy93pbaZqmz2ZYYud4HsZ+1PtgOHO7TNE/iOjnH
MEKeYkvXB/zQHU473O2ijow5KPsCGKCbusyk9vNUn9WGzpm2/wcRKIBHyi2ny/++3mydAfI0VEgw
6OM16YtDWHar0GLctwIab8roSvZn+pj172T1ExOHuvNk0JkrNdblqrEJR0KHJrbb8xUzFgnAjF97
0IfjQscYaw5xaa7ykSXdDvOUyTyuf7OUv3mBi0oORJke1a+/qLTjH+tw+fziT578lpTpfy8JAjx8
JIkPP0aABRokDxrMzrQfX6i0MNxDWZ/vCM6hTj3OtfFzLEEqLUuy/MRHgg1ThW0r53w6WFtAMaI1
itQoTplHqPhJY5HWcb0VSr+HcrBBOwJgMm9yTsOqF3D73PIk3atnbvgYEsldK9cNVHqd68nOCJPk
kfcJV5P92CaHS1gzWcHc/zkbPMQORkWPz0N8/RxFVPcgNm+aRIDmTg9Dcigneuj/F08slDr+aqHr
EfPEgeFx/J/qIh/F7wvjAaELSraxZqXDByU98rT1vr7p5QHUpSyqoylnLsRRdWOep1E0r7xP0KFk
gS23RxbPqpAI82Y36VVmXBuKDDDCoMdZxryXAon5hq0kIep4yY2BhCd4GWsXb443qVN3cL56UalO
fDxHc3AOqqUMNctj5uNwutTEi/D018ael3lcaf0eCOycQCXO3d2Gh6xahxnQiB5LqwwznjHlwPLF
bSDaxQFAN/HpxpcrR3fw1OBOfNeNcUW9jWGpEphUu4peGLn48CqEIvmLIHeGlfnV2dZTlnenim/K
qgMvNpknrh2Y6N4zUTP+oX+MaBSKfKcDyNkI7QQCgIdfJtjL2L9RL3iZ3hlRy/grIgISq3WgVAiS
eLcKWPz5D0XjXqJhYuqKZakbnZajDYBcWq/KJ9Le0PzNEn5ipmt+2G2Uv2ZT9hMmhB8idiPV0sMh
/+eO6fRpg0LJMkKMeTo/3bo+z6IpFfMnGyMHpTGXICHECkThlVJ+Oswc4LtthM2CwMH+H8wopNF9
lOxGCA4hvlhEVoHjku6T71CUZjOfLWlI4p5UMdXWQEp+6uWNTEKwdCT5Q7FGhZBedijc2cmAsdwg
Jh2vBF7Gd1uFWdu3DlmKnnpN4zEC3O9DQffjk21uDu3Wo9UxngKktcVfsxv+nhRp8+B0A/Ze4vca
MNcq6BxQ5jMiMjFAlluxIREGIhB+i0iyfY2EZrD7JERnikq5acTRDOQ/WNoRDjVliFM0DeNMvxrW
jqLzWbaCfXjgJb1FsP89gxKK8aHDq4UHr87+4bpXp82mQ8LuNqF+DVe2IFJPAoGQ/hNgw8RR3Gon
KxW4EGK/L7nEoAF8uoGEFpstCjR8Am9swe28T0gjJFUJ3g/o2EgxcsT7ZwmwNLb/gLWTaSKzAbIf
NmTqRlrJ/veVuGJpDqmsaKQOYPVuuiJkCp7vx+h56sSOAA8XaVsk8mRUEVKP/T59B+bPZEx7ghTT
gNQ3oR1iAQCkYHf8iB2HnGayRaJW4i5QoPmEE++rYpWSZAAyn4bOK4TJqHWgAXxOKNny6i0UCXhv
meGfuuvpTkfrqPnA253Vb+YzFqOrrRDE/WK1PYR9cnFBNMmzeUXkY0WGeeJp39LV8MoT7KJnHB4M
xonc1hHPAscFvxVK5kWsOOzockAySlxsoceduQdq93+WT7nkgreuca0DI7txqlIIi2Zw4uDCCgdq
7gryIpdw3Ik99N6y0VDZ6Y/OnJXB/h0acH7Wz3CaRWfyMZHfWeVXorHf5rXlW0SrNsfOaBdH+a9D
hjf1cUOAN6T52el8/EyuQhYUDq35OfWSCW2yxNjOBj0S0mPz9Pen2yhn+ZscG7W/Ekg2jm6naq4H
jyoSwl8Jv4Qps8evINKSU2ED2jFd6OxiW6ZCc2SqrKqL4qDjgg9a+aEH8f9DnVQl9MKtj41vR059
ODqUe9zPsF0zNq0r/c5Sk/m61NXA01zITcpExzncWXqPBQ2CfZTvV6E724Oju98CC8+iRvyOjndV
I5DETNJJDA3jjQuiUn0CiOGAcgGO4YN7Y5KLD7Zj4ucZn7CXxanESDI+p1XPfvi+uZFk7WOzG5pa
pGI6AJLW+eFPcO6hMdLXXtKcc+1yPDpieTE2HSpfxU3dUh5C3sxFYlKtOs+KhavXSxWr3HlwKVt4
H7DtyiEtot9fCRO4x9hpR0x8QLwwy6Ds06IdZyh4HqS5amLMGQ5O1vVK7YpIN3hB9e1KNkmMvQe1
qVlKvt2zWPOpsil/VkBlr7RIPaiewNaJM3yjwxnE97xxGbucS+20XTIdvL+DdZUOeFirGMTLWo8o
hjO8eHzHYznd1aDmswORu7BykujEnfejWtZeyi7hcd6dik5tI0GN0Tb+/GKle6Mq5wdehTSGXItt
5O80P/x+K2dWCBqv1M98rUqISYqF+M1Jz5UetTpyEZ+yFMlD4sVRyoCBj59ENQoA5vf22OeTAGe5
VZEre9UoEypUZUu4MwtvQWb2rdsXnxZg5yTEMhqnN2FQ1mfEXXIbAlo45zK4C82R1HF12lLhyZ/E
H364vioMueOvm/fAHGZ/xipeUchTqdVQJbpoiCj5NnepZFb5RfoBccyI0dHO6gKZmEmLFzNpkSuN
nJKIqc8JIlSfl596zR4CBjYsgQvs7dtD31ESslNeOh4Ez5Pn0BQjFPTUstBVKoR6QxJNoxd6Nsz2
vg0LCu2RFRSQQ+2+eUtJ7fEY1kPFOLO5xUoCVdtKvM1KemladfXRsntuymjXg5OpzmX9BaW0I+iY
IArqjrtpx5d/YNVnb2Rw1HNCGD72uqGYY9dtNtECqb/B44QbTjNIsCcvJ4gwttF6XOHb0Xkxb68J
eVhRqS5oQGmYzETUcp19rdPa90ON9lrygiU/hEEdLncSGzXJV5o2EnDwEjSWs0IQDOfs6JrPJ75L
6xXzXm5ifIn2ket7u5QfQIVvA509CKIoM9KqULQlhEvLuZRES7d+3dF734XDVj98A7qHtYUngxfF
pqBxkte8DnJn5MFW5t9qbJmxANiuC/btDNhSNv5CG5SuffOes6wbXMP7Fzx6lxBXWzLoWne2G/+4
MHcZnxQ2hicvxMWluo0qiM6NoCdDOcoecOowxJQ6oegM6vLlrUwFt6QHXzp3ozGooc3a/ogw/wyo
cx6lXI3VpJWy+viRyxnVUB/234WeH3OneulGoHMyar2ieI4CZs5cWu/FOrHuQqXJ+EXfTirt5eYf
L2Fmpx4OW5KM5GPwq5Af4H5s1gQCigELBTxGTBYNg16WQIFhClrEQ3NbBWRGH7GKU36wRzyOSHCP
2MvXBEjIA5aOemWeEZjvpfI2tjDePCYreruqRb+RlIJ4exsQgCUgQFg75GbZFjcBtccxXenJiczQ
8KeIdewd+m5yOCz8MWBkLHc4pN8Kwxo1hWVIDLxervlcHzBUIumMzYPScmSFQUJDYHuecgSAeIMY
5kKPo4enNnZxPGM3hQ5ZrMtnlE2Qr1nRrkjwhd/5vfa1e7hiMtTcqUn2sbNVnItH/EyW9rNmLvPJ
TV1Z5DdUpU1REdchMPUwMOnokvQDG2KfZ9RM3xRAywhNricbtdzn9ZBFSpq2SN/auWF5f579qe9D
zNYt3x4hM2aCahfO3xl4feg3wceIZrHAdC+yCp1KPwhA+5U8subBV1SjPlBjX7mGsESZE8RQG34C
e/mm8jzWWYv5jBp7qgkIwzMycZt4gvT7X7G/gBHSnK5FORov6YGcMf4/bYKzXNfwg1u8/q661V2T
eVzZ7Ux//PKKmshyr4IyCYOKZPDXMajaJOfsBQX1XIT7cjB2QfVBfefCHT3psqQ43rasSCPd83HW
pXNVsa/EF83r4muJowZMeqhGNnNpkK1ZeYfk1QoPCKKz3gBlb5GPVvlHLtnZj4O+DVBb6lG0sd8d
8AkbGShMW05NaKjK/LufEr/9rjdYiWKwe0wXMe2Dj2Uv+9mXE1DqCezTGKo/R4O4SxVnFVaoSDKH
zODt7YeyGmRzln67ZlUR7UwtFskAACNQQ/H3cOJ4QWAYGzKn20aLHCQtEZiMocCOR/o7FEo8DNYE
UZZftcD3DulthbT1BTkIY8H07YYH8qL0+3wVVapzZGT08Buqv4kDYJ150a1usIHGSsi7TG3eBZNx
D8B/vQTHYfhiO32AF5cRLVmmTeouA8Hp/pT14CvK+LRlUKpkF6gFvhTtACEmbiIWaD+S07daoajL
XafhShRt2PbpzV6qTaKdwNIQRcA6m5tkCq8O7FlnKZkQ10Iwduc47IoZ5OJI5BNvO5TsZj9xyCyh
RCPXCksZVHKfLZTFzaPoVaWk8e6j+pCHdvX8gzjW9jXd2HogJEaK18N4dgCmhQ3hZR74ENxBesCC
reqfdi6jT2apM5BtqXpqhYYP2IjmIo7HbfIt6qomZxftfqzGGCs7OTVC0dt8RJ7hbJaWaWgG9q0w
oA03MKShL0KTaluJ2XnrJ4Y9cFrtBe/IL9FAmzh9rCbCBH6ZumzMbQx4uQjYaTOKAUYKx9h30iyu
NRNFAFvVWvoyjm1UJaonO9oJQc7SkNKBxftYLeO3bIc46WJXfZZqB6QGl1nV9Wkun73ZTCtABF+Z
MSwKZsafaFB0JqwikBSQEh6jiWHGFbl2GN8KUW2VlNRMQCmgbCvBV1lFDGiPHjN5phW3zmwNBvlT
ZkPtKDtIF5VtrHOvP8v2Qp6hlQAG6dnrROKIPWbpZtoQlVvJn878SLudxsfFftbWnzf7ZrSqjjFx
pIyoZIKKqsBUmcvT9t6P4UzEoqd3gJQ/8hyMkY4GCh7WBqbwRiVvD691ji06tvetso+R/6Qo+y7Y
NR7vVOywovPk5VQn4KVqSQCEka9sobC2pk6SPpYHgFz39ZazW8Aff6quVd5bhHtfe/sd7BCENi8B
mS2Rwemus0Ao45bx/l091RskXtddKKl01kU73axHCNeGh7cM1Vwqh991dbfmGvAkct2dlk7euIyH
CGvwXPoKQEa6JCDjbEh9BhpmNwQ2znYNV88LHcfgvgIN8Skha7X9sh3rWEzVRtCnAiC0LLf+CAxh
Rb1We7RVLjfkHD0kfhNfaKI9TxCzs2r26hKLrHF0KZAoki71v4349sj3P2PpI/l9phQwUxBQ7356
4WTxc+amdvDtun2tQdDnMXIUg/uuZF+L5YKahhZxq2e+4RBcbR7I5/xGWXRPBI+KA0mFrviKZXu5
xg/H7zLICYwo11esK8NbmgWmrtwjgdQLI35ejI4IqRn8HPjuIHZvuqz6lRgCGHXQudD11pD26kng
g9sZ/KJN+ddqrFUbLdR37GkmwjwaZYSgAqPCZj34I9V0tNL2i/SoHhyLHNpc30bVsmhNiQvC/a74
HellC39Odd9VIYipw7OiHwdImI6B8+BTsTrjJpSIv8cRDMlRsw4NgBIvVda6Mn3tscQBMfJPAUIk
X/toZ6j9xp8zcZY3R0edmE8XlqOxAJFTQPe/O/BT1uIQbB+5VyWRen+OE7v9pnhuMHpV/4FCz3Ak
Vykl4kgCeDosiFOTaDW6q1BybnrlXedoqcXzj7QMXMfOyDpHxPr/Sw7TqCPKBUrZ77zHQ+iCzW43
rxT2OjcsPNS6mO2YaQBgM3ybrpQbc9EyKofkZclcP0Tz2Kukn1jtvrXofTaVGj+2XY2FJXrkIZsO
dSR8KeZaMDqe2x0VWDXyK2gnaKiIR67FjnuPI5uVs4gwXI+tMWcP8lb6dQualeaRiIy/qwrJgfdg
AjTfsi3iUPky/zzmVTAWNN5ACJrQERTaKN792MXsP9KqFBzcUnvCgktq7iqfDggTssqggh9Yl87D
mVCmIeFvFNuL8/Jv6VA2mN2MQAB/SCqrVjkF7Jw1MaP9GhPFq0pb8j+4FwWj6McWnO0Qjxij0JV9
V1mJabRGjjt3UbsstrsFXXzMGbD0432iOvQ/bDmJM51fKuVS9oq4rQFIU3SwZRqTn46U+jJWEFxp
X5pe65DXHCIJRqnG8FkX+ziyhMtSvJJmi3EHHqDwjyehreOiWsYESHiW8J+jUDoqWTdLTkUGB0It
TJWR5TEZSjjFO5NNwVP3Aiwx93ZWR8rXHT9QPdAcmDSWuyE5ji1zpTHpc5tlwBrZmSJKglkj7Lc5
FKvs2WUQcNHAcWmd3+Ty7XlAfGDsjBs9AExslTDV30FguW1gwJblJONzf689pTm2W5gq6wNxHrtI
ZKC9QE5ZGYc+DV0ay4qTYNnG1CGutInB8s9VFNGE26+OGjs3TnK4V3o3pmlQTwJvsLRxYPwwQVVc
wLToo/M1mK4T3uj9l2cS0nm5vsU6sEGxQcr8hSFBfSwdnFsSDE0ozrd7cr695DziMFRuxYsQU5xu
NNBpBDnungPczT9gEvzIn/nsUCw97xXCsQ/Rwt7sfkI2eos5JAhOgRCmAfzG7IuV4+RCX8vF6y8B
/SgyjcoAzUvZoa8ywC9SSPywQdZgtBn6e2Mj9jsWIudM/witzj0Ce9PKH4EH+7QvXQQKYmyb1URz
gTIwpLLUTvuBNFRTRs9dgbVIwGrYobFjPegwDaGEJFfW4q7ZE2sPFXmhtS1zwogR8+AFIpuAfHJx
3+UQRTqpDcnpigk+V9+AOJdpV8EfFhLku20LQQNYzSNOEZRkj2pRnziI80Lz85g790MFI04rM7Zu
0QgslfcBQY/18JFhy77Gx5kQI5l1VV76ixeFjXvFhQxsQ+5TThItegxFwIdA7N/ehi/4CRMyNuLJ
ujxCBAcd+BMT739hi64Q1WzTCF+MGdQxxsoNdZIpsA6vep33n623TnTjdyLhVeSxuE4O3vTE8Y0i
DY+i4ecWMoCYxMGhlHdIMuRg8cSU0Hx6N4NTPfINEX6+TmDgBXMYox5IQXt8UhSe5KvzrIVbAyob
EtmzQsvta8JNucCWiHZc0Gbv4QWoC9/kcKAG9AS4i22RXvDoVa7NkPNOsnN8FSgXxuSfFyEZC3+B
JKEJ/hZc/5doqlaZtwpGdQjb4nsE5hVls33NRX/mPpAYVhKAj/duIoFzIXhwySzWCijo/GimmO0r
uLhIyNqdctcZpk8sPaqOW+hByU+fnDUdLJ1Kg3y3jLFYvPEkd/3Ty5NuoeOvs2wNR5b1vF9y1OrO
97LQcSTEiEsKiIMiZZipMxr6/wLTrnBrrLqYcxIErTUcHLDEi7V4vAZkFundGKhU4nY2c4ufcSym
gWBEiuN2PyJQ8N0f+9jZXXjQCg8e1GWK+TRdmFBo+xJwR3Wq5gTyDlUdTIPzI3IyT/ZqbrenjAch
ifVTHkq8Cq0Z9TsnGWIId6KlMNn+IKdpDcfIECbWP9uOeKUS0ooJEDK89OrPnGyEXrWwScn2BJ5V
uNPiEhOt/1wzcM/qF9RLm044dJzK9yF2jTXSVDdtNkNo3T0a//RgiQu64kTbAM5z7dBg1Lsvzi+T
IJuW4UBymj7muhL061DoW1gyfEPSayxP9qbuwf40uY+9I4JQbMGKh9oA04QnTybQKDbnW2KwEy18
bu213PP1E4tHE4Uc6IQ/El+OPgztNsORqzk19a4RUQnqIhKpkqc244ThaJ7ku1KXRMUqVYKrNdFE
X2eue/XZcqG8VLq67tNjFG+r4P2ZiNXUBllgBHRQItTs0TLOO8SqdYxzL7daWSMwLKWilawF79b3
yo8QSO7ukdYVxhNeS15aBveP2/h7t/9RJRAuDEyzD1A7zYxw86w2dcEiUBwSldIGBZ6KNPnbAMtK
6SpS1f7LuP06ld62zyNLH0hVLGjZ7EYOu9smUQf14rc0nIl0mVNNuS9VihL8X/KYaSC0G/6UlxaU
pWGBkkerQlwlO0oqmXkUrP5bLdzjF4Oz4frY9bUEfHFLG9bNlDSTdykIr60hDuVvyI+MguC75dko
TTaaIeWVtAcZoaHPBS3FjboPRSLpvDuSkwlezf87WzzsltbZS3k9JWYJmvskZWYp8TRwknEUTsC8
lcckS5NyyTSNX2x6/4m9zBcNdI9ULFdqNo09cwxtLFLuQB35a0flOXjjfeNsBcs9uCN3JABfOXXF
y/YK/HyVNpnmvrF+HfKdYikhqRzZYYZzJHPQYnkDrHag2k9EoSxCY9mDNLU+XX4cx1t+16vm1P/D
D1Grnoz5wM1SRosECvBRlZXnBwR7kYy8G/ZWJLbBsrLyJ7F2D63wwiNuazvoOWFwedX8Uo223Te8
s7euWHlzsrnYz9e0Xuxv05rnJuadg4aEm0ct3jb15qcsNzl612uxeEYDh1ecTGxsNj9SXz1U7q+i
455ilV7owrlkyw2H4+xymraoi0SUzZAtVksq8lNr5CyX4/VjkQ3idhKVLh6hwnvSDgn4Y/9+FEQn
yTB7lZTKf5lOtyThZpWHP0YMygzTygW9L55PPWxzaDbR3P1etlbWPsND6SzSeC5iZZ3+1BLG/NXW
1DrVZch9dxIFjmvshiVB8XGzAXmtySaKNmjAU+nr120v7L7L1U9snWJqIOwYIIYwx4TZlyNHHky/
iORXS+ZtJoSdJON4lQUm7l1vdtF7gbG7Fl5XrAIFFSEw9F9nyfZhqSYQYy8mGDCrBdx3izqxPUxZ
RoNzX1xC4bF3C8yWSAcp2wYx3e6Nxm5LWeSTBUx/mBt0lKumB7M3qk4FjIa0EKz3sT86aQkLTB6d
yv++Cj4Y6uCsiyhvX7Ta+rPzQ6SCTWcx3loNPfQA6h4dSYVCKc1V8Z1hM5T95RcgLzjJoZnlrk8W
dr+bUE7MzaI2vAWDEsCBiFlf7nOgeU8U4Wjwt/dl1MkBtM+IZ7rm6QaCHYd0hq16nIpIeM/0pGVs
3T+iiBqtsvwu5wKrCFASM9y6JTSO2s8s2K7KlYiphgxu/6ud6wgP7Z4/Lc+wuUdg84QV0U7gtdz5
6AVGF5muZvwgwW29kpjNftn4v+DnDtOYqwfA1CsQv+z+CqW67if87tqFL12XAob1FKBjnvV0Raj1
No3ds9+lZ6DXLzIPevvW5ozzWo10eYF7mejXyy1qY6mR4wYO/rfflcOSNfQ/v7jRO3SYrkAQaRpS
o9Tq2mnO8pjaGC2PywRJPBsN5GVBFr0kS9ucqzEuLbpX8b4IL0GroHbo7nLPg5HXu+5r9RvPAzXl
bWHzw8qEXUgV0IDSmrso0FJrXUUPpIK/uULgKLh//1UfXv8Ubr40SkftFU/9Ys1WVkme/kM0539J
8H8aHxe/XBrRtrP7RnUi6TZgyhVkSszTZJabJ4HAMCioA3WTMjC/gL/CcyjY8hOhUMYmvgx0ao4l
uOufjFiQChDFCffDxLhHfbQFORBeUSFTXQwV7KYTIr0C7cz06TFpTzDXHaflOIYoL4fmprVU80M7
06lvhYkUidVovf76X9MViI7FZa8W+DoKbbCEpNlG6O9dV3JM35ucZoFaDtwOYrvNHfzmewU99P3B
xdsxZInk6Fk4QesYRuYlDThLef2lWPQhrU1yI/NYGUlmXBfGUfryGE0x5Hz7Yu7k3ZrAaGaOSo66
ODJbxm8IrQwhVijxIuWF+FQSju7P7WeARwDAxAaBY/miAmlxSztexlyhpR4dJleQfIuIEcyqqrCE
AfDXAYAnIKEFztci6nqgmqoUr9fbx4UzulMG2oI41oDhuVn711gP1WdmuF8I8BlgQO/huTrrJ9ef
nsrcIlyo//SGRris1QGKtyQJba4ahi5+aFQXGL28y3MZjeylSJ+mLWM3QTxHmXEKuYpij4GdI2z7
vZbKipgSELdAox1jqF6bjk3Y2/e0J1yVyILRQK8mzKwcvNpRGcTMfbSptuLo7qI+Nob9DXMdjM7v
4GWl8hqFnintagxgNYh1+iCeMKruVwUwJr+hWCAvuVHnTjeLwVp91GI3zJrLmNST7xmBBXjlDD4s
wxK+qfio6sohtuewR9vReDovk1y7eeNuFWSA5EQWumkdILBhg0VwElxguFDBH5Atonb42dDLsEt7
rajoaNnfg6WVv1pyxEnRIkUu6jJEE5QPuvJFnxQrkHya1ukFLqpZyGBfLSoi22e5274ldOanmz0J
olvRQOcdCvDMscSI5BvwmZoY8e060wA+40JlgnHPmqzeZ3WQPMWmSbNp8kglQnl5rWmu8+vT/guw
sZa7nx4X3WoqZyfli4bIk0nOMWY6at50Xh7OlDjpo3bI3JZ/Ro57hLK5aqmBtGzmqwLQOlPUzd/g
o4h5WelVck5SJa680zd2clsP4gcYTzvw6pDLFdv2US0ZRHXWvpQ7fH4kPoRwXJ7pDzphD4Zl1mnB
TNVmql+WCNsQKjw7sKUItf9aVmddU1XC+y4khdRQUcY1fxzLYzul+oDHhwySL2pOWkGT/u8EPJUO
Xyj7NfEvTomlAPwwM5GURKUty2Ca5l+q/R4UXpwaOVozqWurlFd+tFvs3vFiwslbIRKZ0oI4ivlb
Qr1JccuqXOxub6YnQn1sTW6P5scqzO+J1MY+QSIFNTBl1RPZFLEwWcrcXpKgaOtN3ehK+WjbK4V7
AwmoW+1YF16EO4U/sk3svWiUFCyE9UXTvN/VZDzdlVqai6IR1S9bNsBLfeTW39GLHGUyTS68cY0X
cTAFl2S4I46lNfCi1CYVbrfF16d63AFmTwqBIU3CQktlxIYeeB3Zv6W1Y+DIe2Xb4EpBoR9Bqa8c
pgnt0jupWh3mzbaAO/nZ2VbuSbGdqhiVCDJNCWSeONBgvapXb7jno7ymUlt3DkkV5hYWXfGbKVlP
+5E96vZGMFEempgziR/ItI+7TC8Wp3iKCe90TuuMGkfhpel3mxdtoaE+/zX/EIcG14nax+c6uaX6
88B7ebHV8xHWYq1atRDvB7f7RZ8O9699L4EgyONuROFnSbKUp5+E+zlxDngjruCnmJaYQbdGpCVC
I04W+NQ6xTdxShiLm12+sKTZ9LZYeXfIE4YlWmUQmMXLBB3bljUoKUXM7qb2ivJHpnB/uV/AAGXt
FQ7LH7IpGUpl5c+ew72mwlfbXsMlLN7YsFEJNRE9yZgat8EHc/DW7EOrEmLvxRC9Jlp8ekEWpyYv
srx1xzqsXtRwYd6lKy8nQp4Tj5yGle93b+1o9dypAcXxpi8j2KW7ybBIUGVzLuw0jy7alzrab1/Q
22D/90vKjgv0dicbKiM4w+WnMsdvuXcfoWgn7nMu9Ay7RQbNgMiRPHgGBpR5K2vw6GxLi1yrMZog
kfl1DE/1em6WpXHYK0af8zZoD+fjQuv+ebiGeu24iAXQvfkc/bpWGjzoEpQLVqfxGCI7fHZLTv1E
29DbNgAC/LRRtzHJ1mg5/TbMiBuhRu2fNPMyrtHGktRmK4zRAKP41gEuQIHuKfHyIGmRmG3P/sm7
F69Mimfii54vNixrai/p1/qFI6rnMQv4XRp9ns7oznqOzEYyaYtCagQ1vFUzgjU5OdeGVQU9c406
S/wxoAuBuKwF6BIbALzYwWkuXCkxGBwdbfMsgL/q/DOhONSkx5g5GRjKMxrsZlljAPPD39WscUOm
7iqR72uIgutFmuP3KqVW3Qp6dwcAetlPt3meG9kLiO0O4oFu/5/inrn+CwElDHOJJ0QqaK8q2GSP
EQG9VAMEdj1JA16HGWttJkaRTwM7CIw5wvTtmhK5oJsZ/Z0W0+PnN+dDGrkyxeB5BL568qv9TMhe
L07y8kN0EJ7TQnAr24mM4qCAuERXZrq7U9pzaI8U1tVIvhCvlz2miFT94jV4pajtJmQmeFh8KyKY
cGZSnrCns8MpWZNb1JslOwtCReQkxBe3h3gOrYJFcT6zCOZYHjLZA5ANJ9wGseFdGcTBcvUOXoaa
f5BLhnrs2VAUqUQLjrhsUvziMrI/ycJRlsHIPiXA9YAgj9YJkelW2RsSVaPn7WWkROVLL4klaP3D
dzSmMs1wX57djq7NZuCtVEIYrO6KvGNQE7d3rCpHRgrwmlU/F76fOkBWnOmE4ViJcglNOBBfxueZ
phSGNsJSzfWLVk92LRDJmJ1a8umvImFMtB/729JgaMq7bM+J0GASfEq+4ZPcj3kQJvBY6gzp7KeV
cFYgiODIKCvsMJNmLseMpKWwkKAeXqTgWT1Jvow0aqZ4s7Jh0dRKtViueZR5c69MlgimL/uTb055
ZYPHeOZIe9hDZAsyHAte1Eeyo+saYdgW0jXZmLgSHKEZMVlixVAo8HyKV+rGsEzGTsB/VsSudAit
xztwX21juTkEDwaMoEfK9EaXAgpFyUpp02mb6aCXYXhXD05EUQrXKill2ok3AoVo8MS+b4IWaFoW
KytKjQ8I0sazlTXQ6j7qyhGrMG/JUsw2LC5iP6L465WHnD1voUq2m2ULYEFaPYtsFN3JcjSbyjG6
jPLz2G6pXCTleM7B16ErOsDYF4zmzTRMA09dNbdesg9+y2r1/oh8Yx88KcwaHdpSqxWeeHlkjr5t
iy+tGAhaE/tUCP4sU6bnm+DoRArIkMnzrFR5c9MvWGlMdIlS/6iwgIl2wE1qmqOk3U4+oV2t931y
kDcmHddtsVh8S+T8i1mOcHNHOG1lDx/60ppVawlcs8TEN4rRYZpL3mSiN9+D5e7dVTsuzEB0BKgn
IzdjtnRKB7egeL5qEic6p6sWXBIQ/v3ffu60SSU9ZyBM8rWX7obkUP0OA8Z9SKJSz1YEZPyc6iT2
M+H1DD009U8J7Ym7lMXnIoeRvp63auEGjCqjo1fxZriTM9JgPDVDjgxUvYFhZlMAeQhU/jXGXxGM
tDGYgjOxfvBC23yl1zDKO2yl1YXA54T5T2gFKosLLZ9BM6k1LQk5GmoDl/jksDa21YLpgFpvsgxB
4ArGZeFkTADILvAd44qRgxJqJfv9+WnKE9ZRDE81jfZ6pfQTeKVZbdNKb0PeWBMt1SHlppR7XAqT
hP6oJO9qZ/EJDjQt5PXPSJDXE1IRD90PJBHy4fXrivEA9m2U+m3+pTTioixrohM/conzf0yETv/P
4lwlReh9Gxofe2ZhiJIADi+978kcIuB2dHOJpGGF3xQaoKR54eMbklA4bV9VTdCptMj6I+Gi5kAQ
O5l1Ht813lhJDheE2GgiYDY5/aLE0s1vBHZ5r3bnJILijgQLZvDmEIcDTmHG77KJ+moyUQuW8rq9
GdorMxuDXkDv4F9aXCms9jBaLkRlApy9Xkj/pqo11Cr/clu8zkxYFddecv3OuVeQUjiegXSmDUlJ
LvQrTyg3k3YEpwdouALLhYLnDnexiabSs5/a7q/sid3TSk32+WjDslQegr7HUb7Z84Qpxo4dH6bm
A8ATKrlDDCPCblv9OveGRL8qfOUFuGr9MXPVD7dEdNNbX1OcvrfT6OBNr5y+XxeI6t78jK/toTFh
N9ZN+Ha+RpwHU7jsTe8w03+y3kY3Zi6jHtOt/e7/Zu6P3mJWYsEQVRdvAzVVmbu2ixo/5mbrRxYc
qzDJ7biUhamYEt0NrG6l31i0If4r8suSoii7KSwlXobhxlsbgM2GP24UxBa2diX3ZMIE5KgQ0UvJ
RpstdDbYweCe05MiDdpazFaxw+Uws2jU1e0Ay7gEGZMxOsW1ht3eJDA5e1uKNcC8OywfBVKPLPvy
N/pldC4/y3JsQAni2waqcys4gbnojWwM7+leXIuRF9Tim5PrDU4tGHX6GR3lLDGvzVGwzkSXE9xt
QDDWre3KVOf2zzVnbl3GsRkIgKHxQPcOoWvIVMGRQSp8HDNshcpYAwyNU7VsQmMllxCVc4KY1MjF
J3RcjDwdeVy8YQimOdb+yz9Ps/zU0yUqI3wHw58f7sB+HG4K92lgv5WPz838JIi1WpSnML1bNL+2
5v7o1WKKCu7+qfsjQ99nPn/3fLLkx2KUHYdrNTa756sPN+3+y5A6WpEoymzLZ92iO1QjLzsfALSa
1UbmLm1BI5lKxgh98TdA2X0lj05PazTULUbuPgoC4mahqTUMbfFUF436/ynSq4HnJQl2FDIXtzOF
zAM2CkqDXs5ZpinnuKs/EuM2ZOvhQkgLoe8JCtiS10qV2eZPtalwRKXCovSGFYwAULZcVXa0j3Rs
w8tnoKt9uBDlC1Cai0+7arLF7TUTNWz1qm7KYmrCsjwYiEDBBY8q+zFeJ87BtIgL8wLjQpnzpExv
ogRscXQmumEl/8rhh9LdAXWGYXmYxhtH4x/mcfM7BQuPWA+HhWxNFAInaGpg9evPk4ZrBa5LMmpv
uPHEYC/jYYHIPaNKQr2TcMMPqTsS3g8jWH2ONtbuwTJnAR1wa134Y7unZNVGF1YuxEwtltVPFKpB
y4WjPT+Tg4JodPsea8PU1Nf5YKKliJZJIBSRusRZFdOChtJNMcLzqlEmvvVwtNP6AF27sOIwCBse
RDNWLHo7MhsjWhccbq2c7eFIU6RzXUUIdRqoJEcMpitytLtU/yPzjDtaZKxi7X8xj5hpwAeLt+5y
leRXx4Vq3Mtnt57OhekJCZ9i6cixpmdEYTspknjCz9bi5/A09U2pbvKSWx+QWgKiEWDksPVxgJKU
A+jmc1irgYpX26cdZEhbYSS4tc/1Ex5YO7nxHpdFF12TszEgKvkzB8UlW+NXKDyPpmo90lDktD9D
rHLittoWLgLPF5VNOqlrh/s0+joCK5MTCbFuCdSOmw20vOtDUPKyQ2oJMaDRyHucvu6MkNKndusp
RRO+5wxI9kvX97uOTXAZKYq2zCg0O+HF9PDdn2eBXApvg/+8447e8c9hlD4BrMx92qQjwCjuxhwi
TXPq0R99nd0xkzMwoQEq9tHczfiGDbdaV3Dn7UCqKZhgGG2YHdm61JWkOGa+NE1MgtYPeLWIdeQW
8jnEG8OlvPfHYrVMlIy0cUV0v0jCF6v2wCPCBcHb01wgrh8xpXrAUN1Cx1CCtYBpPf0/k+AMPnND
6YHFkaWCtGS9knlqLXKT7asFbZ26v0jRVen81g5uQoblk+FMUFHuBapRydVTX5yrT/5yFxIbuhyt
9KgtLZT/WW6NVTT8AxFDsJoP22aKMna3TwyjRgkSXdtcoEdPPOJrH/uzrAC/GnphpPclRcNv7pIC
ok436m3eu2Du+VBKPv4KtRA6Rz028Pt2bqE1uqRMT6m4Dyr5guCudNixH7FV1whXYoijfZHqvDqO
ICqXsttyq10iwwiZDccq1Kwp0Y8iULa8ZbUo03kq8veSqAr+FWtxEmiJg5HzaqIZD5Sr20uYNmF0
GZGVqVM/9bCU/YTcklIFT7ny+00RNQFqERTV26oKI98azjSKBlnevBcBGu4bQTP2m17/NyLQNDQL
bEed2c2rLHx1wkpaFL3pa6WKlDH4VptufDHQUFaE8cpUPAqkoEh8Yek0VvRwm2G+jtisfSc/Fi1O
qLsupUq914gIs02P2ulOyviuS7mTpGuqsJx0H30+ZQB8GdnKwtsxzhKRLhuX338ajWSEFY1MM6qX
hfi+pKyb/Ts/3wMbYSyqt8Z7gWhExftcxsM9b9wEkg56Uwot7mNisGX9w4W6EcK8S0PbrbunpTQ0
H1dDEp+cxLjNesF7/hpxEWsEwSkJEilVAqRYg22twGyixJPmu1U8qAdvbvHYnMjR3qu2pD8VowSv
PuCPbw0YWl8y40ttfPduD40i7qvo2avgtDBS+aYvyKSTrJWATJ5/gKDtGgBI5W1pmEFcqftenx9B
QMGxsk98hcBeSlU+rL8uv/gy4QESQkcFrVa2QG2rVSc9d9pVqF6nPTbAjdEJ4vuqu4qua2kwBn8z
VwJuGhAGQY7NMh1jmn4v5D8StVm0fJkneerwmVxi/f5bnbV+xIP+AvmFo9KWntPZ1L1WewkLIqNz
ibe///nqx/LBGPUZQGq5zEAhu2sHId8qD0AUIKXo1VAeFRv7YFnT8ax7O2tC6SmgCg5ppklHhCuB
f5Yu61iQAIjIQUxIHWw9yt2fK692YI0d0vyDNxaHPv8LgcFN8AQ3uLKIJcHLfYV/83pq/+TUodaD
1P3e60bQRJnZpnOaQIcxaf6lg53sbPcPtxJCZhYSKQnuPGeolFvnNer+lMExyZECKVBSfGMEEB1y
S82E6HnTVHVMh7CrobZozva/6l/C5HlEl2psLGf2kKuDmPlf6QSmxiXyj5WLgzJnfYSN4Tspl8Xi
d7lEaalygesyGLqTqJzbuCKNRyKlyiOGGlG0EImOoR6mGZ09ijsvjsfksRqlVA3S1+tEqZJ9/RUo
Re7WJof7sBGAnTTwNjjlhy3tCBJA5i/4mQON5EVAG0i9v+CEfYyQZ6GJXsumDgPnVet3a5RdN6BI
1Dp9UaXEvRJZ1n3/M85Mpamj71Gt+lAzjrWEat7Y94TjmadQKQ0GYVHluJnWlfE2DdZzDCnryadD
onf7nlon6yF3jiI4APaqM465f/mp+Y7HEy9y3hiYNCjtxUNOJCL4fpJNc4vTlNvHjvnOyy/BpKw6
kp/66P69Wx9sK8fSDgEIIZ4v0lxRuL7eaOVbsy0XBiQjPSZaylcVFl2HdItSBr/7BmQQAQ2S7ltp
5hzXvPfIJqKhdKDJdOptEr3/Zc4RhhZDQ0l+UaT+Z1F52t78G4dVfHnvnXR/IPDj1QaSwo5WN3n8
xF8xHPt1tsJCxEs6NRAweeLbC2whynv9dtpz+NzLF1QYRonfVuoGKV1HtFoPiuNYQmLycxAWMyDl
8R0siZFeq5b8ubaVBFlZp5Mg/Qb/qtDvREE/Vph12tqh0sGU+pyZNfhwwIaqSo0R9XOjC+2cO+ve
oCI1ALnarkyKqF/vBwtSVZN9mbxeDHl9J5cX33A0TYrJ/LY5oXmUxHD8ob6Id55nI/fxT7nG4R2G
vKi9s+WWKo3BDFQcbr3MjZUV2rnfd4TCixbnYz91ZrnS/Zhtf8ZiiDH3DzfWB71qYtyatov4CUAe
r5CRB/q6bRh58NJy3gY0DTeeZ6/JxvnT/Wsb1qAGDyFYq47Z1Xcx125znkQzPRsIa5y3on8vX27C
JQmMjMXeHMYXMgfJ8WECTPaO2WSo5Rm7N6UCU846o/bYAkOo3LQaQONMDd6XzqSN+4zIFUhbrkoQ
MNLL+Shz2AIpxfftEB9ZaMOko9n7cI4/iBVw60YJ+kwXj/WBVhEviUcKZFcXI+/EarscVIeFChmC
A99MtgdKywJaBoXFlnK+jX9A6d69t712SvA9eRE1CdU6beYAmN0xABUhS7ouFppnzzV9DaZSsqJW
M6tqAjngDE4A00C7q7HTJjUqwsLP4ktaHCTyB/JU/40O1uDDTTmMxvOF4r/FgJ4ZL3abi24vFDGL
NanA6HvacSE77L3m4vKSzzxqPMO0bDoIiqVC0jDqk1yWpuzngPLwTmVnYtR5a0yz1ZgayO2MfC8B
b7Tq05EiuX+J7OzAC4ahUVjT29RjK16GfI9r7SL8KeM0RGT93TCtx+qYSjx+/P/nD7Xyyq12SyJA
kiYdHM3ICkvytVNkDmzzM3aV+i1TYt3IkgO+bf+kx8RHc+RE3XrchsuPkxyVGgPCxdmBwbhOI6j8
bhbKj1pRD9f3JS7KIddFMyVFxrBx6sBQltIENpOg+pmm7UACMhkIhYLGOq5cJKbF+FXV3x09jZWE
RAPxp3KEPR24TviYuOrpsi8fAs7BRzbqjkJJqre1JFZIg/NoRafZu8xuyhfSWgQv2skfxmJIIPwl
S7PbJcgnkJ+8psD6uFsd/nhPTv27LLZA+AfNzb/EcTvbrdAfJUyYeL+yjMtLPFyn+I1UKVsEur7J
Z2jMnqxpwhzbevQIMvAhzjbpLsoW6YFkJguuN6Z5tHCjVVXt+jst5B1RxQzXJ5NdUSwJTZxkqe8L
2N3XamCAxm2jSZUsXtLlwi5JudSJA1N641EsOsDEiKxTD/dp7QkOIomDdll1i4hBzkIF+KP1Y5Ju
La7Qfflhgf0MHGirUf2Soc56DlQKS3dMYdXEvIs5BbYS9ZyrJOAGt9db6VIPwgjDJi8rTPowxEmH
sC6d7g0FDB1xOVyWUk/KFAROB7HUUnn/XLzGb4PsTE5QC07puCyk7oZXWOQhjbXQ5ad1dyJ0GCzE
N0zOTStv2CYekiwrkjxRrdWUNR04vgrbAaOwRDlFY2zvEVZKruopVUhkM6zbA1tDm+v3NtQJwdt8
VS4PfUjpl4eL/LVRRqFHprEmM0Fplr4fbQCjc1b4EuS2Iaoyc4TbswSK8mb/oBn4Fjwbk0AJ7kX/
juvb98XiFEITbJd96YF1TerjeOA7HKKTylO/BTLdSZ+swtDoNE8KWODPxQOjw3qAQg8lwRww6mEG
yUoMcaASTAAzN3zGWiWio9FglIwal3Qs5fR5L892vosP/2kjs+CYSgyh4aebguxFy/ZF23YBQ3wd
w7VIgCAth8EUH1rDXVE1+VAzodqlSh9LOTiayD5xJiGE3Iuog1oWkB4wIAJUo2OVGjz8sBvifSzf
0+YwSYEuMtbNMFUCWd+M//5y2VkBDgB098+e72IEb0c6oIuJQI7jmpa0jYvQjPYXFDI6np9xEPjz
PNzAcRijvgusT5O/wD6FGNscRNRYQFn0LJTohaQy8la7dLAH9X0NDlytLd8LbKeojUWnDzYVoEmg
qmKZWrtdvKWXnYpCNY4aFsO6RH6RUy0CJ0+tSz3YCkQC7Lf1+s+4J5wCrW4mlVsWGQDcUU7Ygx1z
vRPQhgcagLUQhWHJbhAyASYcAw1svOrhhhbvClb4a2DVti08OtCQJ3mU+80w4X5CfENyF2klAMnc
Rpkx19af4ksAKl6CCvrrcfReYDfnOi731X1rlzGmEXYUkrdni29yEQJJzoswwSDC2pfz4UZ34+KE
6OxJxl4xF+CUU/mZ2K+RxRVSbmg9iMpIH3Fjp8iQ8coxVAOI0UrL/PmOCKK0OI/7IbX34cgSCgAT
IhVaLDdsBX0NcKSUL/Jpcut8vFw0wxcWRuNku1sz+sfOQ1Gz7sa+7ItJKZUQIhqkonqUvS4v8dNZ
TZGhNZ1ij2di64adZBE0IwxDlWc6K/+kHjvrNRkK8pZmxRz/laZqAsQTgG/pvfouEfzUNmipz+g1
ixLhSU61vg5e4evEhyYPdQ3Of0s1zhaXwJ25zSXxMNppF5Vmj6/1opTJaI8Ebpjht7IFzP86dgJ+
c7Wiaomx6ia/TDw+vpnOkseUC3b2Gd+JbTVuhNFOFZssKcvSN4bbUeFnPjwVAFEiWq3Lm5kkVGSz
xT4VfuByvx7Gh44VM4LMaxgmkanwm7oVQjaYot+AEaHkfC0VnNEn34OZ6GYOfuQ/rZqzznsuUcCm
dstcGJmJKwnczsWgfklQ7hky0Rqi2mcf/m1f/oRmtalDP4HSoM0QXdAQxeK69nvvme9TNKZ596br
6hcMerhtr1eoLLoCq2h9nnEVSbPDDoltfKtMM9E9kEeeL29uBI84qEac2HwiyxZCAwD5vgK+YHXf
OC/GZgG66qFqw591YZVAETko0ZzOCdwh/CShCg/nL6lldfW8Al/iPYYW6skmpIE9K9c0lT4efKmT
UHOJ+9dh3AUnttjWzBZHRniQ8Sw3Z/UQlgfDLitZ1xrJwrSbdM5isn33y53awb38I5/SKfnDHVzU
6+LDfqpLauko/XWxSnCruqhG+gJict+a0NnDf8NZZXoPlsHPqqnDRgUeK6aCfWTszT0l1Wci4ZLT
DC6+nvkEYk16v58d/43lvVZtr/8ZFT41zpz1Wn4+tXoUG55UAu7dGYUZgXHpRK+agNLykR7SkZz2
oC3tf7/AhRKdRve09C1zwW30f5RicIBERdy3ybCkddz92AY9yl7qIgx/yBawcsif/vksWi4n6FCs
hYGlhRk2ulTYP7DH2Q4fvdPcr/B6yh8NmYou+ukPiS680Xe5GuxDanspqYqMnOz+G1bto3R5ZcS1
aH7Bv8Pupf7OB6VOFkWK+zveUMMJOOpHnNEcOPwW0U2lU98JfJYQ/SLkD5KiNQTiCvO5fCu3Qtmj
WSnc+wTPCe5eN8iYhrmDC9xILM4hiBUzWHUHx9QDvdLy3wB9fd7hKaqSw8QkuVuH4q955yxknKrC
4096PCkwLHXwq1W8DO+a5A1Ec75+WsAXl7lbeWMzyIQFk1zMamfeyIQ/ijKiTKGv4LotX96T9/vh
2gryJUq14BWHyyRQE8WUr+BtnNCGRCPR0FBvswn0BL1LzTOA0aNnSPhEyJ8ZhnxEkGI/N26YrKBN
ZgcRWuEZYNWzRydgFEB6VbNbrIMCsJT+gZGC6moTPhv9S8FBw62seeMuufxFUzKlMkspVIyY3H5e
mhofY1zNX/M+8iivpoL100zCX5+UqitQHNEuQsX+7KEV4QlVRK7JU7z2BsbXy5Uk6ZTw/Tlp/36v
wXwDVMSxkSnhISF3We43xwNNIu5Tj2wb03nZ9oiW1SxmsD4htdQKYLJ6BW2N5PTQfVdib8rrKQUs
TO7+oqko1Gzu/jwuAo77LUOIyFRPqofa3Gkjym3p0EpA7uX7X/QbrinRyehTxQDAV//LQBP9VWVh
64TKM6ETLyuRVjUMGgKy94Q89AFqT2MggA6pjHPlvt+taZLeBd0Xws5KD/EARVBJXbBzNzYToCzs
cQCqzo2ZDRhiSksSCw9At+9bThCPGOE/yUByOertcSnWaFPxgBZZjU2r2UHCXroXMwS6zyBBvr9h
ZE7lPX+X1auzfdVE87SxI6bqI4SeHroUxjA8236lEK2KkjoayBhxa5pRgxW/uG0UslHvRFnriXK2
Ay0umFA+skvMy5EoNiniqJNrUw7qftNzdlTgqo9lpjLlpIDHw1Qd+oQTIdBrj4/mow/UdqVVqZ/F
EQRDSK1hZI6d/Tde8YB0kMfWFbXxsqCu3SCu9aFFV0tmFE7xCXVKhgtTi/uTPv1qBKJyhUWtkQiZ
IIfo5AgMkFRBmtm84vYVXMKutS5F6i+sYd95wnuJIE+kIkXb0inXjUsgozfauw9vQusvvI+SO6+Q
+zIR67VFoeJ6RAS6QhHmRwTfG4oWevBT2vXDK/mt6qf058HqphLGMQlYJ6UkzzacuWV8MC+x+pU7
CH8TOnwGWnxZ5wTy0wz7OkcNeBXb2FgV0CnuQ7iEfTA1e/IJDZYeMtPYzzWAM+PflO3dSCvnIePw
74vVBlecOqibZ9TUmP68dtxpzRpHSUtZ7S4zH75iYil1LspN4WKCfrTTCiNSxflmNFyWOpYbPHPh
L5eRLbRsegXRzEI5GsxLjNlgB4igpfHzNROh2/0az3dTdxl5EZCwDzjvD2Ln0AZpEF/77QEkwAPp
T4PL8cFw9K24BLdblJc0Y5avJdI8JdQDy/MVgP0/pf12PfcWF+fK4kHPvd6nvykSdajg0HViJvMc
vBkyYYJhrqVLJ66RyHJN2hp+S+L8cxyz7pTYIjW2TKgUdAQrMonNeMlRPxjHXCNxoQ5RMXw3hhki
lC1SaWtd+uMXVtt+IMNGAk9+QryZds7Uwp6y7RvwC5ZWfYx+KuqxZ/QZ4IaJf9XqlBr/BELj9b7T
cX5JgQWhcDqXt4xnzqIw0M56sYkMSgwYYyOhD/3O38au29TMns2OF3qxIwWhFpDvw6QYDIzmoMlF
4F85opFj/239is85AsZ67DPSqe1HZYBQ9MlMhriTQl+6ZWY5glKLV1E+qwD0QKfKnEMqFgo+v9P+
i0jkhA2CGrwm5vduC0gDYW1Kux6iLF374aEO8OM2myVacSP2J5wrMrplUYQNm9XeP1Gjx70tTPvD
UjneqKyX/touqHV9V1raT5iU94vdD01L1T+hJzkH46LAEjnYojDmbLUaRF9F9vUl7qztehhc6TZX
Qh2V+U4cJQW/DsZKBiIjmzrwuQWXCDvSe1H1tJLdBhIp0Cgm4jIZPL9supiAF+9VOb3ACdvCuQ1l
Awln32ZGgosQ2RGOATMfkaydmQdc2gopQX3VI0qkMApYY7MG6arzb87OyPUJlZ4f8dXVE61hW72V
8MLCA6vhjx/W1gLZFswyTMAzcIQ8oVOJlL1SlHpG8/0WdxMjANZwUEOM/KwzjIJZvufj3tm1qYUL
D6BWWffZ+NvatpMqXC2FApITIjZiRLbeymeRzGnDiWk1oJzO7q1XG8nGdGVmqHQe21fSYp/8zlsf
Rf4SQO5/oOaAUrhRtXPzoMeugzmIkgU4yrUbHIVX/KebTE0bCcac+w1YMWwGQx5WIxqxiyuPuD1Z
zo0jaMaoWAQmVeDvhUR4g/kxps3AapFWjzjDsXRQOVgHTeggSWYQxM/ggJQY8Av1Y+72PlPuHaRZ
PanUuzgDhlHx7UtIP6rhgnQCt6vHs527e4CB03+Ad0WjhsJp1W8KE/+/7eNBVNWnAhjmkReQR+6W
1aTsJdPzSwZ5tt3PJ6Afato9RSYovQYK2PHu5+qGzMzx0OusGOgzYSdtKKBtw7YBKYvIt14SXVDV
bnCpZYr5rSnLsoxSTrOXI0dU508gcYKXPkcoum2jWbCFzUmhP5IZ64p++t/BUNAPwwlCmwOp3hAK
tL4mT6wxC2j5nN7azUP2365PLLSn8dBEpn3MxaYnRO+D42cnsxRgzlHz/kB1zs/YcaKeU4vH7ov4
v4ExYDefYrwejREbpk7pVsl1nMqcR6K4S0zcKta+jg55jcICnmr2J4i+a6rE2ulxt/tgaH4F3dqJ
8Fo0BQvB19k9PzMWlNpOukT5r8zp1iTe/4VZRmueFt4zxJru+iVFmOXsQaDD9OjFvQu2Q0IGQTej
k0q2ec1yNa4lYAGZuXJ7yH4eTmrtqP+0/l8BA9+xkeInrsWsLdNZLodtsS9x2gbby7owsmSJtvtu
7HdsSfdcgwre4zGP0peU103Vcrfkt/Yfzw/LeMlRaE7e8rEqRP3hLBzUd+JtpXhIOKqV8ITPDGzJ
gmUVp77K5SRQESWt57+vbX4eqyfdQ15hGiqmBGrYhU1DWBeluRTlHK0JfJx+nhneIruumvhCGomU
KF6JZK68nLpBl/elPa+YM5/JPG2nRWwdEvuP2MUkEQlgFEzpIxguvs071LO20KjrVAqbdxRS8doc
QsZ5R8i3FkQfZmB87gNYtEH8dZlA85KvsMcx7HpM/1jVcYtW1L1xisGr7PzI2C6lWh2S56XdNlPH
ZA+MfbOklGb8P5p65VsNJaTcdT/5HUiNkxWFi5aIqv0YjSIacsutjlnqsQRuubh5WtsKJXdkNDGG
d7qRQ/ShNhK0z5oq/Ssx7OWzOHGWVhHdD+qK5Y9AKI7w/9fUQtNb35u/xJMMTXbFl9QVszM29CBS
WAJGm3TqBK5XfHr5nt9tkp7RzSg5Wr8SSldb033wXDDgcu9xx+Elpa9rk0fQE4Fl+N9Cc/IUc2sY
HZLXjFzZXdSbNCAdC3fbnZy85VaDckfTz+gzcdf6zqn3p4ZnmeVSeMrmmiFijm9Rsk8F/7KKCaEN
9WEHwdY38JCMzDUYV4Qg0j4NBsFjuF+2Vl2iKWsNW/m012rHjnrSuqalQvpI/Yoo2RU85q2sk2Lr
HF5iKSbT2DdN8Wwe0TwPQlj25iwAYGXf8R+GaJO3IxuR1czM6XBBHNwHm2H2JUrF1F5shfBZps3t
sATpeNSvUr2ne5FgTcq3pUUxxi5KD0ZjP31WNNlabiWvdMAl5mqZBZ06BFqhEEabO2mICv1QUwyB
xDuJrVIma6Wt/M6MriAm3L8wVa0vzWyOnbI4vp4aHKPM95Y8N/NDBWVLtPCcqsGngaxwoRpnd+Ce
ysI4QofZmAIJllzQ8zEzpabmhENMR0avSVGvszc/OaxGNQolyf++chYlruQFi2jxCFq+HcdHK/Ba
sPMAaIlhtb2ydG8SAyNBlVu7/cnVxb4M0qbat1luciQUYZAyx6PUvlbKUeRWM8X5tkca7lKTtYEH
H/a5v46AgL5lgQzyT6ptblLu0ttWkLsCLkNVKwwCIE9C7EEGrb9Sfo01znOaMx1RN0Z6BUyw/Kvj
AkAzou6Q3o3NjSXjqnUmAYMHLyIHKXFMrOQeWePQ1IiU/8XUmmD568gccBR+lJzHenQNJ9BWeIkg
aH4RDpYDQeL4yIrRHzITxKiR/U3NEb+Q2ULetVdGF32Z9A8IrfKkXPhOO+sRx5AXkBfXhyhiUHEH
1zVyX6PaU7WcBPPU0TSWwUCnRZ9rJZLJItym9yhsOZV4X5tOXJliZ5I1hqtQQaLY7Xbz16SLqBr9
fPjOGU7LXC4G/LxpWtEuwK4G6BOk+Nk7MZaEHmH+yNCnd0EhKrp8nmtzCnwkpl4NcyawU3sx9T0T
FXF4sYKe/q3nBa5l+nHB0v7cYliaeITitgAzu9GABE4Ft3OnP2tsbyD7pYU7dpzqlv6QqeioFj/y
hpampZcca3DAedFmFGE6q07bGdmNIBPrlw+tpTtQJiNEVBBoSmfTytoaU3YjS7us2vDDBnKwkqEJ
dWQVxQAhLsAJajuCEEkUBtQW6pW6hCaFVvEs9b5btBCFbUe3IM0aM8w0x2/BaIHjJCRVwAYWaiAU
3NBFg755HI6MvlvugIVsqonbKy1tzeRAtPQ4IzQszO5uO7/X1X1HT8ywQ6AaOfGvxBOwKuw3eFRC
jRDT9yhH4XiPhaNWZpiLsRwAAT78stikVkgtbH1Nn/WwdVPi63vDd2EkA9rFdMOOD/R6+AaWNwIt
OY1OXYfXifWpvlFx0FVIuH9YcHCXWhiWE5bojBgM4Oo56f2lLXDU32VKuiXsP79kwGmmMH4m4pxp
jnhVXsJtge2XrXnl5glA6sQIGCBsJSWRTdtzDG/afo5J30HuJVl6g+UZDHhOnWbAswYJ/y62Bxap
Sg/qjwZaAIWXjuyKQrYvsbIg0YOqfFFdS9dXgu47A0QzJ/v6ttDbyei0SI93zVBm+5rH1OfWyy1O
giClQkNsfp4DMGn84Br2iSdAAMKy2SA2dBcIxBJbBzcildw2u7iz0Uk8UBXsNheG5nUBqsIOYwbK
zRHzElwgkTADSYNLs0uDiR/pAd5Yo8xM/i/+TtLySFQsDQL0hef/choxEV/n9XnSHkRURuyObyg5
T1CH8/wdglAi4v57h1uEK9Q4BaGMoA0V0sqiohaxBA2ne81T7k02Q61/Z192nhqbUbv9+iiGN3Iw
DtPdcGrjlKn+jzvH9UfPd1hC1LZGwosTPkMyrpTSGedGUR+YvA8Na3del/KDZh05oTpZBTKVzjK/
GWgkCBuEwCDq4Cis1jB3wjZrhnbjfWCEmd+yerMkl2tKyMYj3AJCY00vny2TuOgWfqyVGpEmspWS
25233j8hjmYIaeTInTP6rljhj6t4qC/UG5RAZxqp91si9lMqsxuHtBAueqLsX7QWkgMaOehFNLJx
lUg0OGPmQ0rxogpWksqSu0mlZ1GyEo0ynbj4WtY2CMObqcw+nuJkZriGBuRRnyYUgtlGbcXSYg8t
j+e9zBRkL+S7LMHcpzH1GwXCEzf9JRvpNy6Py830y5dFskH6Stx/e89OFvWre8LKPy45erc4hQKc
TZ5zjqXVgUvE3Y86H5AhkiyBuOILGpp++quAHnWyt21Ynrcs3yGrzZKKVfFkuZilpjXthFBBxEnF
zc09j0cLtSLgT5aFl2fM5DbKN19Hh6JLPRNR83IzIyz0M1Tt8NV6MxPZ+Z1DQoUV1WWjwyK8tVSH
fj5Ndz1M+IU5WVpDOM1hCDkAUKvGyAdGL94zLRRI/lnm6WWlcm1dIYwVtJvmy5kJdFskFBQDZNf5
gYdx41MyCouupAEOrXuOcVTeEd6SRBo8Z81nbxEYCTi/WDvIdxmBIcc4b7UXqo+1C083TnDLgbci
wcpiLu2zA9wcNG/CU2+wzS0iK1vs9wJP4EIunrmyrxkd8xakMMzqTuo65W1pDJ/2bjC5eZ12l9PV
TQUqKJ5X23wKNuCk7AXn4qReV7s7O45aTt34IPbzm9aG/BiM8V32kS+I2NAV7glrKfLQwTYRhkgH
SPW2pA37v8Nb/Ij4Sa9Ncg4cIwuakSOcw6D/m/KvX57tsx2J4R9Ldm6dKb2giIxEyoVTwTpKIPKP
Km0Tul/Vrp7vyWrb0xX0C82Xb1E69cj9xU+rPlL9tyIA3uLWqRFF4u8Q6HdmC1QI2q8o2AYAGBmu
SMCAGllQG2Az7VuB2m+yIvvrpieVAja7EhuY5cE7KTURFgywzt1f9fYushysAPjTvwT5T3I6nLS6
PkjGlJJIcmcegaXtK+4k8bbMjCBGjoi/zp8l8I7rwRPglrkcjaEcpTHHiYRC7e/ugBMfKraephIX
Vn3nLD210RQN9tfUv9iSPeI/Yl3N1ETjePhfLyNf0hVtOo8da20Vk6kiG1J/WJOE2EHxwA/Udm2G
xLHUhggLO6rK2GfJtUxmknxUKV38QADDT+yWEwDGW8hHUdIuDu3WGYpEhef4Br9uuSnrmB6TVRsr
w0+KWWuWZu95GI/1efNBoCG/DsK5KVcznXRw/qQIN4Rv0iMgkxjSzfBUv5p0bYCG65XwVLLffGUT
2ZFi7YjKRcHtjB+SQKhHBiuoDgaLVo80XOp0Pxr64FGS02auqZnuYyJqOb5dE2C0Ng+xVxbtcnS3
OBKocehpHBqAiSkEo3HDSgc7lP0WBPFF8x5+yT0ob5KBJ7vEFvBA/8aySBwR7ShfbM704RGeM8x1
IoqfXvmOxqE2txEoH2GHOeW7irC5/pHubzEYPC9lJVE9BKG1hsc84dFl8crbXvC1DljQatpcTJVF
Hluza6YKcbxbkfnn88bCZh6BXQhoNhS4e/iNTIKfSRcIDCbf7TY9xWHlKpk6I6JPPUB9LIYbeI/k
AEO4DObzZrWuAJM3BVzzMPuJD4jqaZoWM6m2pgw98pZ1y3sCCoBq4eYPewnTiLPr3sdrVNc91/OY
pi0i8spPva6bthO+urh92jp8ghEiHnszO3aR6K185/lVLGM27VaRmgJTF5JakWCYFpOdd7ooU5Uk
dS5jSLPl3ZP/ho8RCGRkBWWdCBtykPuKeSNKsEbTdVpul1O3/eFSM18chTC1Svo7ACFxN/8UuyPJ
CZKOPFcXD1fdlYIwaMFfoXN4hMobDJT3Ll5Xos5DoA68aWhBvz1UHybSpv3A4Wl13lRzevpNyMhE
lKo++m8iqk0SMR/TF9WbkXpUKSI/zTlOcdTDbhTa5WchzqWSq+UF7sx20O3tQzKoroQ3a5fVZvt4
a0SoMX/NrA4QbyO/HajPpETzXYGGwLbbLpsvPql2nTdTUs72lL07fgbeocNwyeYqNRlSG4OJn1rO
ntS0wKCfpS3lVstnvwbdNB0r8fcYEJXQHAO4yqG4DEFDitZeT+m7cTYk9JSVG9ZOwks+Zvrt3COA
v16sNrky16+soR/MDe8enucnQXoP0vmUJaJwxoEJaRu2ggfxdefZ3C2YBvMwJCAKemXjX2OSb2QH
HYxjSBve3d2iHd9i6YloO985TRg2e96lmz+qS7iOz2cx41B1zjOZpOYaf4HaD+9K18BjQJIKN4PV
rLeANAZOx8M0uILGp17y9wvrSUOJo79JlY9+NZ/24PZq7+tqz8NqvHNS3hYTn084XHxVkc97Mf2W
KMzNyByoYmiv0cGe/AcZSzILaPASI4dN7OnQ3qLUcqN+EOTP+DjVJK51uwbwVcLPEMbBkvqDpS66
86d2SeZonjjN06IRl8hHP8iOk2sBtTFVnZ09aQVOSwzNwZFN7zd1oI6mxGn7PfgHfDEc9TKDUBHi
QbxIKBZzao2So369P4YMMcLHFM+smIAFyUPEPWbj9/LjtgD0ihcYg0vGOPEuY3yBozBZmWnp5VrL
OsqWtmyeXGnqaOdM9gWLus0VTPbtlglyC/+NjNy41IfJ4PsMeHm17LKOvJt68OTaKiDB5/DPt3YK
uLtIfO6qpl0XTh7dXIeGi/GKxIqBbirf3BsU2suioxmDVYWaDFE0400NZ+11YXQBoTVgnYvzP3AF
76ZIruJNPG/9ST+mnA8yFq++R46A6xbdzlIpKBu4R/RoJhPmXZBUizt0LdOMnEkpwhtiRyWYGRFr
eWK5spTyz/pWIxy4IAAYA9z686/Xg7gQ3fuL4JNBRQ2TIZcmin6viQaCXN2QdvWRTqNAZpV1m12a
sW443WECjGwMt+AJA+4e/pip8pyNW6L/cDPA1vFQmcaEwdbCrgezPI9UO0FmxE9W+v7+HnbmdnLR
wk5PMb5bfIX1Jm8KhHakgPC+MrfSDfPecGJXpieqykR0Cyz+lrmN9HofmE2o/R/HRyrXXAEzLQq+
SXdvkBajyVppaU9wg1k/46uURtihAjPPV5pSIzW5Dp0QJFNZ0j27mbSSuUQp6c6Ix3xxN0AfWp7i
i4ZmR4Anmb3qgck2tGD+udAOULKOhhRxXixnlyGeahSPzf89OddTBM8Bx0cEUv2PTpA48nm0C4ME
6/ft4bem/h1oY/sYTeLmC6yROvXBoq3LbMD2M8Lzz0DE9yCOCP9tw4mHgBkhHtf55QbQd8s66ov7
ZqwldcSHKd0dOEA2vcyo0v/HQ6ftHYv3VvDrJW1eJ3qEpgHsyCSQJ6Fdq969pm4bTAVAwyjSMfC6
WUEQUFsaQqZRkk9wiej2Wj+y/EjxK3vpZXg5unF4K+nYl3RBQwp2tuRJCTkEkQwf+TxLcot0NxsP
yFAuSPGtZS3E4gaKluKlXSPCNbN3z6kVtx0+BpdjH2M/29i4O4M2otWFDWa54RXd2PR/NH+2N6U3
7//lCTu1Y5IummsdM/XIKsYVajWeQAXND0X3ETOotfjHG2O54OmcQh6+DdbfDqxqPsDXbZ9gl1KZ
zBS7BhzY8rxVd6UfWHW492fOFftmOmz9vxxTCUsQMfDeEFIqhcdks2qXmDYA/qe0H0sHJdj9DWvZ
peTQz8oX6Zb7Pc0q53tZip9eJxAldTlr8vpOg329+e9UAlip6j9iEpDtbtFAuqlpvsHwrjfHQcNB
9TBU/tGDIC1l//meHk6cy+aPfJZcoIa9xLXd4IYkqInMnWTVW8XFXVgUTNIoLZGxPQiljFYs44GV
T0mMfKwXYQsxXpiTYw2uIHbIy2QRvi+nZHPr10mJxTPKVOgFFe6O17okyhodIRpe1wV+5aqRrBo3
bNzwjnm3nx1c24bUJnIg1s+R2HPtugB/RcwnNHLNA993UU0FLTWNDgNLKbX/9pUFB5cjfdNFtt7h
HYVoo+ZEyDyAhg9YaZczPxHZ3Fd7v9c1gHPDFFL4V1dDiTWVV91N78Ld8/B2UE/W5LeYsnBPyE9h
iy7g2e9IfQ1kNTRENaVIglrU/yVCyMO/O2atA31p0ZRtWHSjCuqkUZdjjQeKne7Iyvb1nCKfcQO6
r1CtZ9iGojt5oPvXS/rUi076S6u+RatEOQ0UQKEKxA9e8Eu3vYO6YbgFQ2Su7senniouLc5cLPz8
v2AkO2dk8REXZzsjzJXqKh++f2F9osvLAvl0VE1d/v06Zx4fB1S1pVoUTsRNhzskLkJocBf+6gx+
yUsHHy6tZ3KsR32KV2wgCy7Z76yx8kYd41QcsBrgYqU5rRvHdWBEws05YPDB88F+eT27oigD7xSi
FB6SyTcg11namyHzG4wSJMSpx88n/Xlppz+beDEn15KbGV9FPt3yKXZYld28b4r2NR3YpNNo/cGY
wnjDefSd8Aqm+OrZaoxXIDDg8p9AwLQdy6I6mTzAn1Jwv8XyhOSzljDT8ACHvRcHNwa84rNv5qb4
CEldZ94II3Esxa07hhrJMho5GHyeP2JDrkfw5u7bCB6Qe7JqCtF6mMyjO/Ti2LWaW/Lgu0ak42hL
suBEajsGH8lMlTgon74x6tUyofS6A44d+FP16fOoOeeI4+r99Ag0qUJcU6vzhSruyC1YAtOH7mBb
4g0lv5X1ZJTqGrTTbBcONuu7ImXjpf7xxNLnCv3hQpo/rD24vH1o3kfvz75liVWzhwEOe8vxREiR
SWtd9zBZPV1a5fnQtv3CyIWpKKY+3E4/vkzw9M+Ejxi7JJk8iyHYf7i+3SixfgSRK2NJldGs6L8G
L0UDg0ujIJMnQoiikE/mz96YiTNiOJt9lzouFcjo6olX4jHUqELLksjs2T1YZlk8CsBdY9aCzAWU
TlSQZus/iW+dl4xI3SnKlcSOUlzduE8E9DccEVbOtqmpCn9nsdPS/xBPgrfjzB/rg4/0bIbvHki7
Y10MPLsy/hqR8bDV0a9IVsAZiyA/pELHFMgv07/aquWcmkl4SiTdqOJ0yy7zEGpbfOF5TlwWlK5F
yYFwR4DZq8wqF93Vu+MXgKMc4izeuMYi7hkp1dYFvp0AuJB3JZRKEWu0/K6gcXo2cATuulyptZA2
kGOCevQQqCvJ8HYSecic4pZCgqS7xnMjtnggMwJ4N8anVuj3euu5d7djcjbxUbGOb+C6dIACNSwO
spMLOg/rJBbam7Y1YWHqd7qL3TOUTC0VqStcKGt/+T/yB/68JHVpJQsq/ZUkj0Q4bLb81WbiCXfi
uy0NJid4iKAS9XCPtq7fkniZrmC3Aq7YLXbhm5W55qkccQd9AyxYVePKAjAM9oxjgrJVWMZviFm2
sZn7caAR4sFgDDXGjQqlnXwyTxgY96JZXw/z2aJh795VpyTEsgdSPhWz32mygNqhUszZ6SBH2gt9
4tlQPqGwOBaWo8Tzzrosg3uuTdpzGVKpsNFqHVuBFhcAixoZadlAHTIqIr3l9Z9t2ZegrS4gR84C
TVKUWn1pMRSjrHk5HMNKRPpY+HJi2K+X7UTI9I1dFL84/K/sLLO7p/ADiNQ6n6KW8QBx2gKHPA4t
qMjAZ6Hvxx0Z9JmuSjTn75tyBDGmyP1a/zKWjic83oAnZdshCmoqia8+ErtzAlQYDQtj5h1I62s5
IbJYCAxEmoOKvluwMn6Ghzuu+cNuYl1qYOk4YwTN8jjq4TWGkpM1Rk9wpuRm3EqEfkqeL8x/nVli
jNNsFEbhklFcWLkLcIdT+L6IP/JQV9LW5D+Ll8dYfXxyzumVhyFcTfyZ9niTeUeik1BhQNnWUtOM
bgRFrU3YGERIEBAwpehk//F5COJWWARzk9yxzxvsQNtiamvwXO1o2J113wUTLmpgNRcTK6lEjrnX
8XshTovXibA15D+8JWQmEz70yxdeBGziIRVU/3SVLev74lcLs/16rvDfpkhuM3bYkmTqc82MIKSu
RXrLnOEDLXE/V8khMoT01yq6kTyn2/sBzwlNM8C1K7h0LMOJ5ZVsWo8JmuphptPtozw9sH/2CTlY
d3Yg5JRQULb5RnKLAfeDeh0vDdgmUccJM5CWH2QV9f9FHLNXD5lLotahB1HcKwziozCllBpTbGcI
f9yzmo+5y22M0Z0ukjEGEWmsbma8Jjj74yK1QUkezsiX9bApuYX+DJZy35NAWxIBAPm6/uB6z2A0
VPSxf9yD4aq7dFbTM86lPIOfgz+VYYVwf+R6KTBqJEQfBTuwQD7+vJEyWMzeOqmggQzisxCKN73X
Ron7g5o8DabUaWgOXHmII00bZtisK95kK1/TWSl1kMeva1v6c5RP8EbYVWTBlCv7gvQQGr3st7VG
2QUN5oIjeUT+0CatEq06+aitrIApFkRZ9lZ9oQ6/KPiXnGwwJqJcsDaKEAm/nmK0fA4xiQudfu8q
j8jVfZdKu50UjmTLbwFCOVKWOdre3rWDI76E0UdaUjsew7lBp01iz2cMZIzsBLx3V1VxIH6/pWpT
OBnK+cRnUL+P/OGT/uCGM94HElawg0S4AmgsREs6v2z8NtVYHcB4di8wODWL5PCx0+7hefGZAICK
Qy1FfA1DaodiFPLh9kacsE2f171npWmlBY8ozsNCg/4mB/qLa58OAaAhzQOR3UQnzhSf8gkRKclW
mvOkKDn5th9MnetpxqqRMbmUhymwAsmi7oLdsm+s97jubrKMRBh/igkut2NDsXjwWP7/xBa3RtkR
Gl6kFEqzkZVYnWZ3f/3tK2eGzexaLOQ5ZzZjc+BwCARhBV5LACq5h9MAwkmHGajR6yBJTHSXEWjM
IJr/gBhq3WlPFhLfE9/1u3+NyjZw3UiC/NXSYdbaxXxWwODEzjHNRZvqec9WkChjJpfhkceSWuGF
/yrH1xLZH2TaB4IKjsSyr4M8/aUth8bZQViizqh8gssi8zL9HZJF8JESZoZkOrmcE6BRwDjk7Zwn
iiubjr50oRYjgwXHNmAJOGsI8mLlPOuq2pnpGyuEsk/scTJ+PPgHTVhTO4SMGoNn+ztbaF8XgH8f
RixXiBs798Sd2ZsKih+ZFSQkMahHxmR831E2r2ePrYHH/ZE5aCkZsF7nS9dtIFTA4xM/f6O7mtyE
tu836+oLCdzqdDgHBCQhWET6AescWTfQgm4J26m8SjgrJwvkeQmhko3TGAbwpCucl7L0V4YilOmH
CYmky+TPMsph0KHBpWA3ilmM1lI/NlDPxuPA7ICROJSyBfmul8QGpeoVHkLNW0ePvPIkFwHxURHi
jpxaCv0MDUzFAx5KRgD02BbIQSxsdS8Tz08tN94kS9D0qV/o2m3xTYrfXxzUiNKsSW1Xy6T1A57d
jm4YvxbEhOLUC7guvdfPCE50ZJCh5oEtFD6eIbmdmSRlKVsYAcQQfGflSY4ThLyJ+zdSInQnCwhO
MN/D6U5biEK3w3I2iT575md1aejvrhYkVkPO9oYIRzYmQbVg25yOztQ+4UO+OYC4VzNJOIdBPUkx
FYWfnyAizNTPtWfId3NAth3k6eQGz+JwUo93gmnS+Y4iK8ZLVyPfW5f4bXicSd1n798yrAuyGtA4
IsYVcs+jwZAPdoXkjJFdTa2X240y8GB8kDuL99XbsB2r4HWBcLvYO9W620ICNrWmlZeV2Veztjn7
h9hXjwh4izA09h+8Bx0Q2rrTjBoYmTXp7vfTI804YCAeWWts6iY3jbmp5TNdco6kWYTsm8fpaUin
EKpYY/4dKVhfRVW5Ok3cLeB/ZpzxRTLVk6MQIQQwTRoicKx0tTAZg9SnuR9mR0DgT55FuSbD5drx
my0rkRHchGYxafM9R0pYpgNuhH0Cax5cGZTibIrrOxWq0hNNEhR0bWRk6e4VeAEHnsEhF8bgWtw+
ELpc2ekGgoYUnZUf6jEoK6gg3LusPCHV7UTFZsvsgJNfz7MzgNkM03GIkkRyK8y1uFKjGbRytq14
hOe1+DxFQixe10HsHYBQSQ/cZYu2tk4k37xqgcuKUwfypYE5qAu52rvw8exhvA9CcaCOOcsQZiFU
N5Kevn7MaDLSKyOO/4WCBdJa+8+EStOUT77GKNXjjsUp5YeBTNKMHDUi1momeG7n+rvTonnDJJgF
YAdx6eTZKyrasCMfAcgJRpq4uL/6YrFwTL+DKJvjJ7Y5eqhxxNCKT5ro4Q0VpnRNxqpBNNjmiR6Q
cmLQLPe6XQHGBcr72hFxLh4JfoGKV+xophVhmstLzp27LJc6Hk+5/2W8g5rHx7ndHNlDLovGIe4p
l0ZOrewfSfCOhGfbA9gfhUJ/ZZWRd0AuN1b5OtA/X3AvVSRZUe2466zX0u03Y06NVkLafcU5PH/U
OOQZ9kZ2OFZcp0FJ5FvYHHeEv1aGHAEvU9hGfpjQxBhoeuKyetDNNHuM4yHnFwj4bA8Tkehkv2VO
ePNg+watc//39ootG0UNQg56OtgCq/iI2dwt4SSiHV/Oc8ECAY/PzpqkIxC2Nr02JhKI2hu+Yjcq
u0i8vsuzcwE25h0LCZYK/1WYy61NR53xCGkiD7upokYTSaujWXqew4uNfe+7rawRS5F1V6jan0ts
Z4wD8Si9YRooKsKTYeFjmAzM3kmf/rYM1eeqhko2V6WlTOnzyENSr9Rv3X5eBqWgIxXeRGrZn0vB
bFhCMQz12oAzUeOqq1JZxHgiwdf6XDkw7EDfJzjFIZoOQt08Lq3E6ht/AEJRNAZR0/QR4Q9zQ94/
f4u6jfPDGhxxAkNrdFQVn43vK9j3sM0cFRNCxsd+KQxXrqszmzBj+8T7Ex5SWzmwHiGChQ6c+u5N
2xS+iEukOfCYxfye3j06CkpXaaDz1HsjUWvcLf8B0IW4hY/Xa43TVlQGgTJFX5SfA9n2QwvKFqXm
TcFPsngT+Dki4KlBIe/NXMxvlzc9z/bR7CBcIF5KVGIRsfV78W6VK3BQDTfGDV+9nQBLf7CL6xO1
gk/2p3wwGEh49oHcQRbNn/a9Rv/Lc+WN5k7QRstniBbq6yF3uED/9IqRFy8Z0bOHpt0cxGTiI+5O
CEZzxE/yI0vKrxb1wW5EHm/cGMd7+sjD2CnES6cUIs5an7HaJxht+lh9e9RMsI2C8cKNbKvPznba
LCGeutVDhOFax5jhn3OU2r7UJLdO1nrxx6hEdZIIBIZDfEZGy4Cysl1W79PnrWhU274JwwuiZVBH
9VUDRZC1HBeAitpTsg8B5ZblWDQJiAdAGKd9dAH4sHHy4ZQDF3RfF/KosBPC8WdieG1Jg64+kvtN
qNMwO05KMVuXDwvrWelNs99z2QK59Q8dALvAsl6+VibCNrN+l9Fr+PT35Al1WBe82jGtkUj/ZRHq
jPAwop9MFoKvFzuSM+ppR8RGRzKW1qLPAUNnP0ugLwRZdG6CNAQibtjPECndk+eBsOjBCN8Y1zTU
o7i4w3H36tkdEg6w1CAO3xdrAADkSonX8Z2E6RdmakxN7y7Xxd7T6bISR7whfaNYns1HSIZ4/Nyd
2eHnnhjYeRBbkqKZfrEQQUgV39jtMBH4R+EzUwN8dEl7Fy5SBnD2fnIURdJ4eGTgwLzHx7JJ1Fxm
9h8rqPD9T/3Y39Wjj73W0s5m83f8PrfkOfIhKElU4ZoKNReYYTmrjli1/4QylmDwSFRxsmwbalb1
gKv93tA3u4owTqmkzM9kI0V8KLqTi2wzjUFvAp0uNCQyZoEqYLyqJ5xz6PgpAbZ/tcWF+d+SWJv6
3HercC6Isyg0/pvmimvIYEvKeL1dZ9zHb17ge1uLJrgwiLskKQSJ1vmYEfTtbnfaHowWhkheBgPH
Z17M/3rS/8JArX8mmjglPnMGDWkv3bFoQ/yzaSzEZVkCJTD+NskssUdk1hi0khPnnTTJqr7gz8I/
1+SOhTQ/AN92QQmR53OgjrLzDs5HVlGtJAgNGmAU0e+wOxZJ16Ju/MA+K0ldcDHA7RJzkf31Zm6p
+UXIbx4OHMEp+DS5cUrUa0V7hjgTP3kljASRZDpxb4I+O5YPN7n2KxfkYnXSY8wMXjwbNv+ywryk
P7x1At1CSKu9yW9CdDNgssgMHSpbSr2M6Dp2y6NPwRWUvkJ3gYYSpBb4JlAsexL8CcU+coZxPevm
7uDhebHttRlw/2Bf1bJcNALDbsUX0bep9l5gFEZJ1V/csS7q8/JHCZalF/yAs7ZDrdYmPjPEeveJ
ZMvZLkLGbFn6m3n72vtDCWIsRCh8zN2a7xMVtXlrXrnz/RM9jsJGuUOWCKk2OxsjyXQYEJuvCzBD
imKxyaNUGUR+zc3v8yuQCHKvtRh8gl2e8jF9+w15HE1hQ/XDCoAMqJShEP9ppjnQmDLML3Z1/1Hp
QSMFqeu6oUkVLsJDA1hnHdMTsV7ks5bsw6Lt8LcZTuLik+kJ30FolFbCJaXZ146GJVvTtdmSvwMy
ToXnVTI+wT1z1f+8DgO4Ic7nyyJ4sQr4jCqj2C57SUlGYz0TIDhb2qpVJp3kvTWuizaliqpqUEFC
RkmombkxM25XjhTjC658z0IZON1WrPOwMtX/aCrRCrkV1pDTfOHZL14Y52Sqt+3ZMxnrKTJmaMD7
NbPsk/u7aHT2JhW4gefESK54uvC1Rt9DLxNxgvENq8QVj7WHFCoNx8gNV1t1h7ncNTYxmW7P91Mh
83EtAG9UzCkHCWmWt0kpwcqYbDsNx/9+682WGmM7GAyPCAUQsDo86DM5VStMgrt42hoFnwDKFCWF
cZrkxPbjRgEg1BPQiiZjVPlSMbUxLtbWGulj1H9TZ9NG14SdVcL3+8ha0c8mdtrSLuz2PTPI/AJE
5ack6RxYnXDcd4VFxNq45MVQLkjYjADyjK0litwss3TlUSS+XnzrUX1X5+cfS1Nf1yIgYDUPt3ea
lwvrBmk+f+p3PMtJHBomueIZVgIbVDu49WLfszZjRO6Wv2Bj7rlvLTyp+Aj1dJ31flA0KjQI8ETH
fQlvc/LLoU9PMW/6iw8/reWeW7Uatr5fzU440LSkkYjeRDFF/Te4IuFsde5ARTsYE6iUiK80o6kq
l6e4aJCHl2ltH6nmVOQfrwYDcxNeQbmkMCWkoX4NjkUduJL+7FOdep5W8xQa0xgDoWHfaHGQ+dV1
UfVbAMQHLH51dfa8l8v0TNJ9FW+seSBud40XgaY2sAh9Lt47Mp+SG4dM6p+vsK2E3UEa+RSZvFV6
Kig2TDktRURLR7ouuZ7URWnMVbCI5sDxGCGXbCXuVkWrSWXJZl5bYQlO++NoDLO/8hZqL+H7gQQm
DEjtoTXSM01+bHAJKMnAVctvJFZmria0pw+/8RrIREtJknt0pvTHt3oWR7xCo3J7Gy2G0EmCf93M
JcC+RXH5ZwxhAgaPoYSvnPiIt2RvFS7n5gc4U2wdZxHTkOp/FFcn3IwCmaEY5lTO5Tx8CWyk0Zb4
Ub2WxmQnv/EFx4SccxFBEYIvkcw3rtS3/JqNL8LZad9DsRQ+HfCizZCP0xOTG7b4sWzkIU4TcVmD
i0ga+w8V8ujw42+qRo4UwZvXg87sRRcYdJLnY9Zx594oEtp3gvPuwy2eiyeTTcLzy0ZcaY35k3Yz
mvYTy37eCuHWg/io13iQmaSAVEOdZED5zIpFQfi+l0TcMSy4uP76CHPvpSUIfrGUOlt0S7JN/xwF
iT6zZUGeN9fv7hBcWmoIoj/M80eg214IE/cx8OK9DWVSEgOcgc71/2kkhseL5avscR0zSvGSTrxb
otE6CyqrixGzvPg4z79LyH9AFmkZr3NeqAV16ZGD5VxzIAs8ySQaX80inPKti+UfAh8N95Ye/aW3
Xr3K7Q5RSZWAR/lsl7okGWK4mjxY5922NPfjzwLNBYuR4/6+VBrbwS2inGcgupCKlLBw0SQS5fuh
P1uemIYmOOPqlTJan4hAh9wdLZQbuNryrqCA/Gskk5yv0wMe+XoiZRbO/uVMu+ur9FdU+K4LhMEU
EiVkUdhUMp3WKrbvYRynOSVYU25cXUHxFcKsDbJsxwqQklAtLAwEHXuDB8PWN5EcnmjivWe0PXjI
yt+XDK9PrBWkaOMqVEkZxKJYWNfEBBE9zDb1D+3qqrWL3EP5wOrIMieHjhPt5dVuT0L0RwbVQJhA
NB9CY9Zo++oyScfrguW0piwBF3Z7tHyRd6/+FsFh7m1vt7Y9o3/BQ0A8IXm60nndzcp21M8QKUGw
bUbiPsYwnU+E/HJmB/LbUZkc1kaJJr8Ii4BpfDIlTiPYNpCAqMF5WVzdKvgpcqGh0+8Er6xd6EAn
UubeBuZ4yGbR0obnMjlzD0l2hQDlJaUsSClE3Y//gU+ZJmClqKQgManzvg+WcpsOC2VxuoTx64+U
omvruaYlWtdsRqpxn3b8VMQ1AVMekiO6HN0plEEsg1Y2HkKr6SWyN4Y/j1LFa2subzNKO/t/j3Un
7hAWZJMrWkxSxymtgqcBNsHZ8jFdCOrDZzH9lnuWd9EFnbywC7zEwgBnVHsbsQ/wFHp/3b8e9umM
itmbT44BZ0Gh1lqxMHGd4EIecSrZrzZXsnmuYeEA3/onT3k7AAVrcfa8lZIkYQXCp2RCA+4Q4cNv
gGhrRgo28CyY/sgfqzmurwCTxFqYE17eBpeO0P5YTR6fanLgBO0lF9793m6qszDGcZn84FRb5aks
kUiTDzsYlANCIDeaPw4ztDulfANy+bec0tFBbEyW4Yw7bDDPVbpUAd1elaN7ZUldgITiNnduAB4H
9K9QG/iKImmZ8TKXwVec+kRuVHG/JJeSh1llMO2WhETtHaL8h8AbUzLxesMp3DWG17NKp4M/NKhF
dXkK0Fke71lFVyjc2eJeIf9RA0Gwf6Ddjie0LhIadHsp4Zqwfkz+Y+ypbvvXu0tpFpNG3pOQWc7O
qeO/KTJd6dN1RCBgF623A48S/boLog4/W/S5+OianUhL0IaV/DhCnizLzTY5h4hLFvlgRA/4vflv
GTJN8ZxPqUWVn2f7cRjRSAqtFvJh8RR64FtmRR/Ildht6mhQF+j8ocsxI2uH86dxejDZuwPRu2mH
iwSGsHE5pQz0Wk+sEx9HUoSdLzD8qp1qNKMsNKLrKaxWtiF8zDaIKX8PH7SxVC+xYLEP3ONykysA
a6ZSP+gJs0Quptr0AQ5s8id56AKJUPGW+17JAIVMOmwk1BoeC/jVtJoiGvJsRVVa3Lf8q9QGearr
JMOTAe8+7MB0r75VaBpRZx96HMpz5YhYU4dZy/OBwYSA8KX6Ra6uuY9gyO9EIbs7Ny0o5i4arb5W
nX+gwQlrT/wdarLzwLAc1iXEiNhQvAuIGHmM9qdXsQrWmkJrN89jtwJN8WTEODf0+3wZ+TQk6r+Y
/5HLd5bYuUMmXM0EvLgAw//sZw1OTm+3yGmDdB5H68ZauxQIEMWP7go50Vht+5IWSudipXdIeiqB
4C9WP1kpN6VekxhWX6tEvUpps12hmjnIHJ08G2czclwGZ6Cud+59Gnj9U9KV8bWAu6ZWrBLeGEVg
HqcM4BqYr4Y2w8Kuarq4PxyvBL1bi2Ap/hXvMsBPM5FkAYVKqGT1zGSy7+AkwmrlE7eg/RPZnQLT
jjn1qYI2KlD8m7yHR+OFDOmSDaPNDeENAxcCM+Ta2lnt4zyDIZRBGYpNuQl4sfSERIIh/RWi1+qv
1VVQ0oFBLxYMEuTGxPOcwfdqr1nvHEdj5RWEVVCKbgBsdnUb49Yj2HmFN24TPLHhUiOV/pt1AoEe
lQbnHo+Ln23T3Pic+2HXhN2EL1oXE++ljGd0/adq1fn64JTHN7akXmAOlwR2VZ409Jm+/s6YBJQi
+NA0nhTzhqS+yonyE+JO1KhIWXP6JzKhKxWMCVuO7alKmjyGeoMxb2ywl+aTPyZmxsc7noHvUxTq
/fumM2qcpKqxXXxgJ4XaYiIyXgeq1fJ/wjcmBpTsJN80k4qaQ6q06NrSMwGCGhbJZtDZ8XQyvg5X
+e3FcJzGdFJ06ZRa2UlnkR9CMylWBv5cc33qRgWXCbMKMw9uJgfBR5Tdzj63peIlitUvLpz6jUWz
Q6183CYYSzLOKvdcFqIo2OCILoXcOc975XWEFFxKNfErCNquw34jwxOcS+Ie8iE6Fg1na69PmPKd
1QvP6773AX5b/NulZ8S/PRMoRP6yLqYCjlPbgxI+iA9w74AEq1PWLBGKk7IhcvmAnNXNO0DhQ7T3
ht9/lIdny/J6O74ZsGtx9a3uPTywuSWl0Nzw2KQqKyzKLRjsWOw0MZoWUmvpPgvpbIdH/HawhE6F
aZE+PKgz2Y1A+8pu/+LWw3RYpj8Gj8Xk8lHnQ8iEs4CU7llD3FUPDg8GV3h0ycGmU5didNH3PrL4
DHygFCAFPAL78dns0RYkuAt+dd4yu7V1Zw0sqi3J13UPxFNf3VQsHR2bbmdXOQ2K6GZpoZHQLkPU
B2rKZTG/pOYA/CFheIuBBRcT7TG0ECz8HcMp1U4bbs8eCnNopUJqsv0IlCQvNOCJCi4xSMtOa2+f
LxYEyrO7NAOZWlwt8RAxn5A6fXDQ+01k/Uh3w7qH/jUJL7AN+l1puKk3/sQByXbO10jR0sEIiv2d
zsJGj1/nrhOk0VABuSl/mMf0bHo2MicjTHVtHiPQDCuLKa+8VUopiv+XDiggEjshD20/QPr7Oz2K
JySn7KoK+x3RkvyiVZclaCCpqhty2eac5gdqO9MeSleiGVZm7tibZhslPxrY7jFhClfj907K1lF2
YaFEGscKWOGcpzgvgY6Wopzr8/MDgzWzQJSo3pIDlqRR/iDG7aocL5sTEhVW9jKhoLndhh1YlPte
uTkyaF1o8YCWU481gwx8v+U9wCtxbn3sj4V88oe/piwBL14oriPRV1AQDLz4sbsEd6fRCRxhqcQw
tHCigDQNgiEWFiaBVN2ptRSmn5ZYfw7blfWZiC7ic63lQnw5/W/KtEIQeimm12sOplYkx2DS0DEx
vY7I10AWxQNyO+6pNSrmUzfK4NeLiZ3tbKmBmHv9ZIbOaCaaanJQ3EyHpfzgXWCnF4rzRx6a0I3b
9ArfIV2XZlxtC12Ufx/HBsIES/6SelQnnDstOluM1CUpRep0P2UhzeDAk7qjnYfzOmfVXmSBXtTW
MwC9/INSvt7yr+NQ1CXWP33P/ReYlJTKN3pV076o5/d/XIL5F5JN1gOwhhtFtfNFhyATZ+iBCgnO
jfdLKKuFAkfesvBOBf9NPZM7x2HpC//d1NWjt2EpuKoIdzTAo4lzbrzVLRbWMjWBOSpLh+Zpuin6
bYDEZn26dBdeGgkY9rcsR6FSCZE+bSA4bgv3TKJWiaUBCTJBIxErC9Gw2ayVkQY8XNWEbESQ6eCf
tvOM9EjvOhXt/4D848w94io+5ai1aG1WqpRFM5aShmJDF0NPP8kCv3U/TKRJ1Opkwx6Bln6Mn2KK
87aplcs6mkeZWMVUP4dYic/cLnmJI79I7/ArxFtfME0YcgX7SX4MJnZHmYRyqwhpdmxqdretqdOn
OGpPhF4qLJeF4NFcbWjVUqx4PkfmWqAH7Q/Cceu1X0NG2GRjVGY2yqVAUu9PsZYObfvn7dw3SaOy
iJFHjOpI4X4C3+RCT9plJ9ajqOcjot9mv2B9YfDEyj8qBGF2YTJXJLjQ0vJQgu8g1BmTFg4mcief
bAWMv5SCMp0L/lmTXlb1L/d9mb+LRj21HBCVtvoHDykWCNSEHRnB+eAgCnKmL0T2YCg/DPigEK2n
L+Y0KuJ/WtN/vWS0dyot8AmAkKz32IKBQV9dp3jG6cvmMLSq4n/6Zwwbn6f72WRpuJKEV7ox/XBg
JqkaE0cVmurmYZFgqsrImPM7jjrjpu9eKF053JRjSpRMhaejCj313WR35e2YR8MquUlUBlXfiw1w
6TemuaDm4uWmoT1tjZsLUNTfTYv01xdZBASJ+yD50Hi6jIjIuPcAuCBnBdgaiweV3SsgO+vTngQb
i8Q5Viq/VEu7bXjlWPZfK3V29tRcUv7Ms9SS2D9rrSROJ9mgRAUF0KdMQgg7W78zunjfk2PbSkPv
UhNxl00qjAK5IUGW5qWDD+pePJAwUGvYFuN32vxF+3DOCav/gArzjLDXQB14nJ+LP5S9bdjTHjLV
5E9JZP3iByVvjM/zz31VKHjXvqP4QAu4jiCzhUU4wXn/vZy0JokDCL25rQC8tvExPW5Rh50IXZtZ
AASf7ymAb1UPZJt7mVtChthMOpSFkwlhrtolWupt2v/fFyoc8iuXfmPQvu4Gi42iG9rA1SderO9E
tglXVlvYEf4BhA8Df8VV1OS5oadszuPYxD/kOiZNmkAwonCAy3TmD/uWlljBxmjXqndsLxBbC4Qe
qMIO+IS4+FZMHZtHI+s9mM+/HYc0QW+sNsk/UGVtZCtlyLxlalU6uswGX5PwTna6F3YrwqEzuXP6
9/MVFyKtD1y2XD4q2xPdDaNrOgJdPQnAA6TV9SO5rVpxSMFItsA/9vNvVO9p6Pnwgk3IwxESz8uV
Hh/R/PILmLGDDdQQf5HFUK1TVYw+7pa4UoXhXnKsbxEiVOxbBPkwYAbgej4wngazJ9CID6riym0q
5AydAOaWg/peUO153Sh0rG18ukrhu1lEuFHDO3IbXNtITdx6v0redIesu/Vd7p9GF9Er2C0C5GQC
na/KKKeoGLWFsyKC2aJ5MQF3tuaXOcPlZSnxw9bFHCTPJyH4D0yvg38XPVNLqZcmh+dPf5ywOUXf
h2niZXRr7fcJDlf6xyL08mMKj3AuYv7o/+qOFo2BpXKTR4w6Isi0HzfB0zTXIdP1Sg3KMsvYmCXd
PQigX0CElhM1JhYy0xSBZHCMmTmQbEHFeFu4mhsUDySVGeR8lcCHZKoWXhILXc2I1xLgMer2bzxY
EjCCDgZpX4Ma/1cWJxk6z9Tn5WzkzTaCE6BP8Va8xOIBMIZ+Zwx/nMHjA/yXRl5OV2BWPGEka/yM
/Q0DczHv8b7J/ZKEHQajGaoSemE2cGByEwqnQpzG3PI6I8E/wDyO49t1m9kc2YZq0eom3xYQSWLT
UlDL7RwnIRB0swVpelDD7A/NmokY8OMoudqthnAgbIB8fM1+iFjEImW0dMtcF7zh5JvHqYxX7o6T
fsD0yMKx2w30eSWM7nyQoGfoSFmRTQYe17hOYL1cdMkb/Z7PYzOLiWKmJJM066FHJyrCeBN4erZG
A+bTj5zdwxLjIlICv3mo2kvW5/9+egyU3CIYAgUe6h2XP9B/PVi1mxLYMWGbJkdFBbivMtLsBv/4
j2Z6JeuWY6JcufqaHC/MIcP1kUEo1Kt+oXeD5NyXXyFt/eZvSSs3ta55Sl7CUjZIoHA3YrgHcW1c
/vut9KdQ5wK0ycge+zrVo6+hfhLgTcTaKfGgymW3vWW7Gmz30jSMZAbjlJ6I76AU0V577TG0ADuz
noteaAax8LnfnYcBzP9Omcjtx243B+VJ8EJlSeFpTbGoCcTC6ovhtQyEaiIDpIqqwaGN7Zohb5xa
bf70yFPJl53beaCdXH9tLwMi9UBm8I11+PkMuDa+ZD65R9RUuTB4Ps5iEruAHGuX6mzGjBbL7BFI
qlNzFKPa/bsYQMNIPNCWN7n77BDVy4icbDxXt/MkMLj1ScwmYR350rP5bEAiAj5+pCL1XZXUfmq7
Nhf/XhWpDRcH8Vh+6VNLpHAomxNWmAzuoHvmFDmKrJZhsqzV0FWdIM8m55VRjbfr+AVbrsx13Sw5
W5x0QLDEkg4OTg2zMSbq05KdM2ONeI1O6uIlHi97v4SDDgXBwYayHnHKfwCO4yj68/DAEF78vBnn
reIOYsIG/djYovSSSuwIzVh8u52k8lEBOgS9JyP6cRZDh0ZxcSDIS3eVDTnf5C74chWbyxjN7PKc
TzKLZ6vDO9Rjzg7eQtXO7pU6xla4Zp9qRpPdtTWUEFuETDn/6Ge1zTT60PeJyQ+I/RxYn3/2zkT1
83lRAMEESbJoRSnXgQ1GOqqy7rbwtUTFAypeI/BuxXjog0Yt2CNnJeh4VGbOloVSvWZtBJIFklL7
DVWpvtz0CXo0EsUdsWc1c9nsbzdIF3UheIkGc9rGfOTkgpxYaTCNWNc3rQ5wQGO+hEkmi5gRPEgd
P5hiAbpDMIccY9iHKzLjpSkebBaG5y/gXN+c7dAswDgoGPrNmKaFFAZG3Y3VlfF0j74RfvZ+YsGF
W2TytN5d1e8nSrgDLQ9cejHJslvMREzeFkuP4hwNFBmJxPPl4gkDIBtGhmG/n4+qtt/Vle9xudb3
8HeD3aiO4Kuu77B5flTyy32DR6nsB7flEL06SuHsG7+fZ+r/KhqENZY0yEKVMtTcg31GrOf1ugLZ
yMBHDhOgtvP5snU/lE2PF375dXZgllXF86nDch2yG1KvKUcqbNQtJ+4Xgy7mlWgPsPoEaQbM4h+d
Z+LE36OzPSq1P6lEUIxQoDst7mCCqn827PZgRXNsACz1uT0WrAgdrUhTkZ0clUVOoOawQ7N4qYkp
TJM18Fu+7pg0tWzPOgAWSxX4ut2A5ez6K2isDy8ftLB59/vXdBNvm+8Fy/HHuYqFNjQ+QbKa46PD
3ySSZlI3ZtAbs/eougxLydA3KXUkcpOe+mW9c2lXlpZlb5KqK47cjh8x+cNRcaHuzvRw19OmuO5Q
XIBA3hIj62qrUhwrlEpQm1qSSX34vxwBcGGr3bVxQJqMmu+VbHJNhPIhL/Semum22c8a8JwUTDI0
aMj4lbTtacJy+NPtCBEqNQzVGwMH5BooFWH6dg/D48eAtUSLQPiGBJFtzp7fQASQYVbAMPu7Azjh
2RrfQ66njpA90Jc4w26LqqsrdiX1RD481DSomPTaZ26htSiKwAL3mq3Btl26A6/NTCNuZWViGne9
j7iJzqxOcjkk4IJwMfAVvNRBbN4IbSWGZxupdfkGoUmTVIHWywytqgVCu4EZAWA/7evzKoJqhTS1
if5zXB3Z8u6mZfMJxxdVkpdzh/xO4kcDtUrPQFzrjDzXnfgzQsFZCteamo78xLnzSmjo8ocPUsA+
y6b/RmGAV4wBpLSrATbhJBRM3GooTccJxXDifXjQggUme/cDUXmEVniq4PQPBzln09yqyAjVi3PZ
G+UGr2QvEQYxSar5BrYlgB82oLFKKRCrl4nwWU/mbPjTg4AOqQ/BNzPGMw5Nga/41GZXf1TMSU0o
EM+OQsuUSQq+/e0N0obSbs38Q+mGtkKVpRjN5XaA2BF574nR7pCP54Pm/jWKOuFcE8OPs8LS9PIU
ylLMn+pMRUv2c2IsD4bTXohpOQl2tx95czbZRdAOEWXo4sUDpTbW8Sn6pGE8RYDwTm+Fpabr3+7Q
3ADgB819diF2t+J9JaFdYP3VZ5y/NBfufwR084VTMtVrmHrWCLBFywSlX56Qqu035OM78XTbPj7z
N0xQ/NiGFcWKWCYlaFMYsPXS7SOEoAadbHQ9t8MV/q9hX27E2V21+F6U9QbY5vuAr/guSMz40I+0
AbElc6KdBaPtzEW1g101hnRLTNYLj9V0uPpAQn1tG+YRU0Amtmflpl1HO0COz+AE2iK7O3CalZ7p
3RSuaOi3UzQxqXUKNMD9w6PsQDVqH5FAI7fvDicqaPk2ME+Bofx9N8cazmtQ5/+0AqMk0oLl8eSN
xJDUjZElDpn1+gRPDL0dkVsYfINUnvVL7MDu6d+KgkGj4KdnWKMz67/evSINPt8yhAG8OvdSGcRt
3uDoyayk5K9+M43903Do8Itrx4FNXxXY1Yh1yMalHtIviHpQT6S7nVOrkOwQlmgN3mlsWaqKRABU
vM83IBVHqJX5au2dfxGwXFTXPP57Hr9eRJGjaU7rAbjoGrDeo7WPdhuyfqkGsUgO4v3iYKXNvG+m
mznxEh+evaC+sBudY1Ch6XepEteVM0tnr1M8YK2rBcUdb8kZT3En7mO8ZyPfG3PeizdEg9SqIEIh
MqkIW5moBBJSj5CmE8DJ3iBliYVD27reK7YVehMnmBW6qsAK7GjFqEYDksP9BHdW8wf9B6DQSwRL
qKRLx8slbBzrt2DrwrBbXyMdVnr5K1vZWTievdB+WmoBlmBAr0ho0KbaxEACeWXT9u/9upGCt4M+
g8UVfhHcTcf8J4lN7JLqOMoij8Sh4rpmpuZXCjycwgH0GgIvtVUFon8smlKA/QhUz3kF52YSIWC/
BK7JD4cJHVV1pHeRe+CNpdZGZNUetX8Axh20l8sRE/V/LGu8DNG2sTYiI4V7UksW2ZqmO3pBaZZF
A0wWvnHXpM40vXOHm7x2/jFHTxQlP5FA3PNQ62rpOn0XsiRY5ZzxPbPoEtoUBn7YGlyXxmaqhCEW
Tz1VTg4WQvurmwX0BrUABw6nJLardqeMa5FyHdAj7F1y1eaD7+rQrH97i850MldJ3efTVwEpVUuP
Gyb3xSaUPL3+8amp1zNcpRc6hjwck/1IPJ1F3rsyEXHFS/uiykJNKyokDEK2vVXn75gwzNcfmA3/
k+y/terNbXJX/kQUEzUWi2ZlUN2FUt1DgdZI3dlPAm1acTSB4tomGWHubGQg7DFVrOWhVTELIlqV
aLiH7x5P6bj2VT9HO9jwFNfNrdaeroy/lpLvxdp49EFSuqlcFOOtSY1qzS8fsxC/1lMylBfbC8D1
k4mm87Xuv8+tl/A0oFebjCJmV9SXU/O9sEAtV5drH8iIGDZrAXweWZkit4FWvbsRFe/NiYMCsLIZ
LA00JEiVHBXOfD/qCeM47e/lReJa71rcJGsAt/t3x4JUGJjB6+4LXv4tJo3E1zul0ud6sT60QdgM
hAdYiRAHkhwd7+m3pZAJLtnKSK9tGHouMvJG6985O+w1poCtHRtEcTtPLB/HnOjZaOWyzy3cX888
bHa4Yf+kjMsHtEfmUyaPw5xke2dmajwS3+5lHLrAt/3lSQBxhILnVtL4253PQZ2ppzRFQVg8L29a
fFYt+LchxkEVXpmCXZSZQO1Kv3lnexwisBGauqtkdeTI9znNs7Mt5TGJMOCYIrn91Blf+4LKbhgp
OU+HPVDF9dFgMHCa+F4EAVohdKfKL7fH2G+U0ZxZeFuT0Vm+ZndLvyIOclQwvGMgBk903HG4JkpW
tHKKs2Gb+8Ku5QRcCNGewvPlv5nZ4bDCziNbxQlVQkWboieo/s2rgMxSNN6vUk7lN+G6kUVTv9hZ
KivJ+KZT06ZasckdtA2X6641SJQuX6RauChQziTLTyt+J1ZRjiIajm1/ANP6ZsSPZ84OM3cPm19T
MSEtjDRj3e1z7V7D0m6x1/pFwRjUxzGXFsxpgjtj85i3vSKMduxMfNwr+x7fOeYAC4YmBT0CIIAg
QGLg82TZwx2/LK2esF1Jw+3Me43tKILYTsG27b8f/0OcfSvmAwrTlsnWEzYucSOJtdrWKSQmqdbG
+MLlXasoIo6J1Uy58SKcEGFMu/aKyuOHpWJ5ggX5WaYfcxIklKNAJnGSP8zvMDcpy92/bW/tyc26
lPuovBdFcGXxYCuzeUf0enO0Z1THCcqet/B9ekq78wW+/d/HRzG25AdpbauA4s8TJFg5j0W6narD
auHXvg5KVdC5apqzXhB4fy62OIhCHee0BtNIeshDhafhZJTXF1ZVqVb3q3dAuSh2CNAmEX53lTb6
V0HcNlIzDa4/MuPSdJrWziRO1GguBteLeZ7x4viEELKC6+6wczKO/ilJCqyqDG5QlliBLWVratpe
XnrY6AOZz8oMOIV0ji9lx+zRjmFjJ0QgyOPX8o1cE9RWdl+lH0hajryDBWJGmDuWfKmVIib89p+2
Ts86HQnpm6tu2eZFb3dk/SUwKv6dwxTGrS0vEP6mW+THQgC0nbJ9iSMb3wUzeyl/saM1OUmhKpKb
qOIvn7URBjPA3CRueFzh+JJqm2LSFH81buoMzm74UU4SztW0G2zwVpLkyRX1/S6cNwFBqbVqbvFE
gL7DC3jpMQjTn+Zw35UMlrjawO+7Z/ylAW2qO8GYJ9OhTn2T8kYQC+/nxfnd6WPFnlYZEx6WPJ9E
DlR2ZUW4S9VgpdtJ0pWrTyBcWuRG4+9iZS/Yp26K1Gc7NpTXfJ0wMbNThxXAq5wuwkOSmRYm3E0/
s01B4Rd1QYi2x3ksoTJyH/BVspRHt1AeWro5qMlMJIC5Eav0Q8UuSltqaGT+tIfLpF/E95vu4EX6
9jbvBrNqKH9tmCQz5SOw2bRcSrk/4V26L4G1koeJrZ+JU2Oa9oxT2oBzTMEj2BplLURfVIM8nKmf
k800AEJ3RKZnkPL//viyXeUaV2hA//nMexNbU1TDC8jpt0XnwT19tyRLwy6dkJNu9jZDysSafT23
9onrg8FKfpGQq/Leyzdb5uAWwvZ3T6AoqliJG/C7RNM/5tInFgOdn6dGPhlQy9w7+akphxVjzFtX
jHwtBGat8nJabiWEq0HKJz/EdAqKhuUYwlIgfGJbpWlvJlloe2wb59i+mA8gmYv3F6Sc8dAn/Qvu
ZgREAinAab9/0qR/OUOi0Cso0P7+ZpGtQb0GfgK+mrL4Afh6Yt5sxvobY0QQBTlJjK8HNclwhpKE
gNThv2xv1af+j7b80aPUyjjp8w3xID6GClkDak5hNIYGZpgNEhqJMbBm3WKQlHbsGwMYtZKYg7yI
buC0ALfnKyekEN4f1XCk+qmd0zgrd1xLm4b35lgCV/usNOcAyc9SC/RUOqJVXH+iMZLO7phoIWXO
ldhiw6B+ngHXFVBVaFiQF/qtu5ozJXSb6KjaTQpN7Evm6m1JGnuZBj3FPWwN9R5/O5a5az/1ssKB
000pURKlvi6DacJ1X19E78XJG5P0qyO1N1Y52sL8mrgaJ1LLkm1AO/9zE5LsvZSSl/dlRkC66kM5
k762YYEULPXJhM/tlTJjCgvZyXkKqT9j6r6HVJB1JrLLDDsK1etUfBGgJEXGDjry6m+EGaruY3cY
JTjljLCrIqAvvB7joKnVU1hgS37v6MrETziQA4arDbLuGMYnbF/f+75OJnQ4S+aUD2EoxzA2rQ70
j5TASoxDM7H6rO57kV8R1RTkPL+JtbU//ba86VEVDPM3idwkrrNUYNa7NMVaYjN6IL/EH2XrKnBJ
XGewBmEoMkT8yzvR8Na1Krd2MGChvKOLOI1ksiHriNp+BU9vhybCn81UAG4NTOqyx0ufD8p3D8G1
hXSWqEtNKXgda3iZEy32XcgEvIM167tfsLZV3UhZCxVHS4rlf1tGfpet/nYC7nlYITCcXkvkFJrC
1S/Rf0RnUFEfnoVkIZ72lUgqG7ScSIsXnR/ssGD7FHgPQJUMGqWMyVK6M1rkqw3s28b3ziJ+c+Pv
AVzBzZkyPiXpZUQjICv1vH/pQh4/gVl61YJYlex/aYNj+5f0v3q7nEFcb4QOJXIFzO3sJHQnIUcm
5+k4bUngMfRu/Tx85a2l5JhVfIyze32p+2p4J+vGBM46Z6DXL1ZdWcddCIQwc1gPItaphlMLe0Si
iICj3wDXZK44xqNDwW9GAROYljiF5SpxhB1Q4z4bm12k0dYoEfuaDJA8AN3EdmSFvW8iwnSChbx+
ATU6LKFq52Tvd8xI2u5L/zGtKKc62t6H1QN8O7Ht8Q4UO3C2vBWVovwOeXzXqPD6/4tV9gwL4JWz
NzolYKrhWMJlit8r2edVaUdfE0g7eE8ckoBUsHcY+AAhjcAjE9yfFGVj5FmqiMR8rj9PQacONPqO
/9cqLFgEf7+/Hp7/+x1wBze5Cb5n96h6l+/jl9djXv5+nZTG/SzqIb2YHipVjEHe1yCv+mMFmLEN
hdum81+KslKSfRy4O9puaayaoUMLv6/FxPQi6iA1spbdIW8Y7XoZn24GSKrctHcsitQ/1IompHoS
hIPclR08FeBobYrQE07huuO6c/NeuDyfmTNuWzhfKwNaHOB95VaWwpFyGn9ItYSVJWgplHWBMbl2
LFRkcCHPGBHoxPKX7nBZaQTYTZDPOTlRoXXcBmOKJLObnvRMRxPaVaFM9WMtqLYN5KBxIREHEM82
w9IKOMNs+AVhXB+R3YIpKnOD4h3Sy6ZPcI30ZZOSMS4K5gj8mLQqvW+DsT12U9MEE0ouvMyYZBTe
F2uqC5LWMaEsR6E+zCUZT7XTYWSpccWMxp/FsEu5onS2KgoBZl+dWvuQE8pWV7JyH/9jx6nCQVDK
39zTWqU2kqGsjb2YlUY+ROBkRvs4/R4qlqQg/PXfoeQcDS4Pmoi2lL1FJyZKfIVFpw9Ml0rCIA7W
okcJWodc2VkZPobXVmebROAGs/96Y8lDLNNdrPW+fQjLOu+8HcG6er0gPZ1n8INpIQ1CxmCN/3R7
KymOK8P+vzuat11XQ8weYdWGaq6gBtjCs+Og7fzvNJwJdWaWc3potBV7baoxkr0b82m470ss3yul
cPohW/YkxhCDHS85zumcjiiz21PuPfAR1QvtqZdz1xmTDa/cF2lQQjd4DKflStqnJ4m562sBxlu3
2C7zhX3wnE+NTE8NZSszS/c+4htbCBek5O52wcMQmD40PFRNGABZneY+Kot4NWVv65molX5mhjoe
j9Djz1T7BY2gB37P6hUNFp7EYdXoQ7dk2cTWbzFTSJdZ0jFbfdatSqowUJ1NToYuZxC8+t7aygGn
ACBq1tDYgjbyC8p2Oh7RTxVPd342PBCAymCAA0Q+PDXOiMrAOCQsQGiHjtg9iqkFEGvF+B7sB73I
8jSfNLug63tuNkMlMl7m2CPzq6g2srBGhzf/QQB6Xvnr0HXByns3k4VfBJxykKSQmUez4cw3J4TF
Vxnx0M2LZS930Z6nz/lh1LddiHmeXhpuNe/9GeOEltnyBfTUbtLJSLQ2TjYDGPr9GWLqZCQLycd1
C9w+nzFxf3UIvpBibgA9mM6twZFmL+vJU1VSmQ99UdIViOssPuwSvfU3AbFkN0zPW8xVCB8DLjKW
hhr7w46T0l9o6RzhS07lF/GpRRu4sGdtCldHLTvVcXxUNVKU6WKvdM7yKEnwCBoO6xioywveO6fN
ZuzbGyU0+ZkXwbkKZL7bMGsMwoXv29eG4PESbUDxewyllRx/Adm3/jif7zLpZC9hT0lKcb939eoc
ByNsy51yeoR1WInjHw8VNVf2L1uM1p699NIMMSCjNwz1ffY1gO/+Mx+XV9Bk0PDRsTI7XUbO1xun
c+RlQN/ZgQetKbtGCd33bJzX1T0CLKIKJt6+z4DQmPEBHYaTV6uaPtvYBDu1EpcytUrJkbobynsx
oxDJ5FEvyYePBdL7H1NfQfrwMCKfwgU4DbgDtLwMQgb32TrRpYyNsvyc+4bRC7Vu619el8H9V22k
fw2kmeANb8o87ZO+HkFWil7jorr93yfXZD/wAw+2mBU5ulTLK9beZ7E9pRh6yuAzbmQ7gHYbz/Zk
hqYaCWYgIkVBTZg22f1bAbJ4X/f1+ep/Dk5qDZPXvi0C5Bl9lxJaVDKWi/wpqy94DOnvoNeA7RMY
4PJdL24JtKbSFOgzH6ER2D88FpHQ/eA8fwE0lEWNlHt9jf5gdF0TpqWWaAg3Hj+HpNrTXb1aAK2F
zjTwx8bnw876cdrHVqiKmDAXJNeYZEepEzfCVYFvFRs0zG10k+RkCMw0w5AKRGzsjqUK/tB6I1Cz
qxvLsGoaGDm3Hk8bkUkDhGtK6eVveb+tyopXMgR/lmT/H3666wS/yi7Fhgg4ZSNScHGoXFpmUj5k
IvTRk6gkraFOCzbUq3h2mJxHO7VgrG9GDJEHIU8J/jlT2pGFpRjmpduvn+eE04TledmXaoeIJTeX
Lyc4pHdcNH6qW2h+/T/yqIGz+6Q5FzzU0xsxHL91FaOummRXpBuoZD1Gw/rEaMc2XPiSPj62f4mU
xnzSzUxI5SwOxDm4sOkBI1+HPH/ddFofVrEdBC2DaZgL0lcqdekqdp8MuATezPj3UICpyPCUwbBZ
u1pTjhkTvLbsEpjLHgxIdXhiov73/RS+8RgcUUN8RjrlzC++fKDtPuEaVfefvnM8AtQ9tg45dnlk
Lj+Irm0UhuPgKJbJa9csUgR1Xxdkp1QrRI0ZVPLPNt7GvhGrimdZwGHhCZTIwy6xt6E6P9ANU9HB
y/RRI4fEOlonrKQP0DTQBxuTb5c1JkpqiLYZ+Y+S2n3h664R+pVkktjPxX8iMuLeWHxCewgGsFgE
tXCrpq2Zwm0C2fcopKLsLes1q602tsFZfNfIAJlY0yfGrhtRjVe4Fg9skLTpB5qKCfW8iq9QR2zl
jaGqH/B4IEIH7HJOD+2yHm5RLU6I9eyXGpyxvUb0UuHzDXaAiy4cA/97pkFiQXaz/mIqo6JXWhPr
XYY220RBojvsIvnr6Z0vugH311BcQ8/jntNZQ8E4qtPEbp5K04qVck3ZwkYJYRPxJemGKzpz8Zq4
yHTMijQL5jVrCmzNd8lOh8jqp0FP3d7mA/h+UHEXgagZJIH4xDntpx4YILvftvw1tZ1PK3fgt3zV
THIp4qQCwj1PSvUigI/0AhAJQk+YNkAGsfoZmtYl83xnmoj9rQ9JyI2LYBN5Rdo/y6fOnwOvKvP/
NobBIb2aE2y3DSczBFWGVeWS02AQhETxwnhjwmafX18FzZvzgD38aUg5Lee84NzFawkVpWZwKJw/
mpEy3xy6tEWuu6afGCX8gPbxDh5OTXLFQwoe0RSl35Df5jhnDNfO+4T0BLW/qvGGep+YOLp/Okep
dAIzL6G167EHCeRUpmNxvVmGRBsLgQNJcUedUM0qrz2daxVYyQQpyRJCwj4v0Rt4FkQXi6kGC/Re
ElBmZmyOa5VGeGwH0JfwhA4EX3T8hW/p+LOU7mA1CAcDo/dyUg/dsytXBZwKhKo2S8ERRvX+CTze
Ai+/rmK2NTGyZwN4mcs3euVHO1x0JagL8E0mkQX8tiyPWoze6BCkDOaWysxh6rwy6HNGOeJSe8M/
WoE5hhxu/tMYIbhMTUvr0Lldu1/C7rvUuvTfOhN779b5d9JaSYTYAhP69pQpVCDFhI5PKRZowFNb
2htwh+RSRl67cb/zoT18cy1PnC0midh8JwxRoluMmrC1TBXI8gXKOH2nObZRS7iAMSZ7KxJMAYvg
0FsZ3wOuHPXal3u4V86s3z5VkrFqLIE9JeKgu1CnuRv55RlVuRldNkWFVQUEvAVz2Pr17K8yI/1P
9HuSPrS8VVgCzIz8PGN7CYfZZTYIMpMfKdNdLiScuqItCy91lf2Yyvdyys2F6q7OZIEryurV9X/p
aDLxTU7Uctv3gifj9I8X641M3rwpkjSmao+VL9FVKCcfLMCGBQlUyBhabxNyB7jmGU4X7XHB36Qi
NItf9gvVI+4s+TqpjHjF/po8CdC8c+FqQWnBr/54e5I2V7MM4oGorVx+9Q88NVE5Rp9FOoqwO0jM
9Nudyz6ti5irqab9bxV1FDgafwpwRNS2H3YS/LcH2VzzSMGlTwKXcFd+DJ+okQgQ/Q+v9RdrvtUl
o3cwepN3st8MJ8Nd+JpSTf9bmgVjNd4gIiU6vZw2Kh8w8vMSocvOhDuzcv0XxmBly0dQ5OtZJUNv
jGL9FYoBTtYWGECIJzz7Bbi4QRKWnL8UzbTG4GpQE0n3vb0ho+DJPF5IAEYYXi2/0dOEjdo2cW2d
xM4+ZhseCf77j6NjwrI5I1StA8wMNQwBJEbUevin7FikbakGK8jQKul7yBAJb8MJGpBi25sYbOBA
y0GE70M45w1MgShm1Dm0km1eQyXHvl+dcwAgb7WIVQGXXPpWasHkgCWqAWpWYj60cFSCsByOcvTF
Xi7TBCBH5acehVcYeC/tezxABwKDGxS5zTMabHNnBwchdeNHMxFoZLxL1S6gnWL4AffpbnwoIZsh
sSLDh3LHpf5w8NJ6tVVREh0tEBKq1w6aYbBkGKyTTH/LHY5ZPteFJYOByJylhsPVwXUvWzoz+24J
+X5hBjghzzG/+zE3lDssWxmrRi9df5KnCXgLcHk6xTAVcngn4UnojMBNEFDvkb3YT/ZJfk86hxvm
1xVysZ1Zw9GNjgPj6id7bKzz6uhhGyOqFlSgNPesDNVFIEnWB0C4NzzgnFg5Pg78mrUXJWNwpVnf
L3ho8H/N8QFANIjd0LGK3fucriZAsIq+dCoVbksqFCjBqTWq2U77MFeNiiB9QMgL5zvkH9BSbX2o
ScvXT6NGdZ6byPFJjHQAs3knFe4gwKWstbjqL3OIe/FzcuXASboz3uL3NCydzwYCVsm8g7Tujh9m
O4lxTIWRz9rVP8p3mRfHBgbFmUFGKEDMb+8lLsL8F6JtmD7o0G71ewE4HcwkJYGztwhmvhNWN1+E
JidPjmlBxv8azBQpGdC/zcY8kxTqcen/ew87OR1pYsLIcgTn5AmJwlZ/MVrndXUgc5u+tjv+qSLO
+n8iaj28fmQNFN+kzlKLjsNYMhIs68d/uuLJz8DDBhAVmiuWwd7jUtlYWDg7WayMRsMhAmmt5jRd
8mIubWwmkIOKse2PRPKGQkteB6WuqttT/WvR76t7RfrWHQugn3yUxTjpWRsgfQPQEtTr3n1MdXJq
vjB2SKAWC5GsairThjMXaTAC9u80K5G3fKlVpAPAV0yfS1Q3pdaSnVbGcej+S5QVH80Gsc1mJ0U5
yTI9vyeVFhsC5MB8ZfN7Lpi8yAhWYJMMa5QjV1BXPnzkJ07j4aefbaAgI+0gUfLTz/ngtsQqCtLb
XJ1uhm82kwogi7L2nmHFS7u+sfuj9gBiKgAUuH9A4ZfWU1ZeuEDvd9fibavAA4Cqg75nFIsrkF4g
vSVd19dvihkFCfdph+YNFRK6Eyhla65Y5zkB4EWQ3kZy+AXby0Rdy9jna+L3/tgyGuvPoNSvwo3O
AJEIoCjRHCJaektEaRmMLBudScTxA1ozS51bZ0YBe3qT9dKDBtWEAI8y3Nn4PuCp+mPNrQW5mWK+
AHh/c6WEdILMqJ9fGVN6yO6aDWNcclWm94YQBlTBRpmRv/0eUg9rZrSTCWENwoSxqmhFvTuXj9nY
AqEL+h7S5O2DUKiUgvO22yX9YQHMTpe4S/iluuzkDsiZLrT6oTQlrDmo9CWnp1LPvR/NsXhtJUpi
2g8lcNQGULzFWGUd74Gu6mRTCcjcsl3qwXICfs1qyX6Ud4yOhE+6aQAo8nQSEA+dGDOffAWSe44M
+lcSmC2GMmKaP2+e6dk9IZQhWD1dkvNQBTI1b+YsDIhmUaeiRlq4O1L2REABDe5EatMdXDdM9Ubv
HFdosYCk39T+0iu+7FPLmLj7zxI/hcXpifQwWYZeDa5xz6cXZrR5FJT9WkNzloIFUQWDd1B16Lzn
hyyKuoOP8GLNzsz9yCPS0+blM2tgF0ByTAUoSBZBcinFQdORgYwqglxvzhn8AkZPYR1YmASnRi5y
z8EGQI1NrosL6EsMdGgQA3EEHYUqAGd5ch0oI583QdngULht513OQ7/ORg6UyTjSxLEuOSS7mY4B
iZAswcCNXPbuOBPUB1zBx3NjWb0k3nwaB+iLGto0bva3zMvH7cysZLRXDmaW1PQF723RiRN2A6zm
MMbE3Aw4Q52kmPILcF5UM/WTvw6dsR6utJi1rV08z5gtzwsdOiFc8X06ZQTMbq2Tq1EsGwGX1TyC
7HR+XLMM9Vz8dJ952AiHy8Ei/bLPkem9sZIF1yrkbsG/CoBWKCGvc82x85aNG5nmCnEzdDlF/ZQ9
SOFFzk3uToZdXYyofNF1DGkXObrvIIcAPmGbrW3TPLiRRmbpSKvOkbjTEOmQe4NpvTEfgrG3uIbD
3MLG9mNYroQT2+SnVTTALdCjS5yQEU0hy/5hmsoGCoM/zQXtXbKxCfSPEJftdhU+ogKnZi7cPRDC
eXH4FQnz3vbBebxX4EKYY9t6QU7NgrwPypyyzWeFi1SZ4NgIfOUe1QB/H6dE0VlP9LITEG+R2nsw
N0iRyZLrKH3p2fUSC6AJ91z2TGz3h+HuvAq9ZHxjqY8Js+ElbaPdKgaYYIb4ajV05bODBI2n+w8D
hXeV0/HB3gAAhpFpfPRCAuM0brAZZ5s5Fnc1tlQ4YkmvTT3WKcNpJPe/2AXdRFV/3BKraArjqa9Y
ogIdChVLvWsRu2luQnZsqedAojQH8Ey54g8PlFwA8UxEXaF8kULMw4JjuSOtr9BG/hM9QYe6unHo
qlHf9eu5G9CDUzds9020EwzD2M/WUqscawROrKWFIX8i0OnPt2rwyZOGUtJ90JW86xXyDBm0cDvS
5/pGshxW/tE8oxVSmW5ZRtOS9Mtm99mrgHIyXT0EN8XFTjg6FnJuLtVg8lkkqxhzpDm7eoy42GQz
AIJaGrlhZl894/u6AQGJNptxLc+1fEwfxkuw/NFRniszcnD3R0WWIb61uXpHbqRkwXPD7xo/oZQm
0SeitxsTbKjo8+xr6MQ/HTwyOTsAR0ogUI1rjBjMJ6ipjHDRAF/dm/pmKNRd5lgcgZkd7jtSUFdX
7pCeKW+Uc7ieQrGB6boLH1BOuek+d8+kwmGClJmonHRXIo33DywohwnDj6BEsiUrBPV3sxZcwByp
lrOHwwBofG10lEeu/ESQdzb2vD0E86++kqFU9Jqr5hU/ryAEKlcMBw4KgG0EBTiZy5uqkxUFubCL
TIII7cqMCjUfFI4HUAO79u659RH/lq/hI77odAvVgj/664/h40D56bn1ogQdz5FSB2/qpzgU/bYL
eHt3y0uVXQj/vfA5P9VnqcimuK9mlV/7B7AGTM4KWXtvzpOhu0YbveToiCMKn6Ztv8il7kWYyrAq
xkRhDD/uNnJvy1nqMT3D9Ucr/CRNS3LJ+E/gSfhbRQM5xO1rDRQEv3lxoFNm6mhmcH9xG9n2ZAOx
Fxn4+tEthZZt3g1ZJTiAg5WYGqwVV+bGo6776JIDgDRUzLIzJ9hcJ3myLgBUcWOKRZN3Wfl+SR06
rYblwb/bu5aCIs9PL/017iBqz47rHEUWW4u3D5yBwe9JcxOa9mtzr/qpH/zCGIaPALlUunqQoF1b
/UrjxWw+Ay4X3e5xmt8KB7su3JpCebdevun39kM0v4SQ5ZNHVr/0k9OPQ79uAJri6cfrfb0saU0r
I7zyZSjuA0APKTbCw5KkHomdZjNgd0GTg3fRgzRsUKaxY5vhTfEDD6T30wmSZzEdmwueHQn6jkwm
jmp1aGq0LvQNmv1hDwNTt+aUmoOXMLY/KUdAnN0Hw1BuAwxrQSlweNoCM+E4dopDvVvLPMxtX3Lm
H5KueURfM39Bpwg/DObMt1BCXhV3pCjuIocj33o0pOu9imYdYa5tOnsyqQUPmVn0WVdqIMensI9n
CszRtdGF9Idi7rkfbHGdlsKsEwWPXD/znvNPe1hodHOp6/zVdi07BsC6ez3qXqmGCIueGcH9Teba
0Vn02WXzeFopH4/O2HfSt53K1C4IyAj7INJ4Cy43fPF8OU6gCogeADfn0ePs3NWYrPFMdXpqcrmP
ccb1R/SUkm+fAvawIv77L8Ty7vt+bWQAGBERudV6Ju+F7umlBJDTw/sr9yCaZ/u4ouARVtDElDGI
iSXkYAICQSwncJTuPJaQBqJMi0mN/vgCZKX957rHmHqp+yVEI9Fvn4ojGpDvBJxKtyfU7v8Irb2T
ef/tDTcqc0hIA6Kyi7paelHgkbaiDVjWo/uOhJEEUT4km2VmF7PxESo2tZiJ1WRj67RxScrSuAIS
E7FbgKwF38ZAqF0qALLHW2SqhpGrarLCyj/hk3oStm+C0vv3AQBp2tLKpCAAb9GQNegsBPDUNRnS
x/cX/xbKv/inMPE9Zw==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
