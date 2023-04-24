function wordcount(sentence::String)::Dict{String,Int}
  res = Dict()
  for match in eachmatch(r"[\w'\d]+", sentence)
    word = strip(lowercase(match.match), ''')
    if word == ""
      continue
    end

    res[word] = get(res, word, 0) + 1
  end
  res
end
