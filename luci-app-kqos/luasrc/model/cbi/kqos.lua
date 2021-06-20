local ipc = require "luci.ip"
local sys = require "luci.sys"
local fs=require"nixio.fs"

local m = Map("kqos", translate("网络限速控制"))
m.description = translate("简单的QOS服务及内网客户端的联网限速")

local s = m:section(TypedSection, "kqos", "")
s.anonymous = true

local e = s:option(Flag, "enabled", translate("启用"))
e.rmempty = false

local dl = s:option(Value, "download", translate("总下载带宽 (M)"))
dl.datatype = "and(uinteger,min(1))"

local ul = s:option(Value, "upload", translate("总上传带宽 (M)"))
ul.datatype = "and(uinteger,min(1))"

s = m:section(TypedSection, "device", translate("IP 限速"))
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true
s.sortable  = true

local ip = s:option(Value, "ip", translate("IP 地址"))

ipc.neighbors({family = 4, dev = "br-lan"}, function(n)
	if n.mac and n.dest then
		ip:value(n.dest:string(), "%s (%s)" %{ n.dest:string(), n.mac })
	end
end)

dl = s:option(Value, "download", translate("下载带宽 (M)"))
dl.datatype = "and(uinteger,min(1))"

ul = s:option(Value, "upload", translate("上传带宽 (M)"))
ul.datatype = "and(uinteger,min(1))"

comment = s:option(Value, "comment", translate("备注"))

local apply =luci.http.formvalue("cbi.apply")
if apply then
    if sys.init.index("kqos") then
        fs.chmod("/etc/init.d/kqos", 755)
        if not sys.init.enabled("kqos") then
            sys.init.enable("kqos")
        end
        sys.call("/etc/init.d/kqos restart &")
    end
end

return m
