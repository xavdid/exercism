function sum_of_multiples(limit::Int, factors)::Int
  sum(reduce(
      union, 
      [Set(f:f:limit-1) for f in factors if f > 0], 
      init=Set{Int}()
  ))
end
