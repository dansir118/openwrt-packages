require("luci.sys")
require("luci.util")
require("luci.model.ipkg")
local uci = require "luci.model.uci".cursor()
local state=(luci.sys.call("pgrep axel >/dev/null") == 0)

if state then
	state_msg = "<b><font color=\"green\">" .. translate("Axel 正在运行") .. "</font></b>"
else
	state_msg = "<b><font color=\"red\">" .. translate("Axel 没有运行") .. "</font></b>"
end

local s=luci.sys.exec("HOME=/tmp axel --version | awk '/Axel/{print $2}'")
m = Map("axel", "Axel", translate("axel 是一个支持HTTP，HTTPS，FTP和FTPS协议不错的高速下载工具。支持多线程下载、断点续传，且可以从多个地址或者从一个地址的多个连接来下载同一个文件。适合网速不给力时多线程下载提高下载速度。") .. "<br/><br/>" .. translate("运行状态 : ") .. state_msg .. "<br/><br/>")

t = m:section(NamedSection,"main", "axel")
t:tab("basic",translate("Basic Settings"))
e=t:taboption("basic",Flag,"enabled",translate("启用"),"%s  %s"%{translate(""),"<b style=\"color:green\">"..translatef("当前Axel的版本: %s",s).."</b>"})
e=t:taboption("basic",Value,"SavePath",translate("保存路径"),translate("下载文件的保存路径。例如：<code>/mnt/sda1/download</code>"))
e.placeholder="/tmp/download"

return m