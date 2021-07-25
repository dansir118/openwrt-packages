-- Licensed to the public under the Apache License 2.0.

module("luci.controller.ksmbd", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/ksmbd") then
		return
	end

    entry({"admin", "control", "ksmbd"}, cbi("ksmbd"), _("网络共享"), 90).dependent = true

end

