set_db init_lib_search_path /home/install/FOUNDRY/digital/90nm/dig/lib/
set_db library slow.lib
read_hdl {./booth_wallace8_trunc2.v}
elaborate
read_sdc ./new.sdc
set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium
syn_generic
syn_map
syn_opt
write_hdl > output_netlist_booth_wallace8_trunc2.v
write_sdc > booth_wallace8_trunc2.sdc
report area > area_report_booth_wallace8_trunc2.rep
report power > power_report_booth_wallace8_trunc2.rep
set_db timing_report_unconstrained true
report timing > timing_report_booth_wallace8_trunc2.rep
gui_show

