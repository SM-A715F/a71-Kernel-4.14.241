#!/bin/bash

export CROSS_COMPILE=~/REALBITCH/gcc/bin/aarch64-linux-android-
export ARCH=arm64
mkdir out

BUILD_CROSS_COMPILE=~/REALBITCH/gcc/bin/aarch64-linux-android-
KERNEL_LLVM_BIN=~/REALBITCH/llvm-sdclang/bin/clang
CLANG_TRIPLE=aarch64-linux-gnu-
KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

make -j64 -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV ARCH=arm64 CROSS_COMPILE=$BUILD_CROSS_COMPILE CC="ccache $KERNEL_LLVM_BIN" CLANG_TRIPLE=$CLANG_TRIPLE sm7150_sec_a71_eur_open_defconfig
make -j64 -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV ARCH=arm64 CROSS_COMPILE=$BUILD_CROSS_COMPILE CC="ccache $KERNEL_LLVM_BIN" CLANG_TRIPLE=$CLANG_TRIPLE
 
cp out/arch/arm64/boot/Image $(pwd)/arch/arm64/boot/Image
