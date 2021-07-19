module("luci.controller.axel", package.seeall)

function index()
	local fs = require "nixio.fs"
	if not nixio.fs.access("/etc/config/axel") then
		return
	end
	entry({"admin", "nas", "axel"}, cbi("axel"), _("axel"), 20).dependent = true
end
