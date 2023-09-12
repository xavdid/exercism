if .moment | index("T") == null
    # it's only a date, no time; use a default
    then "\(.moment)T00:00:00Z"
    # missing the trailing Z, just add it
    else .moment + "Z"
end 
| fromdate + 1000000000 
| todate 
| rtrimstr("Z")