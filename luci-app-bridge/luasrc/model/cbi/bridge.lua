m=Map("bridge", translate("透明网桥"),
translate("<font color=\"green\">让路由器成为与上级路由器通信、无感知、并具备防火墙功能的透明网桥设备。</font><br><br><font color=orange>✯</font>适用于有上级路由器，需要当前路由器的一些功能但又不想多级NAT的网络环境。<br><font color=orange>✯</font>启用透明网桥后当前路由器的WEB管理地址为网桥IP。<br><font color=orange>✯</font>启用透明网桥后当前路由器上的一些功能会失效，如：Full Cone、多拨等。<br><font color=orange>✯</font>关闭后恢复插件安装时的网络设置，WEB管理地址恢复为原始设置的IP。"))

m:section(SimpleSection).template  = "bridge/bridge_status"

s = m:section(TypedSection, "bridge")
s.addremove = false
s.anonymous = true

o = s:option(Flag, "enabled", translate("开启透明网桥"))
o.rmempty = false

o = s:option(Value, "ipaddr", translate("网桥IP"), translate("与主路由同网段且没有冲突的IP地址"))
o.default = "192.168.2.150"
o.anonymous = false

o = s:option(Value, "gateway", translate("网关IP"), translate("与主路由IP地址相同"))
o.default = "192.168.2.1"
o.anonymous = false
o = s:option(Value, "netmask", translate("子网掩码"))
o.default = "255.255.255.0"
o.anonymous = false

o = s:option(Value, "network", translate("网口数量"), translate("路由器物理网口数量，留空则自动获取"))
o.anonymous = false

ignore = s:option(ListValue, "dhcp", translate("DHCP设置"), translate("设定LAN口DHCP自动获取IP服务"))
ignore:value("0", translate("关闭DHCP自动获取IP服务"))
ignore:value("1", translate("强制DHCP自动获取IP服务"))
ignore.default = ignore

firewall = s:option(Flag, "firewall", translate("防火墙设置"))
firewall.rmempty = true

fullcone = s:option(Flag, "fullcone", translate("SYN-flood"), translate("关闭防火墙ISYN-flood防御服务"))
fullcone:depends("firewall", true)
fullcone.rmempty = true

syn_flood = s:option(Flag, "syn_flood", translate("FullCone-NAT"), translate("关闭防火墙IFullCone-NAT服务"))
syn_flood:depends("firewall", true)
syn_flood.rmempty = true

masq = s:option(Flag, "masq", translate("IP动态伪装"), translate("开启防火墙IP动态伪装IP服务"))
masq:depends("firewall", true)
masq.rmempty = true

return m
