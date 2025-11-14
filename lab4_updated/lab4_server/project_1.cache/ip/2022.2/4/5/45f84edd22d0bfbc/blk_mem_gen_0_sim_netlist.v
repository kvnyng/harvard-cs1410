// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Fri Oct 31 20:40:19 2025
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [0:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [9:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;

  wire [9:0]addra;
  wire [9:0]addrb;
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
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
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
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.9043 mW" *) 
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
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 29072)
`pragma protect data_block
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
dz4=
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
