local e=require"nixio.fs"
local state_msg = ""
local running=(luci.sys.call("pgrep /usr/bin/ddnsto >/dev/null")==0)
if running then
  state_msg = "<font color=\"green\">" .. translate("已运行") .. "</font>"
else
  state_msg = "<font color=\"red\">" .. translate("未运行") .. "</font>"
end
m=Map("ddnsto",translate("DDNSTO 内网穿透"))
m.description = translate("DDNSTO是koolshare小宝开发支持HTTP2.0快速远程穿透的工具。") .. 
translate("<br><br><input class=\"cbi-button cbi-button-apply\" type=\"button\" value=\"" .. 
translate("注册与教程") ..
"\" onclick=\"window.open('https://www.ddnsto.com')\"/>") ..
"<br><br><b>" .. translate("运行状态：") .. state_msg .. "</b>"

t=m:section(TypedSection,"global",translate("设置"))
t.anonymous=true
t.addremove=false

e=t:option(Flag,"enable",translate("启用"))
e.default=0
e.rmempty=false

e=t:option(Value,"token",translate('ddnsto 令牌'))
e.password=true
e.rmempty=false

e=t:option(Value,"start_delay",translate("延迟启动"),translate("单位：秒"))
e.datatype="uinteger"
e.default="0"
e.rmempty=true

return m
