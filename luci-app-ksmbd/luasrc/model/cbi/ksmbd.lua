-- Licensed to the public under the Apache License 2.0.

m = Map("ksmbd", translate("Network Shares (KSMBD)"))

s = m:section(TypedSection, "globals", translate("KSMBD is an opensource In-kernel SMB1/2/3 server"), translate("<b><font color=\"green\">增加用户和密码在TTYD中输入命令:ksmbd.adduser -a 用户名</font>"))
s.anonymous = true

s:tab("general",  translate("General Settings"))
s:tab("template", translate("Edit Template"))


-- s.taboption('general', NetworkSelect, 'interface', translate('Interface'),translate('Listen only on the given interface or, if unspecified, on lan'))

o=s:taboption("general", Value, "workgroup", translate("Workgroup"))
o.placeholder = 'WORKGROUP'

o=s:taboption("general", Value, "description", translate("Description"))
o.placeholder = 'Ksmbd on OpenWrt'

h = s:taboption("general", Flag, "homes", translate("Share home-directories"),
        translate("Allow system users to reach their home directories via " ..
                "network shares"))
h.rmempty = false

a = s:taboption("general", Flag, "autoshare", translate("Auto Share"),
        translate("Auto share local disk which connected"))
a.rmempty = false
a.default = "no"

tmpl = s:taboption("template", Value, "_tmpl",
	translate("Edit the template that is used for generating the ksmbd configuration."), 
	translate("This is the content of the file '/etc/ksmbd/smb.conf.template' from which your ksmbd configuration will be generated. \
			Values enclosed by pipe symbols ('|') should not be changed. They get their values from the 'General Settings' tab."))

tmpl.template = "cbi/tvalue"
tmpl.rows = 20

function tmpl.cfgvalue(self, section)
	return nixio.fs.readfile("/etc/ksmbd/smb.conf.template")
end

function tmpl.write(self, section, value)
	value = value:gsub("\r\n?", "\n")
	nixio.fs.writefile("/etc/ksmbd/smb.conf.template", value)
end


s = m:section(TypedSection, "share", translate("Shared Directories")
  , translate("Please add directories to share. Each directory refers to a folder on a mounted device."))
s.anonymous = true
s.addremove = true
s.template = "cbi/tblsection"

e = s:option(Flag, "auto", translate("enable"))
e.rmempty = false
e.default = 'yes'

s:option(Value, "name", translate("Name"))
pth = s:option(Value, "path", translate("Path"))
if nixio.fs.access("/etc/config/fstab") then
        pth.titleref = luci.dispatcher.build_url("admin", "system", "fstab")
end

br = s:option(Flag, "browseable", translate("Browseable"))
br.default = "yes"
br.enabled = "yes"
br.disabled = "no"

ro = s:option(Flag, "read_only", translate("Read-only"))
ro.enabled = "yes"
ro.disabled = "no"
ro.default = 'no'
ro.rmempty = false

fr = s:option(Flag, "force_root", translate("Force Root"))
fr.rmempty = false
fr.default = "yes"

s:option(Value, "users", translate("Allowed users")).rmempty = true


go = s:option(Flag, "guest_ok", translate("Allow guests"))
go.rmempty = false
go.enabled = "yes"
go.disabled = "no"
go.default = "yes"

o = s:option(Flag, "inherit_owner", translate("Inherit owner"))
o.enabled = 'yes';
o.disabled = 'no';
o.default = 'no';

o = s:option(Flag, "hide_dot_files", translate("Hide dot files"))
o.enabled = 'yes';
o.disabled = 'no';
o.default = 'yes';

cm = s:option(Value, "create_mask", translate("Create mask"))
cm.default = '0666'
cm.rmempty = true
cm.size = 4
cm.placeholder = "0666"

dm = s:option(Value, "dir_mask", translate("Directory mask"))
dm.default = '0777'
dm.rmempty = true
dm.size = 4
dm.placeholder = "0777"

local e=luci.http.formvalue("cbi.apply")
if e then
  luci.sys.call("/etc/init.d/ksmbd restart")
end

return m

