module("luci.controller.cowbbonding", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/cowbbonding") then
		return
	end
	
	local page

	page = entry({"admin", "network", "cowbbonding"}, cbi("cowbbonding"), "静态DHCP/ARP批量绑定", 35)
	page.dependent = true
end


