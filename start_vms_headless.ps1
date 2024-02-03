# good for now :)
write-host "Starting all vm's in the suggested order ..."

write-host ""

VBoxManage startvm "ca_d_isprouter" --type headless

write-host ""

VBoxManage startvm "ca_c_dc" --type headless

write-host ""

VBoxManage startvm "ca_d_companyrouter" --type headless

write-host ""

VBoxManage startvm "ca_d_web" --type headless

write-host ""

VBoxManage startvm "ca_d_database" --type headless

write-host ""

VBoxManage startvm "ca_d_win10" --type headless

write-host ""

write-host "All vm's running:"

write-host ""

VBoxManage list runningvms

write-host ""
