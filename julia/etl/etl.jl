function transform(input::Dict{Int, Vector{Char}})::Dict{Char, Int}
  res = Dict{Char, Int}()
  for (k, v) in input
    for l in v
      res[lowercase(l)] = k
    end
  end
  res
end
