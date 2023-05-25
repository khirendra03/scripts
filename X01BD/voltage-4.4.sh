#bin/bash

# device tree
git clone https://github.com/khirendra03/android_device_asus_X01BD.git -b 13 device/asus/X01BD
# common trer
git clone https://github.com/khirendra03/android_device_asus_sdm660-common.git -b 13 device/asus/sdm660-common
# vendor
git clone https://github.com/khirendra03/proprietary_vendor_asus.git -b 13 vendor/asus
# kernel from arrow os
git clone https://github.com/ArrowOS-Devices/android_kernel_asus_X01BD.git -b arrow-13.0 kernel/asus/sdm660

# cosmic clang
git clone https://gitlab.com/GhostMaster69-dev/cosmic-clang.git -b release/14.x prebuilts/clang/host/linux-x86/clang-cosmic
