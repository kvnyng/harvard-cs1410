// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Nov  3 18:48:36 2025
// Host        : sec-academic-1.int.seas.harvard.edu running 64-bit unknown
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a75tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [10:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [0:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [10:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;

  wire [10:0]addra;
  wire [10:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]dinb;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire [0:0]web;
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
  wire [10:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [10:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "11" *) 
  (* C_ADDRB_WIDTH = "11" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     10.698 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
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
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "1536" *) 
  (* C_WRITE_DEPTH_B = "1536" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[10:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[10:0]),
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
        .s_axi_wstrb(1'b0),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 48528)
`pragma protect data_block
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
YkwVeRzypAs12KD/xz3r0FJnuKck
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
