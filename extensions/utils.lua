--[[
  @Authors: Ukzz (Chemik)
  @Details: Mod utils function.
]]

strfind = string.find
strrep = string.rep
strsub = string.sub
tabsort = table.sort
tostr = tostring

function string.formats(str, ...)
  return (#{...} > 0 and str:format(...) or str)
end

function printf(str, ...)
  print(string.formats(str, ...))
end

function perror(str, ...)
  print(string.formats("[ERROR]: "..str, ...))
end

function pdmesg(str, ...)
  print(string.formats("[DMESG]: "..str, ...))
end

function switch(t)
  t.case = function (self, x)
    local f=self[x] or self.default
    if(f ~= nil) then
      if(type(f) == "function") then
        f(x, self)
      else
        error("case "..tostring(x).." not a function")
      end
    end
  end
  return t
end

function printTable(table, indent)
  local sort = table.sort
  indent = indent or 0;
  local keys = {};
  for k in pairs(table) do
    keys[#keys+1] = k;
    tabsort(keys, function(a, b)
      local ta, tb = type(a), type(b);
      if (ta ~= tb) then
        return ta < tb;
      else
        return a < b;
      end
    end);
  end

  print(string.rep('  ', indent)..'{');
  indent = indent + 1;
  for k, v in pairs(table) do
    local key = k;
    if (type(key) == 'string') then
      if not (string.match(key, '^[A-Za-z_][0-9A-Za-z_]*$')) then
        key = "['"..key.."']";
      end
    elseif (type(key) == 'number') then
      key = "["..key.."]";
    end

    if (type(v) == 'table') then
      if (next(v)) then
        printf("%s%s =", string.rep('  ', indent), tostring(key));
        printTable(v, indent);
      else
        printf("%s%s = {},", string.rep('  ', indent), tostring(key));
      end 
    elseif (type(v) == 'string') then
      printf("%s%s = %s,", string.rep('  ', indent), tostring(key), "'"..v.."'");
    else
      printf("%s%s = %s,", string.rep('  ', indent), tostring(key), tostring(v));
    end
  end
  indent = indent - 1;
  print(string.rep('  ', indent)..'}');
end

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function string.ucwords(self)
  return self:gsub("(%a)([%w_']*)", function(a, b) return a:upper() .. b:lower() end)
end

function string.explode(self, sep)
  local parts, i = {}, 1
  local start, finish = strfind(self, sep, i)
  while (start) do
    table.insert(parts, strsub(self, i, start - 1))
    i = finish + 1
    start, finish = strfind(self, sep, i)
  end
  table.insert(parts, strsub(self, i))
  return parts
end
