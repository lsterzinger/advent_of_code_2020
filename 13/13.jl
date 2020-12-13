function parse_input(input)
    t = parse(Int, input[1])
    buses = split(input[2], ",")
    blist = []
    for b in buses
        try append!(blist, parse(Int, b))
        catch e end
    end
    return t, blist
end

function find_next_bus(input)
    t, btimes = parse_input(input)
    buses = btimes - btimes

    while true
        buses += btimes
        for b in sort(buses)
            if b > t
                println("$t, $buses")
                return b - t
            end
        end
    end
end

test_input = ["939", "7,13,x,x,59,x,31,19"]
println(find_next_bus(test_input))