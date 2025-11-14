// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Fri Oct 31 20:40:19 2025
// Host        : sec-academic-1.int.seas.harvard.edu running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/kevinkim/cs1410_lab/lab4_STAFF/lab4/lab4_server/project_1.gen/sources_1/ip/blk_mem_gen_0_1/blk_mem_gen_0_sim_netlist.v
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 29040)
`pragma protect data_block
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
D8DEO3pyJ3TPmORay6gv1P8NVVZTvpdZYwWm
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
