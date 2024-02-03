VBoxManage startvm "ca_d_isprouter" --type headless

VBoxManage startvm "ca_c_dc" --type headless

VBoxManage startvm "ca_d_companyrouter" --type headless

VBoxManage startvm "ca_d_web" --type headless

VBoxManage startvm "ca_d_database" --type headless

# VBoxManage startvm "ca_d_win10"

VBoxManage startvm "red_vagrant" --type headless

VBoxManage startvm "Kali_2023.2"

VBoxManage list runningvms
