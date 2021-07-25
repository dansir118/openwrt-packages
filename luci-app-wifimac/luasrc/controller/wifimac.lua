module("luci.controller.wifimac", package.seeall)

function index()
	entry({"admin", "network", "wifimac"}, cbi("wifimac"),_("WIFI MAC地址修改"), 20)
end

