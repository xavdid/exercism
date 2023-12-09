---@param scores integer[]
---@return { scores: (fun(): integer[]), personal_best: (fun(): integer), personal_top_three: (fun(): integer[]), latest: (fun(): integer)}
local function high_scores(scores)
  local sortedScores = {}

  for index, value in ipairs(scores) do
    sortedScores[index] = value
  end

  table.sort(sortedScores, function(a, b) return a > b end)

  return {
    scores = function() return scores end,
    latest = function() return scores[#scores] end,
    personal_best = function() return math.max(table.unpack(scores)) end,
    personal_top_three = function() return { sortedScores[1], sortedScores[2], sortedScores[3] } end
  }
end

return high_scores
