This function/module allow you to setup a XG Firewall on Hyper-V (version 2012r2 or 2016)

It create : 

* the VM using the same metric as Sophos Lic (1vcpu/2go 2vcpu/4g ...)
* it create one vnetadapter for the admin service
* it create at least 2 vnetadpters for network trafic, you can provide vlan, enable VMQ, enable static mac address
* it can enable traditional routing/nat, transparent mode (only with 2 vnetadpater), promiscius mode


-computername the name of the Hyper-v Server
-source the source folder of the 2 sophos vhd files
-vmname the name of the XG Firewall VM 
-vcpu the number of vCPU for the vm
-xgmode nat,transparent,prom
-interfaces String[] name,[vlan], [VMQEnabled], wan/lan
