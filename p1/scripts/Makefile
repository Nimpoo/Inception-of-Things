VAGRANT_CMD := vagrant
PROVIDER := libvirt

VIRSH_CMD := virsh
VIRSH_FLAGS := --connect qemu:///system

.PHONY: up
up: synced_folder_nfs
	$(VAGRANT_CMD) up $(VM_NAME) --provider=$(PROVIDER)

.PHONY: up-all
up-all: synced_folder_nfs
	$(VAGRANT_CMD) up --provider=$(PROVIDER)

synced_folder_nfs:
	@mkdir -v synced_folder_nfs

.PHONY: reload
reload:
	$(VAGRANT_CMD) reload $(VM_NAME)

.PHONY: reload-all
reload-all:
	$(VAGRANT_CMD) reload

.PHONY: halt
halt:
	$(VAGRANT_CMD) halt

.PHONY: destroy
destroy:
	$(VAGRANT_CMD) destroy --force
	rm -v synced_folder_nfs/node-token

.PHONY: destroy-box
destroy-box:
	$(VAGRANT_CMD) box remove $(BOX_NAME) --force

.PHONY: virsh-destroy
virsh-destroy:
	-$(VIRSH_CMD) $(VIRSH_FLAGS) destroy --domain p1_noalexanS
	-$(VIRSH_CMD) $(VIRSH_FLAGS) undefine --domain p1_noalexanS --remove-all-storage
	-$(VIRSH_CMD) $(VIRSH_FLAGS) destroy --domain p1_mayoubSW
	-$(VIRSH_CMD) $(VIRSH_FLAGS) undefine --domain p1_mayoubSW --remove-all-storage

.PHONY: virsh-net-destroy
virsh-net-destroy:
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-destroy vagrant-libvirt-p1
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-undefine vagrant-libvirt-p1
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-destroy vagrant-libvirt
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-undefine vagrant-libvirt

.PHONY: re
re: destroy up-all

.NOT_PARALLEL: up up-all reload reload-all halt destroy destroy-box virsh-destroy virsh-net-destroy re
