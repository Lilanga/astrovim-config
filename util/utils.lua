local M = {}

function M.dump(o, c)
    if type(o) == 'table' then
        local s = ''
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            --s = s .. '[' .. k .. '] = ' .. M.dump(v) .. ','
            s = s .. M.dump(v) .. ','
        end

        if s == nil or s == '' then
            return ''
        else
            return c .. s:sub(1, -2)
        end
    else
        return tostring(o)
    end
end

return M