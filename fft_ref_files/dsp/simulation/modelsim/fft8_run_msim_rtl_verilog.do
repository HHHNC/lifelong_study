transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/30226/Desktop/git/workpace/dsp_ref_files/dsp {C:/Users/30226/Desktop/git/workpace/dsp_ref_files/dsp/fft8.v}
vlog -vlog01compat -work work +incdir+C:/Users/30226/Desktop/git/workpace/dsp_ref_files/dsp {C:/Users/30226/Desktop/git/workpace/dsp_ref_files/dsp/butterfly.v}

