SEEDDIR=./preseed
LOCATION="http://ftp.fr.debian.org/debian/dists/stable/main/installer-amd64/"
VCPUS=1
MEM=1024
IMG_DIR=${HOME}/libvirt/images
BOOT_DIR=${HOME}/libvirt/boot
VIRT_INST_COMMON_OPTS=--hvm --cpu host --vcpus ${VCPUS} --memory ${MEM} --location=${LOCATION} --osinfo=debiantesting --network=default --graphics spice --autoconsole none

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
	install -d -m 755 ${IMG_DIR}
	install -d -m 755 ${BOOT_DIR}

deb-deps:
	sudo apt-get -qq -y update
	sudo apt-get -qq -y upgrade
	sudo apt-get -qq -y install qemu-kvm libvirt-daemon-system libvirt-daemon virtinst libosinfo-bin virt-manager qemu-system-x86

serve: 
	@echo 'Spawning a web server on local system at port ${HTTP_PORT}'
	@echo 'When finished, press Ctrl+C to stop it.'
	cd ${SEEDDIR} && python3 -m http.server ${HTTP_PORT}

server11:
	@echo 'installing server11'
	sudo virt-install ${VIRT_INST_COMMON_OPTS} --name server11 --extra-args "auto=true language=en country=FR keymap=${KEYMAP} domain=example.com hostname=server11 url=http://192.168.122.1:${HTTP_PORT}/server11.cfg" --disk path=${IMG_DIR}/server11.qcow2,size=10

server12:
	@echo 'installing server12'
	sudo virt-install ${VIRT_INST_COMMON_OPTS} --name server12 --extra-args "auto=true language=en country=FR keymap=${KEYMAP} domain=example.com hostname=server12 url=http://192.168.122.1:${HTTP_PORT}/server12.cfg" --disk path=${IMG_DIR}/server12.qcow2,size=10

server13:
	@echo 'installing server13'
	sudo virt-install ${VIRT_INST_COMMON_OPTS} --name server13 --extra-args "auto=true language=en country=FR keymap=${KEYMAP} domain=example.com hostname=server13 url=http://192.168.122.1:${HTTP_PORT}/server13.cfg" --disk path=${IMG_DIR}/server13.qcow2,size=10
