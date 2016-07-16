# Usecase

* Shared folder / Init script
```
	1. edit Vagrantfile
		## shared folder
    	config.vm.synced_folder ".", "/home/core/share", id: "core", :nfs => true, :mount_options => ['nolock,vers=3,udp']
    	## init script
        config.vm.provision :shell, :path => "script/init.sh"
	2. run vagrant with PC's password
		vagrant destroy -f && vagrant up 
	3. vagrant ssh core-01
		source .profile
```

* Test etcdctl / fleetctl
```
	- fleet template
	- fleet sidekick
```