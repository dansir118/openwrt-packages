module("luci.controller.smartinfo",package.seeall)
function index()
require("luci.i18n")
if not nixio.fs.access("/etc/config/smartinfo")then
return
end
local e=entry({"admin","nas","smartinfo"},cbi("smartinfo"),_("S.M.A.R.T Info"))
e.i18n="smartinfo"
e.dependent=true
entry({"admin","nas","smartinfo","smartdetail"},call("smart_detail")).leaf=true
entry({"admin","nas","smartinfo","status"},call("smart_status")).leaf=true
entry({"admin","nas","smartinfo","run"},call("run_smart")).leaf=true
entry({"admin","nas","smartinfo","smartattr"},call("smart_attr")).leaf=true
end
function smart_status()
local o=io.popen("/usr/lib/smartinfo/smart_status.sh")
if o then
local i={}
while true do
local e=o:read("*l")
if not e then
break
elseif e:match("^/%l+/%l+:%a+")then
local e,t=e:match("^/%l+/(%l+):(%a+)")
local o,a
if(t=="OK"or t=="Failed"or t=="Unsupported")then
o="%s %s"%{nixio.fs.readfile("/sys/class/block/%s/device/vendor"%e),nixio.fs.readfile("/sys/class/block/%s/device/model"%e)}
local e=tonumber((nixio.fs.readfile("/sys/class/block/%s/size"%e)))
a="%s MB"%{e and math.floor(e/2048)}
else
o="Unavailabled"
a="Unavailabled"
end
if e and t then
i[#i+1]={
name=e,
model=o,
size=a,
status=t
}
end
else
end
end
o:close()
luci.http.prepare_content("application/json")
luci.http.write_json(i)
end
end
function run_smart(e)
local e=io.popen("smartctl --attributes -d sat /dev/%s"%e)
if e then
local t={}
local a=e:read("*all")
t={
out=a
}
e:close()
luci.http.prepare_content("application/json")
luci.http.write_json(t)
end
end
function smart_detail(e)
luci.template.render("smartinfo/smart_detail",{dev=e})
end
function smart_attr(e)
local t=io.popen("smartctl --attributes -d sat /dev/%s"%e)
if t then
local a={}
while true do
local e=t:read("*l")
if not e then
break
elseif e:match("^.*%d+%s+.+%s+.+%s+.+%s+.+%s+.+%s+.+%s+.+%s+.+%s+.+")then
local e,h,s,i,o,n,t,r,d=e:match("^%s*(%d+)%s+([%a%p]+)%s+(%w+)%s+(%d+)%s+(%d+)%s+(%d+)%s+([%a%p]+)%s+(%a+)%s+[%w%p]+%s+(.+)")
e="%x"%e
if not e:match("^%w%w")then
e="0%s"%e
end
a[#a+1]={
id=e:upper(),
attrbute=h,
flag=s,
value=i,
worst=o,
thresh=n,
type=t,
updated=r,
raw=d
}
else
end
end
t:close()
luci.http.prepare_content("application/json")
luci.http.write_json(a)
end
end
