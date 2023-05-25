#!/bin/bash


export ARCH=arm64
export PATH=/home/hyoon/phizero/gcc/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin:$PATH

mkdir out

make -C $(pwd) O=out CROSS_COMPILE=aarch64-linux-gnu- j2y18lte_defconfig
make -j64 -C $(pwd) O=out CROSS_COMPILE=aarch64-linux-gnu- -j16
 
cp out/arch/arm/boot/Image $(pwd)/arch/arm/boot/Image.gz