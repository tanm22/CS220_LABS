
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name small -dir "/media/cse/2AA3-B3E2/Lab7/Lab7/Lab7_2/small/planAhead_run_1" -part xa7a100tcsg324-2I
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "lcd.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {lcd.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top lcd $srcset
add_files [list {lcd.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xa7a100tcsg324-2I
