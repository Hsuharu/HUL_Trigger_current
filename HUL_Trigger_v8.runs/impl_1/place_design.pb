
�
�No debug cores found in the current design.
Before running the implement_debug_core command, either use the Set Up Debug wizard (GUI mode)
or use the create_debug_core and connect_debug_core Tcl commands to insert debug cores into the design.
154*	chipscopeZ16-241h px� 
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2#
xc7k160t-fbg6762default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2#
xc7k160t-fbg6762default:defaultZ17-349h px� 
y
Command: %s
53*	vivadotcl2H
4report_drc (run_mandatory_drcs) for: incr_eco_checks2default:defaultZ4-113h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
q
%s completed successfully
29*	vivadotcl23
report_drc (run_mandatory_drcs)2default:defaultZ4-42h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px� 
w
Command: %s
53*	vivadotcl2F
2report_drc (run_mandatory_drcs) for: placer_checks2default:defaultZ4-113h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
�
YReport rule limit reached: REQP-1840 rule limit reached: 20 violations have been found.%s*DRC29
 !DRC|DRC System|Rule limit reached2default:default8ZCHECK-3h px� 
�	
�RAMB36 async control check: The RAMB36E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "|
2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM	2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM2default:default2default:default2�
 "�
Bu_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[10]Bu_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[10]2default:default2default:default2�
 "p
,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[7],u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[7]2default:default2default:default2�
 "n
+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_7	+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_72default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB36E12default:default8Z	REQP-1839h px� 
�	
�RAMB36 async control check: The RAMB36E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "|
2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM	2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM2default:default2default:default2�
 "�
Bu_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[11]Bu_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[11]2default:default2default:default2�
 "p
,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[8],u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[8]2default:default2default:default2�
 "n
+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_8	+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_82default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB36E12default:default8Z	REQP-1839h px� 
�	
�RAMB36 async control check: The RAMB36E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "|
2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM	2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM2default:default2default:default2�
 "�
Bu_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[12]Bu_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[12]2default:default2default:default2�
 "p
,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[9],u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[9]2default:default2default:default2�
 "n
+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_9	+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_92default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB36E12default:default8Z	REQP-1839h px� 
�	
�RAMB36 async control check: The RAMB36E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "|
2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM	2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM2default:default2default:default2�
 "�
Bu_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[13]Bu_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[13]2default:default2default:default2�
 "r
-u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[10]-u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[10]2default:default2default:default2�
 "p
,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_10	,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_102default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB36E12default:default8Z	REQP-1839h px� 
�	
�RAMB36 async control check: The RAMB36E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "|
2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM	2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM2default:default2default:default2�
 "�
Bu_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[14]Bu_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[14]2default:default2default:default2�
 "r
-u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[11]-u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[11]2default:default2default:default2�
 "p
,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_11	,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_112default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB36E12default:default8Z	REQP-1839h px� 
�	
�RAMB36 async control check: The RAMB36E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "|
2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM	2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM2default:default2default:default2�
 "�
Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[3]Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[3]2default:default2default:default2�
 "p
,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[0],u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[0]2default:default2default:default2�
 "n
+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_0	+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_02default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB36E12default:default8Z	REQP-1839h px� 
�	
�RAMB36 async control check: The RAMB36E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "|
2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM	2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM2default:default2default:default2�
 "�
Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[4]Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[4]2default:default2default:default2�
 "p
,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[1],u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[1]2default:default2default:default2�
 "n
+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_1	+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_12default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB36E12default:default8Z	REQP-1839h px� 
�	
�RAMB36 async control check: The RAMB36E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "|
2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM	2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM2default:default2default:default2�
 "�
Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[5]Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[5]2default:default2default:default2�
 "p
,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[2],u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[2]2default:default2default:default2�
 "n
+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_2	+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_22default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB36E12default:default8Z	REQP-1839h px� 
�	
�RAMB36 async control check: The RAMB36E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "|
2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM	2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM2default:default2default:default2�
 "�
Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[6]Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[6]2default:default2default:default2�
 "p
,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[3],u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[3]2default:default2default:default2�
 "n
+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_3	+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_32default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB36E12default:default8Z	REQP-1839h px� 
�	
�RAMB36 async control check: The RAMB36E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "|
2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM	2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM2default:default2default:default2�
 "�
Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[7]Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[7]2default:default2default:default2�
 "p
,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[4],u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[4]2default:default2default:default2�
 "n
+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_4	+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_42default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB36E12default:default8Z	REQP-1839h px� 
�	
�RAMB36 async control check: The RAMB36E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "|
2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM	2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM2default:default2default:default2�
 "�
Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[8]Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[8]2default:default2default:default2�
 "p
,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[5],u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[5]2default:default2default:default2�
 "n
+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_5	+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_52default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB36E12default:default8Z	REQP-1839h px� 
�	
�RAMB36 async control check: The RAMB36E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "|
2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM	2u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM2default:default2default:default2�
 "�
Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[9]Au_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/RX_BUF/Mram_RAM/ADDRBWRADDR[9]2default:default2default:default2�
 "p
,u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[6],u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr[6]2default:default2default:default2�
 "n
+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_6	+u_SiTCP_Inst/SiTCP/GMII/GMII_RXBUF/rdAddr_62default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB36E12default:default8Z	REQP-1839h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
Au_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[10]Au_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[10]2default:default2default:default2�
 "v
/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[7]/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[7]2default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_7	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_72default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
Au_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[11]Au_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[11]2default:default2default:default2�
 "v
/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[8]/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[8]2default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_8	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_82default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
Au_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[12]Au_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[12]2default:default2default:default2�
 "v
/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[9]/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[9]2default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_9	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_92default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
Au_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[13]Au_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[13]2default:default2default:default2�
 "x
0u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[10]0u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[10]2default:default2default:default2�
 "v
/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_10	/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_102default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[3]@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[3]2default:default2default:default2�
 "v
/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[0]/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[0]2default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_0	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_02default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[4]@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[4]2default:default2default:default2�
 "v
/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[1]/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[1]2default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_1	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_12default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[5]@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[5]2default:default2default:default2�
 "v
/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[2]/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[2]2default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_2	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_22default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[6]@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[6]2default:default2default:default2�
 "v
/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[3]/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[3]2default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_3	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_32default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[7]@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[7]2default:default2default:default2�
 "v
/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[4]/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[4]2default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_4	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_42default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[8]@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[8]2default:default2default:default2�
 "v
/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[5]/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[5]2default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_5	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_52default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[9]@u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ADDRBWRADDR[9]2default:default2default:default2�
 "v
/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[6]/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[6]2default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_6	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_62default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN2default:default2default:default2�
 "�
Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_1Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_12default:default2default:default2�
 "v
/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_10	/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_102default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN2default:default2default:default2�
 "�
Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_1Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_12default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_3	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_32default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN2default:default2default:default2�
 "�
Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_1Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_12default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_4	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_42default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN2default:default2default:default2�
 "�
Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_1Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_12default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_5	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_52default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN2default:default2default:default2�
 "�
Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_1Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_12default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_6	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_62default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN2default:default2default:default2�
 "�
Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_1Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_12default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_7	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_72default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN2default:default2default:default2�
 "�
Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_1Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_12default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_8	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_82default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM2default:default2default:default2�
 "�
9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN9u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM/ENBWREN2default:default2default:default2�
 "�
Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_1Lu_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK0/Mram_RAM_ENBWREN_cooolgate_en_sig_12default:default2default:default2�
 "t
.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_9	.u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_92default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�	
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "z
1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK1/Mram_RAM	1u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK1/Mram_RAM2default:default2default:default2�
 "�
Au_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK1/Mram_RAM/ADDRBWRADDR[13]Au_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/BANK1/Mram_RAM/ADDRBWRADDR[13]2default:default2default:default2�
 "x
0u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[10]0u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr[10]2default:default2default:default2�
 "v
/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_10	/u_SiTCP_Inst/SiTCP/GMII/GMII_TXBUF/memRdAddr_102default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
q
%s completed successfully
29*	vivadotcl23
report_drc (run_mandatory_drcs)2default:defaultZ4-42h px� 
c
DRC finished with %s
79*	vivadotcl2)
0 Errors, 33 Warnings2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px� 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
22default:defaultZ30-611h px� 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
1.1 2default:default29
%Placer Initialization Netlist Sorting2default:defaultZ18-101h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.1732default:default2
1390.9302default:default2
0.0002default:defaultZ17-268h px� 
Z
EPhase 1.1 Placer Initialization Netlist Sorting | Checksum: 2dd451a1
*commonh px� 
�

%s
*constraints2s
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.183 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0402default:default2
1390.9302default:default2
0.0002default:defaultZ17-268h px� 
�

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
h
SPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 1021e2855
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:07 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px� 
P
;Phase 1.3 Build Placer Netlist Model | Checksum: 15add546e
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:15 ; elapsed = 00:00:12 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px� 
M
8Phase 1.4 Constrain Clocks/Macros | Checksum: 15add546e
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:15 ; elapsed = 00:00:12 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
I
4Phase 1 Placer Initialization | Checksum: 15add546e
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:15 ; elapsed = 00:00:12 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px� 
D
/Phase 2 Global Placement | Checksum: 1b9eb53fa
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:40 ; elapsed = 00:00:26 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px� 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px� 
P
;Phase 3.1 Commit Multi Column Macros | Checksum: 1b9eb53fa
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:40 ; elapsed = 00:00:26 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px� 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 1f034f5b4
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:43 ; elapsed = 00:00:28 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px� 
L
7Phase 3.3 Area Swap Optimization | Checksum: 1f708a0c7
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:44 ; elapsed = 00:00:28 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
�

Phase %s%s
101*constraints2
3.4 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.4 Pipeline Register Optimization | Checksum: 22b547d5d
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:44 ; elapsed = 00:00:28 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
x

Phase %s%s
101*constraints2
3.5 2default:default2)
Timing Path Optimizer2default:defaultZ18-101h px� 
K
6Phase 3.5 Timing Path Optimizer | Checksum: 23ef2137f
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:45 ; elapsed = 00:00:29 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
t

Phase %s%s
101*constraints2
3.6 2default:default2%
Fast Optimization2default:defaultZ18-101h px� 
G
2Phase 3.6 Fast Optimization | Checksum: 1cca9ade0
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:46 ; elapsed = 00:00:30 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 


Phase %s%s
101*constraints2
3.7 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px� 
R
=Phase 3.7 Small Shape Detail Placement | Checksum: 25e24fe88
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:51 ; elapsed = 00:00:36 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
u

Phase %s%s
101*constraints2
3.8 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px� 
H
3Phase 3.8 Re-assign LUT pins | Checksum: 2640b02e8
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:52 ; elapsed = 00:00:37 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
�

Phase %s%s
101*constraints2
3.9 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.9 Pipeline Register Optimization | Checksum: 2640b02e8
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:52 ; elapsed = 00:00:37 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
u

Phase %s%s
101*constraints2
3.10 2default:default2%
Fast Optimization2default:defaultZ18-101h px� 
H
3Phase 3.10 Fast Optimization | Checksum: 1ca1db834
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:55 ; elapsed = 00:00:39 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
D
/Phase 3 Detail Placement | Checksum: 1ca1db834
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:55 ; elapsed = 00:00:39 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
�

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px� 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�

Phase %s%s
101*constraints2
4.1.1 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px� 
U
@Post Placement Optimization Initialization | Checksum: 9f1d2c34
*commonh px� 
u

Phase %s%s
101*constraints2
4.1.1.1 2default:default2"
BUFG Insertion2default:defaultZ18-101h px� 
�
EMultithreading enabled for phys_opt_design using a maximum of %s CPUs380*physynth2
22default:defaultZ32-721h px� 
�
�BUFG insertion identified %s candidate nets, %s success, %s skipped for placement/routing, %s skipped for timing, %s skipped for netlist change reason.36*	placeflow2
02default:default2
02default:default2
02default:default2
02default:default2
02default:defaultZ46-41h px� 
G
2Phase 4.1.1.1 BUFG Insertion | Checksum: 9f1d2c34
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:01 ; elapsed = 00:00:43 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
�
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
0.0692default:defaultZ30-746h px� 
S
>Phase 4.1.1 Post Placement Optimization | Checksum: 10e761c7f
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:37 ; elapsed = 00:01:23 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
N
9Phase 4.1 Post Commit Optimization | Checksum: 10e761c7f
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:37 ; elapsed = 00:01:23 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px� 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 10e761c7f
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:37 ; elapsed = 00:01:24 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px� 
F
1Phase 4.3 Placer Reporting | Checksum: 10e761c7f
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:37 ; elapsed = 00:01:24 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
z

Phase %s%s
101*constraints2
4.4 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px� 
M
8Phase 4.4 Final Placement Cleanup | Checksum: 17450deb2
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:38 ; elapsed = 00:01:24 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
\
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 17450deb2
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:38 ; elapsed = 00:01:24 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
>
)Ending Placer Task | Checksum: 12765a4cd
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:38 ; elapsed = 00:01:24 . Memory (MB): peak = 1390.930 ; gain = 0.0002default:defaulth px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
522default:default2
352default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
place_design: 2default:default2
00:01:442default:default2
00:01:272default:default2
1390.9302default:default2
0.0002default:defaultZ17-268h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:082default:default2
00:00:032default:default2
1390.9302default:default2
0.0002default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2�
xC:/Users/suharu/Desktop/FPGA/HUL_Trigger_IOM1234_extraline/HUL_Trigger_IOM1234_extraline.runs/impl_1/toplevel_placed.dcp2default:defaultZ17-1381h px� 
�
kreport_io: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.778 . Memory (MB): peak = 1390.930 ; gain = 0.000
*commonh px� 
�
treport_utilization: Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.365 . Memory (MB): peak = 1390.930 ; gain = 0.000
*commonh px� 
�
ureport_control_sets: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.072 . Memory (MB): peak = 1390.930 ; gain = 0.000
*commonh px� 


End Record