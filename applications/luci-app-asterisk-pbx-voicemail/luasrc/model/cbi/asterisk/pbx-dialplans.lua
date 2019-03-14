--[[
    Copyright 2018 Edits by Plasmodium

    Copyright 2011 Iordan Iordanov <iiordanov (AT) gmail.com>

    This file is part of luci-pbx.

    luci-pbx is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    luci-pbx is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with luci-pbx.  If not, see <http://www.gnu.org/licenses/>.

-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Copyright 2008-2013 Jo-Philipp Wich <jow@openwrt.org>
-- Licensed to the public under the Apache License 2.0.
]]--

if     nixio.fs.access("/etc/init.d/asterisk")   then
   server = "asterisk"
else
   server = ""
end

local fs = require "nixio.fs"
local extefile = "/etc/asterisk/extensions.conf"
local defafile = "/etc/asterisk/extensions_default.conf"
local incofile = "/etc/asterisk/extensions_incoming.conf"
local userfile = "/etc/asterisk/extensions_user.conf"
local voicfile = "/etc/asterisk/extensions_voicemail.conf"
-- local ingtfile = "/etc/asterisk/extensions_incoming_gtalk.conf"
local bklsfile = "/etc/asterisk/extensions_blacklist.conf"
local clthfile = "/etc/asterisk/extensions_callthrough.conf"
local clbkfile = "/etc/asterisk/extensions_callback.conf"


f = SimpleForm("EditMe")

t = f:field(TextValue, "main")
t.rmempty = true
t.rows = 6
function t.cfgvalue()
	if     nixio.fs.access(extefile)   then
   		return fs.readfile(extefile) or ""
	else
   		return "No File No Party, please reload config.\n"
	end
end

u = f:field(TextValue, "default")
u.rmempty = true
u.rows = 10
function u.cfgvalue()
	return fs.readfile(defafile) or ""
end

v = f:field(TextValue, "incoming")
v.rmempty = true
v.rows = 10
function v.cfgvalue()
	return fs.readfile(incofile) or ""
end

w = f:field(TextValue, "user")
w.rmempty = true
w.rows = 10
function w.cfgvalue()
	return fs.readfile(userfile) or ""
end

y = f:field(TextValue, "voicemail")
y.rmempty = true
y.rows = 4
function y.cfgvalue()
	return fs.readfile(voicfile) or ""
end

x = f:field(TextValue, "blklist")
x.rmempty = true
x.rows = 10
function x.cfgvalue()
	return fs.readfile(bklsfile) or ""
end

z = f:field(TextValue, "clthgh")
z.rmempty = true
z.rows = 4
function z.cfgvalue()
	return fs.readfile(clthfile) or ""
end

s = f:field(TextValue, "clbck")
s.rmempty = true
s.rows = 4
function s.cfgvalue()
	return fs.readfile(clbkfile) or ""
end

-- r = f:field(TextValue, "gtalk")
-- r.rmempty = true
-- r.rows = 10
-- function r.cfgvalue()
-- 	return fs.readfile(ingtfile) or ""
-- end

-- function f.handle(self, state, data)
--  	if state == FORM_VALID then
--  		if data.regst then
--  			fs.writefile(regsfile, data.regst:gsub("\r\n", "\n"))
-- 
-- 			luci.sys.call("/etc/init.d/pbx-" .. server .. " restart 1\>/dev/null 2\>/dev/null")
-- 			luci.sys.call("/etc/init.d/"     .. server .. " restart 1\>/dev/null 2\>/dev/null")
--  		end
--  	end
--  	return true
-- end

-- function f.handle(self, state, data)
-- 	if state == FORM_VALID then
-- 		if data.crons then
-- 			fs.writefile(cronfile, data.crons:gsub("\r\n", "\n"))
-- 			luci.sys.call("/usr/bin/crontab %q" % cronfile)
-- 		end
-- 	end
-- 	return true
-- end

return f
