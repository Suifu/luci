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

modulename = "pbx"

if     nixio.fs.access("/etc/init.d/asterisk")   then
   server = "asterisk"
else
   server = ""
end

-- Returns formatted output of string containing only the words at the indices
-- specified in the table "indices".
function format_indices(string, indices)
   if indices == nil then
      return "Error: No indices to format specified.\n" 
   end

   -- Split input into separate lines.
   lines = luci.util.split(luci.util.trim(string), "\n")
   
   -- Split lines into separate words.
   splitlines = {}
   for lpos,line in ipairs(lines) do
      splitlines[lpos] = luci.util.split(luci.util.trim(line), "%s+", nil, true)
   end
   
   -- For each split line, if the word at all indices specified
   -- to be formatted are not null, add the formatted line to the
   -- gathered output.
   output = ""
   for lpos,splitline in ipairs(splitlines) do
      loutput = ""
      for ipos,index in ipairs(indices) do
         if splitline[index] ~= nil then
            loutput = loutput .. string.format("%-40s", splitline[index])
         else
            loutput = nil
            break
         end
      end
      
      if loutput ~= nil then
         output = output .. loutput .. "\n"
      end
   end
   return output
end

m = Map (modulename, translate("List of loaded Module"))

-----------------------------------------------------------------------------------------
s = m:section(NamedSection, "loaded_module", "info")
s.anonymous = true
sts = s:option(DummyValue, "_sts") 
sts.template = "cbi/tvalue"
sts.rows = 20

if server == "asterisk" then
   sts.value=luci.sys.exec("asterisk -rx 'module show'")			 
else
   sts.value="No Asterisk No Party, please install Asterisk.\n"
end

return m
