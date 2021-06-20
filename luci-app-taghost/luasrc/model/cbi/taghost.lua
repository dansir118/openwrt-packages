local sys = require "luci.sys"
local ifaces = sys.net:devices()
local log = luci.util.perror
local uci = require("luci.model.uci").cursor()


m = Map("dhcp", translate("Tag your device"),
        translatef("给设备绑定tag以指定不同网关、dns服务器等DHCP option。"))



-- device list 
devices = m:section(TypedSection, "host", translate("1、给设备绑定tag"))
devices.template = "cbi/tblsection"
devices.anonymous = true
devices.addremove = true

a = devices:option(Value, "name", translate("设备名"))
a.datatype = "string"
a.optional = false

a = devices:option(Value, "mac", translate("MAC 地址"))
a.datatype = "macaddr"
a.optional = false
luci.ip.neighbors({family = 4}, function(neighbor)
        if neighbor.reachable then
                a:value(neighbor.mac, "%s (%s)" %{neighbor.mac, neighbor.dest:string()})
        end
end)

a = devices:option(Value, "tag", translate("设备tag"))
a.datatype = "string"
a.optional = false

uci:foreach("dhcp","tag",
        function(i)
                -- log(i['.name'])
                a:value(i['.name'])
        end)

-- dhcp section
t = m:section(TypedSection, "tag", translate("2、输入绑定好的“设备tag”添加且配置相应的DHCP option"))
t.addremove = true
t.anonymous = false

a = t:option(DynamicList, "dhcp_option", translate("DHCP option"), translate("例如设定 \"<code>3,192.168.1.1</code>\" 表示通告该设备的网关为192.168.1.1<br />设定 \"<code>6,223.5.5.5,223.6.6.6</code>\" 表示通告该设备的dns服务器为223.5.5.5,223.6.6.6") )
a.optional = false
a.datatype = "string"

return  m

