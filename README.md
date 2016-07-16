# Usecase

* Run
```
	vagrant destroy -f && vagrant up
	
	# to use ssh among each other VMs.
	vagrant ssh core-02
	cat ~/share/resources/core-01 >> ~/.ssh/authorized_keys
	exit
	
	vagrant ssh core-01
	source .profile 
	
	cd ~/share
	bash script/app.sh
```

* Test etcdctl / fleetctl
```
	- fleet template
	- fleet sidekick
```

cf. Edited shared folder / init script
```
	- edit Vagrantfile
		## shared folder
		config.vm.synced_folder ".", "/home/core/share", id: "core", :nfs => true, :mount_options => ['nolock,vers=3,udp']
		## init script
	    config.vm.provision :shell, :path => "script/init.sh"
```

