# good for now :)
write-host "Halting all vm's ..."

write-host ""

$vms = @("ca_d_isprouter","ca_c_dc","ca_d_companyrouter","ca_d_web","ca_d_database","ca_d_win10")

foreach (${vm} in ${vms}) {
    write-host "Powering down vm ${vm}"
    VBoxManage controlvm ${vm} poweroff
}

write-host ""
write-host "All vm's running:"
write-host ""
VBoxManage list runningvms
