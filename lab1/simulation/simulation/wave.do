onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Literal /test/clk
add wave -noupdate /test/rstn
add wave -noupdate /test/en
add wave -noupdate /test/x0_real
add wave -noupdate /test/x0_imag
add wave -noupdate /test/x1_real
add wave -noupdate /test/x1_imag
add wave -noupdate /test/x2_real
add wave -noupdate /test/x2_imag
add wave -noupdate /test/x3_real
add wave -noupdate /test/x3_imag
add wave -noupdate /test/x4_real
add wave -noupdate /test/x4_imag
add wave -noupdate /test/x5_real
add wave -noupdate /test/x5_imag
add wave -noupdate /test/x6_real
add wave -noupdate /test/x6_imag
add wave -noupdate /test/x7_real
add wave -noupdate /test/x7_imag
add wave -noupdate /test/valid
add wave -noupdate /test/y0_real
add wave -noupdate /test/y0_imag
add wave -noupdate /test/y1_real
add wave -noupdate /test/y1_imag
add wave -noupdate /test/y2_real
add wave -noupdate /test/y2_imag
add wave -noupdate /test/y3_real
add wave -noupdate /test/y3_imag
add wave -noupdate /test/y4_real
add wave -noupdate /test/y4_imag
add wave -noupdate /test/y5_real
add wave -noupdate /test/y5_imag
add wave -noupdate /test/y6_real
add wave -noupdate /test/y6_imag
add wave -noupdate /test/y7_real
add wave -noupdate /test/y7_imag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {199500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {197800 ps} {198500 ps}
