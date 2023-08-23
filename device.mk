#
# Copyright (C) 2023 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit virtual_ab_ota_product.
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Setup dalvik vm configs.
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Call the proprietary setup.
$(call inherit-product, vendor/xiaomi/mondrian/mondrian-vendor.mk)

# Enable updating of APEXes.
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Project ID Quota.
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

DEVICE_PATH := device/xiaomi/mondrian

# SHIPPING API
PRODUCT_SHIPPING_API_LEVEL := 31

# VNDK API
PRODUCT_TARGET_VNDK_VERSION := 32
PRODUCT_EXTRA_VNDK_VERSIONS := 30 31 32

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_cape_qssi/audio_policy_configuration.xml

PRODUCT_ODM_PROPERTIES += \
    aaudio.mmap_policy=1 \
    vendor.audio.offload.buffer.size.kb=256

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.audio.auto.scenario=true \
    ro.config.vc_call_vol_steps=11 \
    ro.config.alarm_vol_steps=15 \
    ro.config.system_vol_steps=15 \
    ro.config.vc_call_vol_default=9 \
    ro.vendor.audio.camera.loopback.support=false \
    ro.vendor.audio.feature.spatial=7 \
    ro.vendor.audio.gain.support=true \
    ro.vendor.audio.soundtrigger=sva \
    ro.vendor.audio.soundtrigger.lowpower=true \
    ro.vendor.audio.soundtrigger.training.level=50 \
    ro.vendor.audio.soundtrigger.xanzn.gmm.level=80 \
    ro.vendor.audio.soundtrigger.xanzn.gmm.user.level=80 \
    ro.vendor.audio.soundtrigger.xanzn.cnn.level=158 \
    ro.vendor.audio.soundtrigger.xanzn.vop.level=10 \
    ro.vendor.audio.soundtrigger.xatx.gmm.level=54 \
    ro.vendor.audio.soundtrigger.xatx.gmm.user.level=54 \
    ro.vendor.audio.soundtrigger.xatx.cnn.level=95 \
    ro.vendor.audio.soundtrigger.xatx.vop.level=0 \
    ro.vendor.audio.soundtrigger.appdefine.gmm.level=55 \
    ro.vendor.audio.soundtrigger.appdefine.gmm.user.level=65 \
    ro.vendor.audio.soundtrigger.appdefine.cnn.level=45 \
    ro.vendor.audio.soundtrigger.appdefine.vop.level=10 \
    ro.vendor.audio.soundtrigger.snr=16 \
    ro.vendor.audio.soundtrigger.xiaomievent=1 \
    ro.vendor.audio.soundtrigger.permian=1 \
    ro.vendor.audio.soundtrigger.sva-6.0=1 \
    ro.vendor.audio.support.sound.id=true

# Boot animation
TARGET_BOOT_ANIMATION_RES := 1440
TARGET_SCREEN_HEIGHT := 3200
TARGET_SCREEN_WIDTH := 1440

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Bluetooth
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.vendor.btstack.enable.lpa=true

PRODUCT_VENDOR_PROPERTIES += \
    persist.sys.fflag.override.settings_bluetooth_hearing_aid=true \
    persist.vendor.qcom.bluetooth.a2dp_offload_cap=sbc-aptx-aptxtws-aptxhd-aac-ldac-aptxadaptiver2 \
    persist.vendor.qcom.bluetooth.a2dp_mcast_test.enabled=false \
    persist.vendor.qcom.bluetooth.aac_frm_ctl.enabled=true \
    persist.vendor.qcom.bluetooth.aac_vbr_ctl.enabled=true \
    persist.vendor.qcom.bluetooth.aptxadaptiver2_1_support=true \
    persist.vendor.qcom.bluetooth.scram.enabled=false \
    persist.vendor.qcom.bluetooth.twsp_state.enabled=false \
    persist.vendor.service.bdroid.soc.alwayson=true \
    ro.vendor.bluetooth.csip_qti=true

PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.7.vendor \
    vendor.qti.hardware.camera.aon@1.0.vendor \
    vendor.qti.hardware.camera.postproc@1.0.vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

PRODUCT_SYSTEM_PROPERTIES += \
    ro.miui.notch=1 \
    ro.product.mod_device=mondrian_global

PRODUCT_VENDOR_PROPERTIES += \
    camera.disable_zsl_mode=1 \
    ro.camera.enableCamera1MaxZsl=1 \
    ro.hardware.camera=xiaomi

# Characteristics
PRODUCT_CHARACTERISTICS := nosdcard

# Display / Graphics
PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.config-V2-ndk_platform.vendor \
    vendor.qti.hardware.display.config-V5-ndk_platform.vendor \
    vendor.qti.hardware.memtrack-service

PRODUCT_ODM_PROPERTIES += \
    persist.sys.sf.color_mode=0 \
    vendor.display.disable_3d_adaptive_tm=0 \
    vendor.display.enable_rounded_corner=0 \
    vendor.display.use_smooth_motion=0 \
    vendor.display.vds_allow_hwc=true

PRODUCT_VENDOR_PROPERTIES += \
    debug.sf.disable_backpressure=1 \
    debug.sf.set_idle_timer_ms=1100 \
    persist.sys.sf.native_mode=258 \
    ro.gfx.driver.1=com.qualcomm.qti.gpudrivers.taro.api31 \
    ro.vendor.display.ai_disp.enable=true \
    ro.vendor.display.hwc_thermal_dimming=true \
    ro.vendor.display.mode_change_optimize.enable=true \
    ro.vendor.display.mi_calib.enable=true \
    ro.vendor.display.nature_mode.enable=true \
    ro.vendor.histogram.enable=true \
    ro.vendor.sre.enable=true \
    ro.vendor.localhbm.enable=true \
    ro.vendor.xiaomi.bl.poll=true \
    vendor.display.disable_dynamic_sf_idle=1 \
    vendor.display.enable_fb_scaling=1 \
    ro.vendor.display.default_size=1440,3200,560 \
    persist.sys.miui_resolution=1080,2400,420 \
    vendor.display.mixer_resolution=1080,2400,420 \
    ro.vendor.colorpick_adjust=true \
    ro.vendor.all_modes.colorpick_adjust=true \
    ro.vendor.display.type=oled \
    ro.vendor.whitepoint_calibration_enable=false \
    ro.vendor.cabc.enable=fasle \
    ro.vendor.bcbc.enable=true \
    ro.vendor.dfps.enable=false \
    ro.vendor.fps.switch.default=true \
    ro.vendor.gcp.enable=1

PRODUCT_PACKAGES += \
    android.hardware.graphics.common-V1-ndk_platform

# Dolby
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/audio/dolby/dax-default.xml:$(TARGET_COPY_OUT_ODM)/etc/dolby/dax-default.xml \
    $(DEVICE_PATH)/audio/dolby/config-com.dolby.daxappui.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/config-com.dolby.daxappui.xml \
    $(DEVICE_PATH)/audio/dolby/config-com.dolby.daxservice.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/config-com.dolby.daxservice.xml \
    $(DEVICE_PATH)/audio/dolby/hiddenapi-com.dolby.daxservice.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/hiddenapi-com.dolby.daxservice.xml \
    $(DEVICE_PATH)/audio/dolby/privapp-com.dolby.daxappui.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-com.dolby.daxappui.xml \
    $(DEVICE_PATH)/audio/dolby/privapp-com.dolby.daxservice.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-com.dolby.daxservice.xml

# Dtb
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/prebuilts/dtb:dtb.img

# DT2W
PRODUCT_PACKAGES += \
    DT2W-Service-Mondrian

# DPM
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.dpm.vndr.feature=1 \
    persist.vendor.dpm.vndr.halservice.enable=1 \
    persist.vendor.dpm.vndr.idletimer.mode=default

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4-service.clearkey \
    android.hardware.drm@1.4.vendor

PRODUCT_VENDOR_PROPERTIES += \
    drm.service.enabled=true

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# F2FS utilities
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss-V1-ndk_platform.vendor

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl-qti \
    android.hardware.health@2.1-service \
    android.hardware.health@2.1-impl.recovery

# HotwordEnrollement
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/permissions/hotword-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/hotword-hiddenapi-package-whitelist.xml \
    $(DEVICE_PATH)/configs/permissions/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-hotword.xml

# Identity
PRODUCT_PACKAGES += \
    android.hardware.identity-V3-ndk_platform.vendor

# Input
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/idc/uinput-fpc.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/uinput-fpc.idc \
    $(DEVICE_PATH)/configs/idc/uinput-goodix.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/uinput-goodix.idc \
    $(DEVICE_PATH)/configs/keylayout/uinput-fpc.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/uinput-fpc.kl \
    $(DEVICE_PATH)/configs/keylayout/uinput-goodix.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/uinput-goodix.kl

# IR
PRODUCT_PACKAGES += \
    android.hardware.ir@1.0-impl \
    android.hardware.ir@1.0-service

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.consumerir.xml

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0.vendor \
    android.hardware.keymaster@4.1.vendor \
    android.hardware.security.keymint-V1-ndk_platform.vendor \
    libkeymaster_messages.vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml

PRODUCT_VENDOR_PROPERTIES += \
    vendor.gatekeeper.disable_spu=true

# Media
PRODUCT_PACKAGES += \
    libavservices_minijail \
    libmediaplayerservice \
    libavservices_minijail_vendor \
    libcodec2_hidl@1.0.vendor \
    libcodec2_soft_common.vendor \
    libsfplugin_ccodec_utils.vendor

# MultiGen LRU
PRODUCT_SYSTEM_PROPERTIES += \
    persist.device_config.mglru_native.lru_gen_config=all

# NFC
PRODUCT_PACKAGES += \
    NfcNci \
    Tag \
    SecureElement \
    com.android.nfc_extras

PRODUCT_VENDOR_PROPERTIES += \
    debug.stagefright.c2inputsurface=-1 \
    ro.mediaserver.64b.enable=true

# NDK
NEED_AIDL_NDK_PLATFORM_BACKEND := true

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay-lineage

PRODUCT_PACKAGES += \
    AospWifiResOverlayMondrian \
    CarrierConfigResCommon \
    FrameworksResCommon \
    FrameworksResOverlayMondrian \
    SettingsOverlayMondrian \
    SettingsResCommon \
    SystemUIOverlayMondrian \
    SystemUIResCommon \
    TelecommResCommon \
    TelephonyResCommon \
    WifiResCommon

PRODUCT_PACKAGES += \
    AospWifiResOverlayMondrianChina \
    AospWifiResOverlayMondrianGlobal \
    SettingsOverlayGlobal \
    SettingsOverlayChina \
    SettingsProviderOverlayChina \
    SettingsProviderOverlayGlobal

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
#PRODUCT_BUILD_SUPER_PARTITION := true

# Parts
PRODUCT_PACKAGES += \
    XiaomiParts

# Perf
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0 \
    libavservices_minijail \
    libtflite \
    vendor.qti.hardware.perf@2.3

# Permissions
PRODUCT_COPY_FILES += \
    device/xperience/common/system/permissions/privapp-permissions-qti.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-qti.xml \
    device/xperience/common/system/permissions/qti_whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/qti_whitelist.xml \
    device/xperience/common/system/public.libraries.system_ext-qti.txt:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/public.libraries-qti.txt

# Platform
TARGET_BOARD_PLATFORM := taro

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service

# Properties
include $(DEVICE_PATH)/configs/properties/default.mk

# RIL
PRODUCT_PACKAGES += \
    Ims \
    QtiTelephony \
    qti-telephony-common

TARGET_BOARD_PLATFORM := taro

# QC common
TARGET_COMMON_QTI_COMPONENTS := \
    adreno \
    alarm \
    audio \
    av \
    bt \
    display \
    init \
    media \
    nfc \
    overlay \
    perf \
    telephony \
    usb \
    wfd \
    wlan

# Radio
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.data.iwlan.enable=true \
    persist.vendor.radio.add_power_save=1 \
    persist.vendor.radio.dynamic_sar=1

# Ring
PRODUCT_PACKAGES += \
    RingServiceMondrian

# Rootdir
PRODUCT_PACKAGES += \
    init.recovery.qcom.rc \
    init.qcom.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH) \
    device/xiaomi/mondrian-kernel \
    hardware/gsi

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.1-service.multihal \
    libsensorndkbridge

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.sensors.enable.mag_filter=true

# Storage
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.fuse.passthrough.enable=true

# Speed profile services and wifi-service to reduce RAM and storage
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0-service.qti-v2

# TrustedUI
PRODUCT_PACKAGES += \
    android.hidl.memory.block@1.0.vendor \
    vendor.qti.hardware.systemhelper@1.0.vendor

# Telephony
PRODUCT_PACKAGES += \
    extphonelib \
    extphonelib-product \
    extphonelib.xml \
    extphonelib_product.xml \
    ims-ext-common \
    ims_ext_common.xml \
    qti-telephony-hidl-wrapper \
    qti-telephony-hidl-wrapper-prd \
    qti_telephony_hidl_wrapper.xml \
    qti_telephony_hidl_wrapper_prd.xml \
    qti-telephony-utils \
    qti-telephony-utils-prd \
    qti_telephony_utils.xml \
    qti_telephony_utils_prd.xml \
    telephony-ext

# Update engine
PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# USAP Pool
PRODUCT_SYSTEM_PROPERTIES += \
    persist.device_config.runtime_native.usap_pool_enabled=true

# USB
PRODUCT_ODM_PROPERTIES += \
    vendor.usb.use_gadget_hal=0

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.usb.config=mtp,adb
endif

# VNDK
PRODUCT_COPY_FILES += \
    prebuilts/vndk/v32/arm64/arch-arm64-armv8-a/shared/vndk-sp/libutils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libutils-v32.so

# Verified Boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml

# Vibrator
$(call inherit-product, hardware/xiaomi/aidl/vibrator/vibrator-vendor-product.mk)
