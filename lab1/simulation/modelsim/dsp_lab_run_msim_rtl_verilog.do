transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/30226/Desktop/git/workpace/DSP {C:/Users/30226/Desktop/git/workpace/DSP/butterfly.v}
vlog -vlog01compat -work work +incdir+C:/Users/30226/Desktop/git/workpace/DSP {C:/Users/30226/Desktop/git/workpace/DSP/fft8.v}

vlog -vlog01compat -work work +incdir+C:/Users/30226/Desktop/git/workpace/DSP/simulation/modelsim {C:/Users/30226/Desktop/git/workpace/DSP/simulation/modelsim/fft8.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclone10lp_ver -L rtl_work -L work -voptargs="+acc"  test

add wave *
view structure
view signals
run -all