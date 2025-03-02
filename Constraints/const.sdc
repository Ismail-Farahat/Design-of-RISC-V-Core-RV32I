
#############################################################
####################### Paramaters ##########################
#############################################################
set clk_period 40;
set setup_uncertainty 1
set hold_uncertainty 0.1
set timing_budget_io 0.4;
#calculate input and output delays
set input_delay [expr $clk_period*$timing_budget_io]
set output_delay [expr $clk_period* (1-$timing_budget_io)]


######################################################################
########################### Master Clocks #######################
######################################################################
#create master clock with 50% duty cycle (it's 50% by default for -waveform)
create_clock -name clk -period $clk_period -wave "0 [expr $clk_period/2]" [get_ports CLK_P23]
#clock source latency
set_clock_latency -source 0.7 [get_clocks clk]
#setup and hold uncertainties
set_clock_uncertainty -setup -from [get_clocks clk] -to [get_clocks clk] $setup_uncertainty
set_clock_uncertainty -hold  -from [get_clocks clk] -to [get_clocks clk] $hold_uncertainty


###########################################################
############## Port Constraints (inputs) ##################
###########################################################
set_input_delay $input_delay -clock [get_clocks clk] [remove_from_collection [all_inputs] [get_ports CLK_P23]] 
set all_inputs_ex_clk [remove_from_collection [all_inputs] [get_ports CLK_P23]] 
set_input_transition -max 0.12 $all_inputs_ex_clk


###########################################################
##############  Port Constraints (outputs)  ###############
###########################################################
set_output_delay $output_delay -clock [get_clocks clk] [all_outputs] 


###########################################################
###########################################################
###########################################################
