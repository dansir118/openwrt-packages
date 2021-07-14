# Copyright (C) 2019 Openwrt.org
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-smartinfo
PKG_VERSION=3.2
PKG_RELEASE:=2

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  DEPENDS:=+smartmontools
  TITLE:=LuCI support for Smartinfo
  PKGARCH:=all
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/smartinfo
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d $(1)/etc/config $(1)/usr/lib/lua/luci $(1)/usr/lib/smartinfo
	$(CP) ./luasrc/* $(1)/usr/lib/lua/luci
	$(INSTALL_CONF) ./root/etc/config/smartinfo $(1)/etc/config
	$(INSTALL_BIN) ./root/etc/init.d/smartinfo $(1)/etc/init.d
	$(INSTALL_BIN) ./root/usr/lib/smartinfo/* $(1)/usr/lib/smartinfo/
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./root/etc/uci-defaults/* $(1)/etc/uci-defaults/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	po2lmo ./po/zh-cn/smartinfo.po $(1)/usr/lib/lua/luci/i18n/smartinfo.zh-cn.lmo
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
