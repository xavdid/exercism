gsub(" ";"") | split("") | reverse | 
try 
    if length < 2 # short lines are bad
        then false
        else 
            # this throws if there are any non-numbers left
            map(tonumber) | 
            to_entries |
            reduce .[] as {key: $index, value: $value} (0;
                . + if $index % 2 == 1 # every other index, starting at 1
                    then 
                        if $value * 2 >= 10
                            then $value * 2 - 9
                            else $value * 2
                        end
                    else
                        $value
                    end
            ) % 10 == 0
    end 
catch false