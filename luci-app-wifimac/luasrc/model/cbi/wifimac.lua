local fs = require "nixio.fs"
local http = luci.http
require("luci.sys")
local sys   = require "luci.sys"
local uci = luci.model.uci.cursor()
local ip   = require "luci.ip"
local util = require "luci.util"

m = Map("wifimac", translate("WIFI MAC 地址修改"))

s=m:section(NamedSection, "wifimac")
--s.addremove = true
s.anonymous = true

--
o2=s:option(Value,"mac2",translate("2G MAC地址"))
--o2.rmempty = false
--o2.optional = false
o2.datatype = "macaddr"

o5=s:option(Value,"mac5",translate("5G MAC地址"))
--o5.rmempty = false
--o5.optional = false
o5.datatype = "macaddr"

--[[
function add_mac(macaddr)
    local mac = util.split(macaddr, ":")
    mac[1] = tonumber(mac[1]) + 2;
    return string.format("%02x:%02x:%02x:%02x:%02x:%02x",mac[1],mac[2],mac[3],mac[4],mac[5],mac[6])
end

function rewrite_mac(macaddr)
	uci:load("wireless")
	uci:foreach("wireless","wifi-iface", 
		function(s)
		    if s.device == 'radio0' then
			    if s.mode == 'ap' then
				s.macaddr = macaddr
			    elseif s.mode == 'sta' then
				s.macaddr = macaddr
			    end
		    elseif s.device == 'radio1' then
			    if s.mode == 'ap' then
				s.macaddr = macaddr
			    elseif s.mode == 'sta' then
				s.macaddr = macaddr
			    end
		    end
	
	end)
	uci:commit("wireless")
	uci:unload("wireless")
end

function o2.write(self, section, value)
	Value.write(self, section, value)
end

function o5.write(self, section, value)
	Value.write(self, section, value)
end
--]]
----------------------------------------------------------------------------------------
local e=luci.http.formvalue("cbi.apply")
if e then
	io.popen("/usr/bin/wifimac")
end

return m
