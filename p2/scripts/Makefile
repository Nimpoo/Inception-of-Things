VAGRANT_CMD := vagrant
PROVIDER := libvirt

VIRSH_CMD := virsh
VIRSH_FLAGS := --connect qemu:///system

.PHONY: up
up:
	$(VAGRANT_CMD) up --provider=$(PROVIDER)

.PHONY: reload
reload:
	$(VAGRANT_CMD) reload

.PHONY: halt
halt:
	$(VAGRANT_CMD) halt

.PHONY: destroy
destroy:
	$(VAGRANT_CMD) destroy --force
	rm -rf .vagrant

.PHONY: destroy-all
destroy-box:
	$(VAGRANT_CMD) box remove $(BOX_NAME) --force

.PHONY: virsh-destroy
virsh-destroy:
	-$(VIRSH_CMD) $(VIRSH_FLAGS) destroy --domain p2_noalexanS
	-$(VIRSH_CMD) $(VIRSH_FLAGS) undefine --domain p2_noalexanS --remove-all-storage

.PHONY: virsh-net-destroy
virsh-net-destroy:
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-destroy vagrant-libvirt-p2
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-undefine vagrant-libvirt-p2
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-destroy vagrant-libvirt
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-undefine vagrant-libvirt

.PHONY: re
re: destroy up

.NOT_PARALLEL: up reload halt destroy destroy-box virsh-destroy virsh-net-destroy re
