# input: { "series": "1", "sliceLength": 1 }
. as {series: $series, sliceLength: $sliceLength} |
if
  $series == "" then
    "series cannot be empty" | halt_error
  elif $sliceLength > ($series | length) then
    "slice length cannot be greater than series length" | halt_error
  elif $sliceLength == 0 then
    "slice length cannot be zero" | halt_error
  elif $sliceLength < 0 then
    "slice length cannot be negative" | halt_error
  else
    .
end
| [range(0; $series | length)]
| map($series[. : . + $sliceLength])
| map(select(. | length == $sliceLength))
