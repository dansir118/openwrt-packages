module("luci.controller.kqos", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/kqos") then
		return
	end

	entry({"admin", "network", "kqos"}, cbi("kqos"), _("网速控制"), 61)
end
