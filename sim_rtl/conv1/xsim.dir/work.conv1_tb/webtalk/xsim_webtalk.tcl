webtalk_init -webtalk_dir /home/gsaied/Desktop/old_rtl/conv1/xsim.dir/work.conv1_tb/webtalk/
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "Thu Mar 19 20:07:00 2020" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "XSIM v2018.3 (64-bit)" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "2405991" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "LIN64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "xsim" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "01320e5b-127e-4fa8-9495-2cf79762436e" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "b50b67f6-07b2-40be-a28b-250bf1755dea" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "7" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "Ubuntu" -context "user_environment"
webtalk_add_data -client project -key os_release -value "Ubuntu 18.04.4 LTS" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "2700.074 MHz" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "1" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "8.000 GB" -context "user_environment"
webtalk_register_client -client xsim
webtalk_add_data -client xsim -key runall -value "true" -context "xsim\\command_line_options"
webtalk_add_data -client xsim -key Command -value "xsim" -context "xsim\\command_line_options"
webtalk_add_data -client xsim -key runtime -value "4587605 ns" -context "xsim\\usage"
webtalk_add_data -client xsim -key iteration -value "1" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Time -value "24.62_sec" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Memory -value "115964_KB" -context "xsim\\usage"
webtalk_transmit -clientid 3915286887 -regid "" -xml /home/gsaied/Desktop/old_rtl/conv1/xsim.dir/work.conv1_tb/webtalk/usage_statistics_ext_xsim.xml -html /home/gsaied/Desktop/old_rtl/conv1/xsim.dir/work.conv1_tb/webtalk/usage_statistics_ext_xsim.html -wdm /home/gsaied/Desktop/old_rtl/conv1/xsim.dir/work.conv1_tb/webtalk/usage_statistics_ext_xsim.wdm -intro "<H3>XSIM Usage Report</H3><BR>"
webtalk_terminate
