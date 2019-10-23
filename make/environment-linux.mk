#
# set up linux environment for other makefiles
#
# -----------------------------------------------------------------------------

# translate toolchain arch to kernel arch
ifeq ($(BOXARCH), arm)
KERNEL_ARCH = arm
else ifeq ($(BOXARCH), aarch64)
KERNEL_ARCH = arm64
else ifeq ($(BOXARCH), mips)
KERNEL_ARCH = mips
endif

# -----------------------------------------------------------------------------

KERNEL_OBJ         = linux-$(KERNEL_VER)-kernel-obj
KERNEL_OBJ_DIR     = $(BUILD_DIR)/$(KERNEL_OBJ)
KERNEL_MODULES     = linux-$(KERNEL_VER)-modules
KERNEL_MODULES_DIR = $(BUILD_DIR)/linux-$(KERNEL_VER)-modules/lib/modules/$(KERNEL_VER)
TARGET_MODULES_DIR = $(TARGET_DIR)/lib/modules/$(KERNEL_VER)

KERNEL_OUTPUT      = $(KERNEL_OBJ_DIR)/arch/$(KERNEL_ARCH)/boot/$(KERNEL_IMAGE_TYPE)
KERNEL_INPUT_DTB   = $(KERNEL_OBJ_DIR)/arch/$(KERNEL_ARCH)/boot/dts/$(KERNEL_DTB_VER)
KERNEL_OUTPUT_DTB  = $(KERNEL_OBJ_DIR)/arch/$(KERNEL_ARCH)/boot/zImage_dtb

# -----------------------------------------------------------------------------

depmod:
	PATH=$(PATH):/sbin:/usr/sbin depmod -b $(TARGET_DIR) $(KERNEL_VER)

KERNEL_MAKEVARS = \
	ARCH=$(KERNEL_ARCH) \
	CROSS_COMPILE=$(TARGET_CROSS) \
	INSTALL_MOD_PATH=$(BUILD_DIR)/$(KERNEL_MODULES) \
	O=$(KERNEL_OBJ_DIR)

# Compatibility variables
KERNEL_MAKEVARS += \
	KDIR=$(KERNEL_DIR) \
	KSRC=$(KERNEL_DIR) \
	SRC=$(KERNEL_DIR) \
	KERNDIR=$(KERNEL_DIR) \
	KERNELDIR=$(KERNEL_DIR) \
	KERNEL_SRC=$(KERNEL_DIR) \
	KERNEL_SOURCE=${KERNEL_DIR} \
	LINUX_SRC=$(KERNEL_DIR) \
	KVER=$(KERNEL_VER) \
	KERNEL_VERSION=$(KERNEL_VER)

# -----------------------------------------------------------------------------

#
# gfutures
#
ifeq ($(BOXMODEL), $(filter $(BOXMODEL), bre2ze4k hd51 hd60 hd61))
ifeq ($(BOXMODEL), bre2ze4k)
KERNEL_VER         = 4.10.12
KERNEL_PATCH       = $(BRE2ZE4K_PATCH)
MTD_BLACK          = mmcblk0
MTD_BOOTFS         = mmcblk0p1
endif
ifeq ($(BOXMODEL), hd51)
KERNEL_VER         = 4.10.12
KERNEL_PATCH       = $(HD51_PATCH)
MTD_BLACK          = mmcblk0
MTD_BOOTFS         = mmcblk0p1
endif
ifeq ($(BOXMODEL), hd60)
KERNEL_VER         = 4.4.35
KERNEL_DATE        = 20181228
KERNEL_PATCH       = $(HD60_PATCH)
MTD_BLACK          = mmcblk0
MTD_BOOTFS         = mmcblk0p4
endif
ifeq ($(BOXMODEL), hd61)
KERNEL_VER         = 4.4.35
KERNEL_DATE        = 20181228
KERNEL_PATCH       = $(HD61_PATCH)
MTD_BLACK          = mmcblk0
MTD_BOOTFS         = mmcblk0p4
endif
KERNEL_CONFIG      = $(BOXMODEL)_defconfig
ifeq ($(BOXMODEL), $(filter $(BOXMODEL), bre2ze4k hd51))
KERNEL_IMAGE_TYPE  = zImage
KERNEL_SOURCE      = linux-$(KERNEL_VER)-arm.tar.gz
else
KERNEL_IMAGE_TYPE  = uImage
KERNEL_SOURCE      = linux-$(KERNEL_VER)-$(KERNEL_DATE)-arm.tar.gz
endif
ifeq ($(BOXMODEL), $(filter $(BOXMODEL), bre2ze4k hd51))
KERNEL_DTB_VER     = bcm7445-bcm97445svmb.dtb
else
KERNEL_DTB_VER     = hi3798mv200.dtb
endif
KERNEL_URL         = http://downloads.mutant-digital.net
KERNEL_DIR         = $(BUILD_DIR)/linux-$(KERNEL_VER)
endif

#
# vuplus
#
ifeq ($(BOXMODEL), $(filter $(BOXMODEL), vuduo vuduo4k vusolo4k vuultimo4k vuuno4k vuuno4kse vuzero4k))
ifeq ($(BOXMODEL), vuduo)
KERNEL_VER         = 3.9.6
KERNEL_PATCH       = $(VUDUO_PATCH)
MTD_BLACK          = $(EMPTY)
MTD_BOOTFS         = $(EMPTY)
endif
ifeq ($(BOXMODEL), vuduo4k)
KERNEL_VER         = 4.1.45-1.17
KERNEL_SOURCE_VER  = 4.1-1.17
KERNEL_PATCH       = $(VUDUO4K_PATCH)
MTD_BLACK          = mmcblk0
MTD_BOOTFS         = mmcblk0p6
endif
ifeq ($(BOXMODEL), vusolo4k)
KERNEL_VER         = 3.14.28-1.8
KERNEL_SOURCE_VER  = 3.14-1.8
KERNEL_PATCH       = $(VUSOLO4K_PATCH)
MTD_BLACK          = mmcblk0
MTD_BOOTFS         = mmcblk0p1
endif
ifeq ($(BOXMODEL), vuultimo4k)
KERNEL_VER         = 3.14.28-1.12
KERNEL_SOURCE_VER  = 3.14-1.12
KERNEL_PATCH       = $(VUULTIMO4K_PATCH)
MTD_BLACK          = mmcblk0
MTD_BOOTFS         = mmcblk0p1
endif
ifeq ($(BOXMODEL), vuuno4k)
KERNEL_VER         = 3.14.28-1.12
KERNEL_SOURCE_VER  = 3.14-1.12
KERNEL_PATCH       = $(VUUNO4K_PATCH)
MTD_BLACK          = mmcblk0
MTD_BOOTFS         = mmcblk0p1
endif
ifeq ($(BOXMODEL), vuuno4kse)
KERNEL_VER         = 4.1.20-1.9
KERNEL_SOURCE_VER  = 4.1-1.9
KERNEL_PATCH       = $(VUUNO4KSE_PATCH)
MTD_BLACK          = mmcblk0
MTD_BOOTFS         = mmcblk0p1
endif
ifeq ($(BOXMODEL), vuzero4k)
KERNEL_VER         = 4.1.20-1.9
KERNEL_SOURCE_VER  = 4.1-1.9
KERNEL_PATCH       = $(VUZERO4K_PATCH)
MTD_BLACK          = mmcblk0
MTD_BOOTFS         = mmcblk0p4
endif
ifeq ($(VU_MULTIBOOT), 1)
KERNEL_CONFIG      = $(BOXMODEL)_defconfig_multi
else
KERNEL_CONFIG      = $(BOXMODEL)_defconfig
endif
ifeq ($(BOXMODEL), vuduo)
KERNEL_IMAGE_TYPE  = vmlinux
KERNEL_SOURCE      = stblinux-$(KERNEL_VER).tar.bz2
else
KERNEL_IMAGE_TYPE  = zImage
KERNEL_SOURCE      = stblinux-${KERNEL_SOURCE_VER}.tar.bz2
endif
KERNEL_DTB_VER     =
KERNEL_URL         = http://archive.vuplus.com/download/kernel
KERNEL_DIR         = $(BUILD_DIR)/linux
endif

#
# edision
#
ifeq ($(BOXMODEL), $(filter $(BOXMODEL), osmio4k osmio4kplus))
ifeq ($(BOXMODEL), osmio4k)
KERNEL_VER         = 5.3.0
KERNEL_SOURCE_VER  = 5.3
KERNEL_PATCH       = $(OSMIO4KPLUS_PATCH)
MTD_BLACK          = mmcblk1
MTD_BOOTFS         = mmcblk1p1
endif
ifeq ($(BOXMODEL), osmio4kplus)
KERNEL_VER         = 5.3.0
KERNEL_SOURCE_VER  = 5.3
KERNEL_PATCH       = $(OSMIO4KPLUS_PATCH)
MTD_BLACK          = mmcblk1
MTD_BOOTFS         = mmcblk1p1
endif
KERNEL_CONFIG      = $(BOXMODEL)_defconfig
KERNEL_IMAGE_TYPE  = Image.gz
KERNEL_SOURCE      = linux-edision-$(KERNEL_SOURCE_VER).tar.gz
KERNEL_DTB_VER     =
KERNEL_URL         = http://source.mynonpublic.com/edision
KERNEL_DIR         = $(BUILD_DIR)/linux-brcmstb-$(KERNEL_SOURCE_VER)
endif

$(ARCHIVE)/$(KERNEL_SOURCE):
	$(DOWNLOAD) $(KERNEL_URL)/$(KERNEL_SOURCE)
