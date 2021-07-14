module("luci.controller.ddnsto",package.seeall)
function index()
if not nixio.fs.access("/etc/config/ddnsto")then
  return
end
entry({"admin","services","ddnsto"},
cbi("ddnsto/global"),
_("DDNSTO 内网穿透"),5).dependent=true

end
