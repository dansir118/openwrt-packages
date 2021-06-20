# [K] 2020
# kongfl888 <https://github.com/kongfl888/>

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-kqos
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_MAINTAINER:=kongfl888 K <kongfl888@outlook.com>

LUCI_TITLE:=KQOS - LuCI interface
LUCI_DEPENDS:=+tc +kmod-sched-core +kmod-ifb
LUCI_PKGARCH:=all

define Package/luci-app-kqos/conffiles
/etc/config/kqos
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
