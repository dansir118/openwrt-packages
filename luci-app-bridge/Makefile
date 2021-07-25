
# Copyright (C) 2016 Openwrt.org
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-bridge
PKG_VERSION:=2.0
LUCI_TITLE:=Luci for support bridge
LUCI_DEPENDS:=+ip-bridge +kmod-nft-bridge +kmod-br-netfilter

define Package/luci-app-bridge/conffiles
/etc/bridge/network
/etc/bridge/firewall
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
