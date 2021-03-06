include $(TOPDIR)/rules.mk

PKG_NAME:=oscam
PKG_VERSION:=11429
PKG_REV:=8e7c47b
PKG_RELEASE:=1

PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_REV).tar.gz
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/nx111/oscam.git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_MAINTAINER:=OSCam developers <unknown>
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=COPYING


PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/oscam
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libopenssl +libusb-1.0 +kmod-usb-ohci +kmod-usb-serial +kmod-usb-serial-ch341 +kmod-usb-serial-cp210x +kmod-usb-serial-ftdi +kmod-usb-serial-pl2303 +kmod-usb-uhci +kmod-usb2 +libpcsclite +pcscd +ccid
  TITLE:=OSCam is an Open Source Conditional Access Module software
  URL:=http://www.streamboard.tv/oscam/
endef

define Package/oscam/description
  OSCam is an Open Source Conditional Access Module software,
  based on the very good MpCS version 0.9d created by ​dukat.
endef

define Package/oscam/conffiles
/etc/oscam/oscam.conf
/etc/oscam/oscam.server
/etc/oscam/oscam.user
/etc/oscam/SoftCam.Key
/etc/oscam/oscam.dvbapi
endef

CONFIGURE_CMD = ./config.sh
CONFIGURE_ARGS = \
	--enable all

MAKE_FLAGS += \
	CONF_DIR=/etc/oscam \
	OSCAM_BIN=Distribution/oscam \
        USE_SSL=1 \
	USE_LIBUSB=1 \
	USE_PCSC=1 \
	USE_LIBCRYPTO=1 


define Package/oscam/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/Distribution/oscam $(1)/usr/bin/oscam

#	$(INSTALL_DIR) $(1)/etc/init.d
#	$(INSTALL_BIN) ./files/oscam.init $(1)/etc/init.d/oscam

	$(INSTALL_DIR) $(1)/etc/oscam
	$(INSTALL_CONF) ./files/oscam.conf $(1)/etc/oscam
	$(INSTALL_CONF) ./files/oscam.server $(1)/etc/oscam
	$(INSTALL_CONF) ./files/oscam.user $(1)/etc/oscam
	$(INSTALL_CONF) ./files/oscam.dvbapi $(1)/etc/oscam


endef


define Package/$(PKG_NAME)/prerm
	#!/bin/sh
	# if run within buildroot exit
	[ -n "$${IPKG_INSTROOT}" ] && exit 0

	# stop running scripts
	/etc/init.d/oscam disable
	/etc/init.d/oscam stop

	exit 0
endef

$(eval $(call BuildPackage,oscam))
