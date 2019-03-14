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
local cronfile = "/etc/asterisk/sip_peers.conf"
local regsfile = "/etc/asterisk/sip_registrations.conf"

f = SimpleForm("EditMe")

t = f:field(TextValue, "crons")
t.rmempty = true
t.rows = 18
function t.cfgvalue()
	if     nixio.fs.access(cronfile)   then
   		return fs.readfile(cronfile) or ""
	else
   		return "No File No Party, please reload config.\n"
	end
end

u = f:field(TextValue, "regst")
u.rmempty = true
u.rows = 2
function u.cfgvalue()
	return fs.readfile(regsfile) or ""
end

function f.handle(self, state, data)
 	if state == FORM_VALID then
 		if data.regst then
 			fs.writefile(regsfile, data.regst:gsub("\r\n", "\n"))

			luci.sys.call("/etc/init.d/pbx-" .. server .. " restart 1\>/dev/null 2\>/dev/null")
			luci.sys.call("/etc/init.d/"     .. server .. " restart 1\>/dev/null 2\>/dev/null")
 		end
 	end
 	return true
end

return f
