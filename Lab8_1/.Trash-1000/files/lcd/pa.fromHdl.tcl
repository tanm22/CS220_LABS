
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name lcd -dir "/media/cse/2AA3-B3E2/Lab7/lcd/planAhead_run_1" -part xc3s500efg320-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "returnMin.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {min.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top returnMin $srcset
add_files [list {returnMin.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s500efg320-4
