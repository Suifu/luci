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

modulename = "pbx-advanced"

m = Map (modulename, translate("PBX Main Page"),
      translate("This configuration page allows you to configure a phone system (PBX) service which \
      permits making phone calls through multiple Google and SIP (like Sipgate, \
      SipSorcery, and Betamax) accounts and sharing them among many SIP devices. \
      Note that Google accounts, SIP accounts, and local user accounts are configured in the \
      \"Google Accounts\", \"SIP Accounts\", and \"User Accounts\" sub-sections. \
      You must add at least one User Account to this PBX, and then configure a SIP device or \
      softphone to use the account, in order to make and receive calls with your Google/SIP \
      accounts. Configuring multiple users will allow you to make free calls between all users, \
      and share the configured Google and SIP accounts. If you have more than one Google and SIP \
      accounts set up, you should probably configure how calls to and from them are routed in \
      the \"Call Routing\" page. If you're interested in using your own PBX from anywhere in the \
      world, then visit the \"Remote Usage\" section in the \"Advanced Settings\" page."))

-- Recreate the config, and restart services after changes are commited to the configuration.
function m.on_after_commit(self)
        luci.sys.call("/etc/init.d/pbx-" .. server .. " restart 1\>/dev/null 2\>/dev/null")
        luci.sys.call("/etc/init.d/"     .. server .. " restart 1\>/dev/null 2\>/dev/null")
end

-----------------------------------------------------------------------------------------
s = m:section(NamedSection, "connection_status", "main")
s.anonymous = true

s:option (DummyValue, "status")

s = m:section(TypedSection, "asterisk", "Asterisk General Options", "")
s.anonymous = true

-- agidir = s:option(Value, "agidir", "AGI directory", "")
-- agidir.rmempty = true

cache_record_files = s:option(Flag, "cache_record_files", "Cache recorded sound files during recording", "")
cache_record_files.rmempty = true

debug = s:option(ListValue, "debug", "Debug Level", "")
debug:value("3","3")
debug:value("2","2")
debug:value("1","1")
debug:value("0","0")
debug.default ="0"

verbose = s:option(ListValue, "verbose", "Verboses Level", "")
verbose:value("3","3")
verbose:value("2","2")
verbose:value("1","1")
verbose:value("0","0")
verbose.default ="0"

dontwarn = s:option(Flag, "dontwarn", "Disable some warnings", "")
dontwarn.rmempty = true

dumpcore = s:option(Flag, "dumpcore", "Dump core on crash", "")
dumpcore.rmempty = true

-- highpriority = s:option(Flag, "highpriority", "High Priority", "")
-- highpriority.rmempty = true

-- initcrypto = s:option(Flag, "initcrypto", "Initialise Crypto", "")
-- initcrypto.rmempty = true

-- internal_timing = s:option(Flag, "internal_timing", "Use Internal Timing", "")
-- internal_timing.rmempty = true

-- logdir = s:option(Value, "logdir", "Log directory", "")
-- logdir.rmempty = true

maxcalls = s:option(ListValue, "maxcalls", "Maximum number of calls allowed", "")
maxcalls:value("8","8")
maxcalls:value("7","7")
maxcalls:value("6","6")
maxcalls:value("5","5")
maxcalls:value("4","4")
maxcalls:value("3","3")
maxcalls:value("2","2")
maxcalls:value("1","1")
maxcalls.default ="8"

-- maxload = s:option(Value, "maxload", "Maximum load to stop accepting new calls", "")
-- maxload.rmempty = true

nocolor = s:option(Flag, "nocolor", "Disable console colors", "")
nocolor.rmempty = true

live_dangerously = s:option(Flag, "live_dangerously", "Enable the execution of dangerous dialplan", "")
live_dangerously.rmempty = true

-- record_cache_dir = s:option(Value, "record_cache_dir", "Sound files Cache directory", "")
-- record_cache_dir.rmempty = true
-- record_cache_dir:depends({ ["cache_record_files"] = "true" })

-- rungroup = s:option(Flag, "rungroup", "The Group to run as", "")
-- rungroup.rmempty = true

-- runuser = s:option(Flag, "runuser", "The User to run as", "")
-- runuser.rmempty = true

-- spooldir = s:option(Value, "spooldir", "Voicemail Spool directory", "")
-- spooldir.rmempty = true

-- systemname = s:option(Value, "systemname", "Prefix UniquID with system name", "")
-- systemname.rmempty = true

transcode_via_sln = s:option(Flag, "transcode_via_sln", "Build transcode paths via SLINEAR, not directly", "")
transcode_via_sln.rmempty = true

transmit_silence_during_record = s:option(Flag, "transmit_silence_during_record", "Transmit SLINEAR silence while recording a channel", "")
transmit_silence_during_record.rmempty = true

-- zone = s:option(Value, "zone", "Time Zone", "")
-- zone.rmempty = true

-- hardwarereboot = m:section(TypedSection, "hardwarereboot", "Reload Hardware Config", "")

-- method = hardwarereboot:option(ListValue, "method", "Reboot Method", "")
-- method:value("web", "Web URL (wget)")
-- method:value("system", "program to run")
-- method.rmempty = true

-- param = hardwarereboot:option(Value, "param", "Parameter", "")
-- param.rmempty = true

-- moh = m:section(TypedSection, "moh", "Music On Hold", "")

-- application = moh:option(Value, "application", "Application", "")
-- application.rmempty = true
-- application:depends({ ["asterisk.moh.mode"] = "custom" })

-- directory = moh:option(Value, "directory", "Directory of Music", "")
-- directory.rmempty = true

-- mode = moh:option(ListValue, "mode", "Option mode", "")
-- mode:value("system", "program to run")
-- mode:value("files", "Read files from directory")
-- mode:value("quietmp3", "Quite MP3")
-- mode:value("mp3", "Loud MP3")
-- mode:value("mp3nb", "unbuffered MP3")
-- mode:value("quietmp3nb", "Quiet Unbuffered MP3")
-- mode:value("custom", "Run a custom application")
-- mode.rmempty = true

-- random = moh:option(Flag, "random", "Random Play", "")
-- random.rmempty = true

return m
