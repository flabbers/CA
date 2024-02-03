# good for now :)

VBoxManage startvm "ca_d_isprouter" --type headless

VBoxManage startvm "ca_c_dc"

VBoxManage startvm "ca_d_companyrouter" --type headless

VBoxManage startvm "ca_d_web" --type headless

VBoxManage startvm "ca_d_database" --type headless

VBoxManage startvm "ca_d_win10"

VBoxManage list runningvms
