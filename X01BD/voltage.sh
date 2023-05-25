#!/bin/bash

# Source Devices Trees 4.4
git clone https://github.com/khirendra03/android_device_asus_X01BD -b 13a device/asus/X01BD 
git clone https://github.com/khirendra03/android_device_asus_sdm660-common -b test device/asus/sdm660-common
git clone https://github.com/khirendra03/android_kernel_asus_sdm660 -b temp kernel/asus/sdm660
git clone https://github.com/khirendra03/proprietary_vendor_asus -b 13 vendor/asus

# 4.19 Hals
#git clone https://github.com/Nerdhannn/android_hardware_google_pixel hardware/google/pixel
#git clone https://github.com/Atom-X-Devs/android_hardware_qcom-caf_sdm660_audio -b sdm660-12 hardware/qcom-caf/sdm660/audio
#git clone https://github.com/Atom-X-Devs/android_hardware_qcom-caf_sdm660_display -b sdm660-12 hardware/qcom-caf/sdm660/display
#git clone https://github.com/Atom-X-Devs/android_hardware_qcom-caf_sdm660_media -b sdm660-12 hardware/qcom-caf/sdm660/media
# Guard QCOM Snapdragon 660 Hals
#cp -af hardware/qcom-caf/common/os_pickup_qssi.bp hardware/qcom-caf/sdm660/Android.bp
#cp -af hardware/qcom-caf/common/os_pickup.mk hardware/qcom-caf/sdm660/Android.mk
