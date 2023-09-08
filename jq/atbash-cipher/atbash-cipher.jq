def encode($from; $to):
    ("1234567890" | split("")) as $nums |
    .phrase | split("") |
    map(
        ascii_downcase as $c |
        $from | index($c) as $i |
        if $i == null
            then if $nums | index($c)
                    then $c
                    else ""
                end
            else $to[$from | index($c)]
        end
    ) |
    map(select(. != ""))
    # undocumented `chunk` function
    | [_nwise(5)]
    | map(join(""));

("abcdefghijklmnopqrstuvwxyz" | split("")) as $enc |
("zyxwvutsrqponmlkjihgfedcba" | split("")) as $dec |
# these operations are the same, we just reverse which direction we go
if .property == "encode"
    # encoding has spaces every 5 characters
    then .input | encode($enc; $dec) | join(" ")
    # decoding has no spaces
    else .input | encode($dec; $enc) | join("")
end
