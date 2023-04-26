function saddlepoints(M)::Vector{Tuple{Int,Int}}
  res = []
  cols = collect(eachcol(M))
  for (row_num, row) in enumerate(eachrow(M))
    max_row = max(row...)
    for (col_num, val) in enumerate(row)
      col = cols[col_num]
      if val >= max_row && val <= min(col...)
        res = push!(res, (row_num, col_num))
      end
    end
  end
  res
end