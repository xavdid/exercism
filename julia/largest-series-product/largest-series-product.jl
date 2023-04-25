function largest_product(str::String, span::Int)
  if span == 0
    return 1
  end

  if str == "" || span < 0 || length(str) < span
      throw(ArgumentError(""))
  end

  ranges = (str[x:end] for x in range(1,span))

  nums = [*(collect(parse(Int, n) for n in r)...) for r in zip(ranges...)]
  
  max(nums...)
end