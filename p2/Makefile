VAGRANT_CMD := vagrant
PROVIDER := libvirt

VIRSH_CMD := virsh
VIRSH_FLAGS := --connect qemu:///system

up:
	$(VAGRANT_CMD) up --provider=$(PROVIDER)

reload:
	$(VAGRANT_CMD) reload

halt:
	$(VAGRANT_CMD) halt

destroy:
	$(VAGRANT_CMD) destroy --force
	rm -rf .vagrant

destroy-box:
	$(VAGRANT_CMD) box remove $(BOX_NAME) --force

virsh-destroy:
	-$(VIRSH_CMD) $(VIRSH_FLAGS) destroy --domain p2_noalexanS
	-$(VIRSH_CMD) $(VIRSH_FLAGS) undefine --domain p2_noalexanS --remove-all-storage

virsh-net-destroy:
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-destroy vagrant-libvirt-p1
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-undefine vagrant-libvirt-p1
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-destroy vagrant-libvirt
	-$(VIRSH_CMD) $(VIRSH_FLAGS) net-undefine vagrant-libvirt

re: destroy up

.PHONY: up reload halt destroy-box virsh-destroy virsh-net-destroy
