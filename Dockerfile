FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \ 
    apt-get install -y \ 
	git \
	make \
	gcc-aarch64-linux-gnu \
	gcc \
	bc \
	flex \
	bison \
	libssl-dev

# Clone kernel source code
RUN git clone https://github.com/torvalds/linux.git -b v5.10 --depth=1 /usr/src/linux
# Copy kernel configuration file to kernel source directory
COPY ./firecracker_510_defconfig /usr/src/linux/arch/arm64/configs/

# Build kernel
WORKDIR /usr/src/linux
RUN make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- firecracker_510_defconfig
RUN make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
CMD ["/bin/bash"]
