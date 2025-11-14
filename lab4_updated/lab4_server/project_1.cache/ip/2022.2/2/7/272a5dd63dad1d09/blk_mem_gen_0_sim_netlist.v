// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Fri Oct 31 20:37:24 2025
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [9:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [15:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [15:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [0:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [9:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [15:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [15:0]doutb;

  wire [9:0]addra;
  wire [9:0]addrb;
  wire clka;
  wire clkb;
  wire [15:0]dina;
  wire [15:0]dinb;
  wire [15:0]douta;
  wire [15:0]doutb;
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
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "10" *) 
  (* C_ADDRB_WIDTH = "10" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.0361 mW" *) 
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
  (* C_READ_DEPTH_A = "1024" *) 
  (* C_READ_DEPTH_B = "1024" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
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
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[9:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[9:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20336)
`pragma protect data_block
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
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
