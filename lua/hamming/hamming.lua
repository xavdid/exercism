local Hamming = {}

---comment
---@param a string
---@param b string
---@return integer
function Hamming.compute(a, b)
  if a:len() ~= b:len() then
    return -1
  end

  local result = 0
  for i = 1, #a do
    if a:sub(i, i) ~= b:sub(i, i) then
      result = result + 1
    end
  end
  return result
end

return Hamming
