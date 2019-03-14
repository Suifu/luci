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

module("luci.controller.asterisk", package.seeall)

function index()

    entry({"admin", "asterisk"},                                cbi("asterisk/main"),                        "Asterisk",                               80)
    entry({"admin", "asterisk", "pbx"},                         cbi("asterisk/pbx"),                         "Useful informations",                     1)

    entry({"admin", "asterisk", "phones"},                      cbi("asterisk/pbx-voip"),                    "Voip Account",                            2)
    entry({"admin", "asterisk", "phones", "voip"},              cbi("asterisk/pbx-voip"),                    "Voip Account",                            1)
    -- entry({"admin", "asterisk", "phones", "PJSIP Wizard"},    cbi("asterisk/pbx-PJSIP-voip"),             "PJSIP TRUNK Wizard",                      2)
    entry({"admin", "asterisk", "phones", "config"},            cbi("asterisk/pbx-voip-conf"),               "Voip Account Advanced Edit",              3)

    entry({"admin", "asterisk", "trunks"},                      cbi("asterisk/pbx-trunks"),                  "Manage Extension",                        3)
    entry({"admin", "asterisk", "trunks", "status"},            cbi("asterisk/pbx-trunks"),                  "Create New SIP/IAX Extension",            1)
    entry({"admin", "asterisk", "trunks", "settings"},          cbi("asterisk/pbx-users"),                   "Create New User",                         2)
    -- entry({"admin", "asterisk", "trunks", "settings PJSIP Extension"},    cbi("asterisk/pbx-PJSIP-users"),    "Create New PJSIP Extension",          3)
    entry({"admin", "asterisk", "trunks", "config SIP"},        cbi("asterisk/pbx-users-sip-conf"),          "User SIP Advanced Edit",                  4)
    entry({"admin", "asterisk", "trunks", "config IAX"},        cbi("asterisk/pbx-users-iax-conf"),          "User IAX Advanced Edit",                  5)

    entry({"admin", "asterisk", "voicemail"},                   cbi("asterisk/pbx-voicemail"),               "Voicemail",                               4)
    entry({"admin", "asterisk", "voicemail", "voicemail"},      cbi("asterisk/pbx-voicemail"),               "Voicemail",                               1)
    entry({"admin", "asterisk", "voicemail", "config"},         cbi("asterisk/pbx-voicemail-conf"),          "Voicemail Advanced Edit",                 2)

    entry({"admin", "asterisk", "dialplans"},                   cbi("asterisk/pbx-calls"),                   "Call Routing",                            5)
    entry({"admin", "asterisk", "dialplans", "dialplans"},      cbi("asterisk/pbx-calls"),                   "Call Routing",                            1)
    entry({"admin", "asterisk", "dialplans", "config"},         cbi("asterisk/pbx-dialplans"),               "Call Routing Advanced Edit",              2)

    entry({"admin", "asterisk", "Options"},                     cbi("asterisk/pbx-advanced"),                "General Options",                         6)
    entry({"admin", "asterisk", "Options", "general"},          cbi("asterisk/pbx-option"),                  "General Options",                         1)
    entry({"admin", "asterisk", "Options", "advanced"},         cbi("asterisk/pbx-advanced"),                "Advanced Options",                        2)
    -- entry({"admin", "asterisk", "Options", "skull"},         cbi("asterisk/pbx-opt-2"),                   "Other Advanced Options",                  3)
    entry({"admin", "asterisk", "Options", "config"},           cbi("asterisk/pbx-adv-conf"),                "Advanced Edit",                           4)

    entry({"admin", "asterisk", "Module"},                      cbi("asterisk/pbx-mod"),                     "Modules",                                 7)
    entry({"admin", "asterisk", "Module", "module"},            cbi("asterisk/pbx-mod"),                     "Modules",                                 1)
    -- entry({"admin", "asterisk", "Module", "app"},            cbi("asterisk/asterisk-mod-app"),            "Applications",                            2)
    -- entry({"admin", "asterisk", "Module", "cdr"},            cbi("asterisk/asterisk-mod-cdr"),            "Call Detail Records",                     3)
    -- entry({"admin", "asterisk", "Module", "chan"},           cbi("asterisk/asterisk-mod-chan"),           "Channels",                                4)
    -- entry({"admin", "asterisk", "Module", "codec"},          cbi("asterisk/asterisk-mod-codec"),          "Codecs",                                  5)
    -- entry({"admin", "asterisk", "Module", "format"},         cbi("asterisk/asterisk-mod-format"),         "Format",                                  6)
    -- entry({"admin", "asterisk", "Module", "func"},           cbi("asterisk/asterisk-mod-func"),           "Functions",                               7)
    -- entry({"admin", "asterisk", "Module", "pbx"},            cbi("asterisk/asterisk-mod-pbx"),            "PBX",                                     8)
    -- entry({"admin", "asterisk", "Module", "res"},            cbi("asterisk/asterisk-mod-res"),            "Resources",                               9)
    -- entry({"admin", "asterisk", "Module", "res", "feature"}, cbi("asterisk/asterisk-mod-res-feature"),    "Feature Module Configuration",           10)
    entry({"admin", "asterisk", "Module", "config"},       	    cbi("asterisk/pbx-mod-conf"),                "Modules Advanced Edit",                  11)

end
