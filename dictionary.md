# 1. Vagrant

## 1.1 Overview

- **Vagrant**: Vagrant is a tool for building complete development environments. It can be considered as a wrapper around virtualization technologies like VirtualBox, VMware, and others, providing a simple command-line interface and configuration files to manage the lifecycle of development environments. It allows developers to create, configure, and provision virtual machines easily, ensuring that the development environment is consistent across different systems.

_Vagrant is a HashiCorp tool that simplifies creating and managing developer environments. It bridges the gap between the host machine (your local computer) and the guest machine (the virtual environment) to ensure seamless integration._ [Official documentation](https://developer.hashicorp.com/vagrant/tutorials/get-started/development-environment)

![vagrant usage](assets/vagrant.png)

- **Development environments with Vagrant**: Development environments provide consistent setups for writing, testing, and debugging code. They help teams collaborate more effectively by ensuring reliability and portability, while addressing challenges like configuration drift and dependency issues.

- **`Vagrantfile`**: The `Vagrantfile` is a configuration file used by Vagrant to define the properties of the virtual environment. It specifies the base box to use, network settings, synced folders, and provisioning scripts. This file is written in Ruby and allows for a high degree of customization.

_Example of a `Vagrantfile`_:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder ".", "/vagrant", type: "rsync"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y git
  SHELL
end
```

- **The Vagrant workflow**: The standard Vagrant workflow includes:
	1. **Scope** - Identify the requirements for your development environment, such as the OS, tools, and dependencies.
	2. **Author** - Write the ` Vagrantfile` to specify your environment.
	3. **Manage** - Use Vagrant commands to start, stop, and destroy environments.
	4. **Share** - Distribute the Vagrantfile or a packaged box with your team for consistent setups.

- **Vagrant Box**: A Vagrant box is a pre-configured virtual machine image that serves as a base for creating new Vagrant environments. Boxes can be shared and reused, allowing teams to standardize their development environments easily. Vagrant provides a public repository of boxes, and users can also create and publish their own.

- **Provisioning**: Provisioning is the process of configuring and setting up the software and services within a Vagrant environment. Vagrant supports various provisioning methods, including shell scripts, Ansible, Chef, and Puppet. This allows developers to automate the setup of their development environments and ensure consistency across different machines.

- **Provider**: A provider is a plugin that Vagrant uses to manage different virtualization technologies. Providers are responsible for creating, configuring, and managing the virtual machines. Some popular providers include **VirtualBox**, **VMware**, **HyperV**, **libvirt**, etc...

## 1.2 Vagrant with `libvirt`

- **`libvirt`**: Libvirt is an open-source API, daemon, and management tool for managing platform virtualization technologies. It provides a consistent interface for interacting with different hypervisors like KVM, QEMU, and others. Libvirt simplifies the management of virtual machines, networks, and storage by providing a unified set of commands and tools.

### _What is `libvirt`, `KVM`, and `QEMU` ?_

- **`KVM`**: KVM (Kernel-based Virtual Machine) is a virtualization technology built into the Linux kernel that allows the kernel to function as a hypervisor. It enables the creation and management of virtual machines on Linux systems, providing hardware virtualization capabilities.

- **`QEMU`**: QEMU (Quick Emulator) is an open-source machine emulator and virtualizer. It allows users to run virtual machines with different architectures and operating systems on a host machine. QEMU can be used in conjunction with KVM to provide full virtualization capabilities.

- **The relation between `libvirt`, `KVM`, and `QEMU`**: Libvirt acts as a management layer for KVM and QEMU, providing a unified API and set of tools for managing virtual machines. KVM provides the underlying virtualization capabilities, while QEMU handles the emulation of hardware and devices. Together, they enable the creation and management of virtualized environments.

**`QEMU`** = machine (hardware) emulator.
**`KVM`** = kernel module for Linux to enable virtualization; this is the hypervisor. QEMU can run without KVM but it can be quite a bit slower.
**`libvirt`** = virtualization library which wraps QEMU and KVM to provide APIs for use by other programs, such as Vagrant, which is a tool for creating virtualized development environments

Vagrant uses `libvirt`, and `libvirt` uses `QEMU` and `KVM`.

- **`virsh`**: `virsh` is a command-line interface for managing virtual machines through the libvirt API. It allows users to perform various tasks such as starting, stopping, and managing virtual machines, as well as configuring networks and storage.

I personally chose `libvirt` as provider because it's native to most Linux Distribution instead of Virtual Box for exemple. But it requires more configuration compared to other providers. We need to install the plugin `vagrant-libvirt`, here the [official documentation](https://vagrant-libvirt.github.io/vagrant-libvirt/).

## 1.3 Some useful commands

### 1.3.1 `vagrant` commands
- `vagrant init generic/fedora28 --box-version 4.3.12`: Initializes a new Vagrant environment with the specified box and version.
  - `vagrant`: command-line tool for managing Vagrant environments.
  - `init`: command to create a new Vagrantfile.
  - `generic/fedora28`: the name of the base box to use.
  - `--box-version 4.3.12`: specifies the version of the box to use.
- `vagrant up`: Starts the Vagrant environment and provisions the virtual machine.
- `vagrant halt`: Stops the running Vagrant environment.
- `vagrant destroy`: Destroys the Vagrant environment, removing all traces of the virtual machine.
- `vagrant box`: Manages Vagrant boxes (add, remove, list).
- `vagrant ssh`: Connects to the running Vagrant environment via SSH.
> You can add the flag `-c`/`--command` following by a command `"[SHELL_CMD]"` to run a specific command on the remote machine.

### 1.3.2 `virsh` commands
- `virsh`: A command-line interface for managing virtual machines in a hypervisor environment, such as KVM (Kernel-based Virtual Machine). It allows users to create, start, stop, and manage virtual machines and their resources. We use `libvirt` as provider for this project, so all the emulated VMs (with QEMU, etc...) will be managed through `virsh`.
- `virsh list`: Lists all active virtual machines.
- `virsh list --all`: Lists all virtual machines, including those that are not running.
- `virsh net-list`: Lists all virtual networks.
- `virsh start <vm-name>`: Starts a stopped virtual machine.
- `virsh shutdown <vm-name>`: Gracefully shuts down a running virtual machine.
- `virsh destroy <vm-name>`: Forces a virtual machine to stop.
- `virsh undefine <vm-name>`: Removes the definition of a virtual machine, but does not delete its disk images.
- `virsh console <vm-name>`: Connects to the console of a running virtual machine.

We use the `qemu:///system` URI to connect to the QEMU hypervisor, here some command to list VMs in this environment (and NOT with the `qemu:///session` URI):
- `virsh --connect qemu:///system list --all`: Lists all virtual machines managed by the QEMU hypervisor.
- `virsh --connect qemu:///system net-list --all`: Lists all virtual networks managed by the QEMU hypervisor.

# 2. Kubernetes, K3s and others

- **`K3s`**: K3s is a lightweight Kubernetes distribution designed for resource-constrained environments and edge computing. It simplifies the deployment and management of Kubernetes clusters by reducing the complexity and resource requirements. K3s is packaged as a single binary and includes only the essential components needed to run Kubernetes, making it easy to install and operate.

- **`kubectl`**: Kubectl is the command-line tool for interacting with Kubernetes clusters. It allows users to deploy applications, manage cluster resources, and inspect logs. Kubectl provides a powerful and flexible interface for working with Kubernetes, enabling developers to automate tasks and streamline their workflows.
