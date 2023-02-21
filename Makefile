SEEDDIR=./preseed

PORT ?= 0
ifneq ($(PORT), 0)
        HTTP_PORT += $(PORT)
else
        HTTP_PORT += 8000
endif

KEYB ?= 0
ifneq ($(KEYB), 0)
        KEYMAP += $(KEYB)
else
        KEYMAP += fr
endif
dir:
	mkdir -vp ~/libvirt/{boot,images}
serve: 
	@echo 'Spawning a web server on local system at port ${HTTP_PORT}'
	@echo 'When finished, press Ctrl+C to stop it.'
	cd ${SEEDDIR} && python3 -m http.server ${HTTP_PORT}

server11:
	@echo 'installing server11'
	sudo virt-install --hvm --name server11 --memory 1024 --vcpus 1 --cpu host --location https://ftp.fr.debian.org/debian/dists/stable/main/installer-amd64/ --extra-args "auto=true language=en country=FR keymap=${KEYMAP} domain=example.com hostname=server11 url=http://192.168.122.1:${HTTP_PORT}/server11.cfg" --os-variant=debian11 --disk path=${HOME}/libvirt/images/server11.qcow2,size=10 --network=default --graphics spice --autoconsole none

server12:
	@echo 'installing server12'
	sudo virt-install --hvm --name server12 --memory 1024 --vcpus 1 --cpu host --location https://ftp.fr.debian.org/debian/dists/stable/main/installer-amd64/ --extra-args "auto=true language=en country=FR keymap=${KEYMAP} domain=example.com hostname=server12 url=http://192.168.122.1:${HTTP_PORT}/server12.cfg" --os-variant=debian11 --disk path=${HOME}/libvirt/images/server12.qcow2,size=10 --network=default --graphics spice --autoconsole none

server13:
	@echo 'installing server13'
	sudo virt-install --hvm --name server13 --memory 1024 --vcpus 1 --cpu host --location https://ftp.fr.debian.org/debian/dists/stable/main/installer-amd64/ --extra-args "auto=true language=en country=FR keymap=${KEYMAP} domain=example.com hostname=server13 url=http://192.168.122.1:${HTTP_PORT}/server13.cfg" --os-variant=debian11 --disk path=${HOME}/libvirt/images/server13.qcow2,size=10 --network=default --graphics spice --autoconsole none
