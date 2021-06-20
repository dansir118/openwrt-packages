# K-QoS for OpenWRT/Lede

![](https://img.shields.io/badge/license-GPLV3-brightgreen.svg?style=plastic "License")

# Features
* Support speed limit based on IP address
* No marking by iptables
* Support LuCI interface

# Install to OpenWRT/LEDE
	
	git clone https://github.com/kongfl888/luci-app-kqos
	cp -r luci-app-kqos LEDE_DIR/package/kqos
	
	make menuconfig # select kqos

	make package/kqos/compile V=s

# Thanks

[lwxlwxlwx/eqos](https://github.com/lwxlwxlwx/eqos)
