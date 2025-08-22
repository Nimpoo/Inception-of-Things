VAGRANT_CMD := vagrant
PROVIDER := libvirt

VIRSH_CMD := virsh
VIRSH_FLAGS := --connect qemu:///system

up:
	if [ ! -d synced_folder_nfs ]; then \
		mkdir -v synced_folder_nfs; \
	fi
	$(VAGRANT_CMD) up $(VM_NAME) --provider=$(PROVIDER)

up-all:
	if [ ! -d synced_folder_nfs ]; then \
		mkdir -v synced_folder_nfs; \
	fi
	$(VAGRANT_CMD) up --provider=$(PROVIDER)

reload:
	$(VAGRANT_CMD) reload $(VM_NAME)

reload-all:
	$(VAGRANT_CMD) reload 

halt:
	$(VAGRANT_CMD) halt

destroy:
	$(VAGRANT_CMD) destroy --force
	rm -rf .vagrant
	rm -rfv synced_folder_nfs/node-token

destroy-box:
	$(VAGRANT_CMD) box remove $(BOX_NAME) --force

virsh-destroy:
	-$(VIRSH_CMD) $(VIRSH_FLAGS) destroy --domain p1_noalexanS
	-$(VIRSH_CMD) $(VIRSH_FLAGS) undefine --domain p1_noalexanS --remove-all-storage
	-$(VIRSH_CMD) $(VIRSH_FLAGS) destroy --domain p1_mayoubSW
	-$(VIRSH_CMD) $(VIRSH_FLAGS) undefine --domain p1_mayoubSW --remove-all-storage

virsh-net-destroy:
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-destroy vagrant-libvirt-p1
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-undefine vagrant-libvirt-p1
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-destroy vagrant-libvirt
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-undefine vagrant-libvirt

.PHONY: up destroy virsh-destroy virsh-net-destroy
