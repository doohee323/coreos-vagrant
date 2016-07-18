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
	
	# to test some commands
	cd ~/share
	bash script/test.sh
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

* Test Nodejs app from private docker registry
```
	cf. https://github.com/doohee323/dockerInVagrant
		copy from domain.crt to resources folder 
		$ cp ~/dockerInVagrant/domain.crt ~/coreos-vagrant/share/resources/domain.crt
		
		core@core-01 ~/share/script $ bash nodejs.sh
		curl http://172.17.8.101:3000
```

cf. Edited shared folder / init script
```
	- edit Vagrantfile
		## shared folder
		config.vm.synced_folder ".", "/home/core/share", id: "core", :nfs => true, :mount_options => ['nolock,vers=3,udp']
		## init script
	    config.vm.provision :shell, :path => "script/init.sh"
```
