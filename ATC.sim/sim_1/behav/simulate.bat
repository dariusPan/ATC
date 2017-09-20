@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xsim test_traffic_behav -key {Behavioral:sim_1:Functional:test_traffic} -tclbatch test_traffic.tcl -view C:/Users/Darius/Desktop/Y4S1/EE4218/ATC/test_act_traffic_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
