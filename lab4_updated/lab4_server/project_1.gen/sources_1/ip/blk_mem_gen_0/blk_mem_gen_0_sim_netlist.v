// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Fri Oct 31 20:37:24 2025
// Host        : sec-academic-1.int.seas.harvard.edu running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/kevinkim/cs1410_lab/lab4_STAFF/lab4/lab4_server/project_1.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a75tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
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
  blk_mem_gen_0_blk_mem_gen_v8_4_5 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20304)
`pragma protect data_block
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
j2EL