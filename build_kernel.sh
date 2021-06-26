#!/bin/bash

# Check if have toolchain/llvm folder

# Export KBUILD flags
export KBUILD_BUILD_USER="geekmaster21"
export KBUILD_BUILD_HOST="geekmaster21"

# Export ARCH/SUBARCH flags
export ARCH="arm64"
export SUBARCH="arm64"

# Export ANDROID VERSION
export PLATFORM_VERSION=11
export ANDROID_MAJOR_VERSION=r


# Export CCACHE
export CCACHE_EXEC="$(which ccache)"
export CCACHE="${CCACHE_EXEC}"
export CCACHE_COMPRESS="1"
export USE_CCACHE="1"
ccache -M 50G

# Export toolchain/clang/llvm flags
export BUILD_KERNEL_DIR="~/a71r-main/"
export KERNEL_MAKE_ENV="DTC_EXT=$BUILD_KERNEL_DIR/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

# Export if/else outdir var
export WITH_OUTDIR=true

# Clear the console
clear

# Remove out dir folder and clean the source
if [ "${WITH_OUTDIR}" == true ]; then
   if [ ! -d "$(pwd)/a71" ]; then
      mkdir a71
   fi
fi

# Build time
if [ "${WITH_OUTDIR}" == true ]; then
   if [ ! -d "$(pwd)/a71" ]; then
      mkdir a71
   fi
fi

if [ "${WITH_OUTDIR}" == true ]; then

AR=llvm-ar 
NM=llvm-nm 
OBJCOPY=llvm-objcopy 
OBJDUMP=llvm-objdump 
STRIP=llvm-strip 

 "${CCACHE}" make $KERNEL_MAKE_ENV O=a71 ARCH=arm64 sm7150_sec_a71_eur_open_defconfig

PATH="/home/parallels/a71r-main/llvm-sdclang1/bin:/home/parallels/a71r-main/gcc/bin:/home/parallels/a71r-main/gcc32/bin:${PATH}" \
 "${CCACHE}" make -j$(nproc --all) O=a71 \
                      ARCH=arm64 \
                      $KERNEL_MAKE_ENV \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android- \
                      CROSS_COMPILE_ARM32=arm-linux-androideabi-
fi
