# firecracker_on_rpi4
Reference : https://github.com/firecracker-microvm/firecracker/blob/main/docs/rootfs-and-kernel-setup.md

## Environment
ubuntu22.04 on wsl

## download toolchain and related components
```sh
sudo apt-get update
sudo apt-get install gcc-aarch64-linux-gnu, ncurses, libncurses-dev, flex, bison
```

## download kernel source code
```sh
git clone https://github.com/torvalds/linux.git linux.git
cd linux.git
git checkout v5.10
```

## prepare kernel defconfig for firecracker
https://github.com/firecracker-microvm/firecracker/tree/main/resources/guest_configs  
I used [microvm-kernel-arm64-5.10.config](https://github.com/firecracker-microvm/firecracker/blob/main/resources/guest_configs/microvm-kernel-arm64-5.10.config).  
Copy all it and paste to your local environment, rename it as you like(I rename it `firecracker_510_defconfig`).  
Place it under `linux.git/arch/arm64/configs`.

## build kernel
Now you can build your kernel as following commands.
```sh
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- firecracker_510_defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
```

When build finishes, you can find built image under `linux.git/arch/arm64/boot/`, file name is `Image`.  
Copy (or scp) to the raspberry pi 4 any folder.
