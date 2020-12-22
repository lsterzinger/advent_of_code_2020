function parse_input(input)
    t = parse(Int, input[1])
    buses = split(input[2], ",")
    blist = []
    for b in buses
        try append!(blist, parse(Int, b))
        catch e 
            append!(blist, 0)
        end
    end
    return t, blist
end

function find_next_bus(input; q2 = false)
    earliest_time, btimes = parse_input(input)
    # println(btimes)
    t = 0

    bus2 = find_next_nonzero(btimes)

    longest_bus, lb_index = findmax(btimes)

    if q2 dt = longest_bus else dt = 1 end

    while true
        if !q2
            for b in btimes
                if b != 0 && (t % b == 0 && t > earliest_time)
                    return (t - earliest_time) * b
                end
            end
        elseif q2
            # println(t)
            if check_conseq_departure(btimes, longest_bus, lb_index, t) return t end
        end
        
        t += dt
    end
end

function check_conseq_departure(buses, longest_bus, lb_index, t)  
    for (i,b) in enumerate(buses)
        di = lb_index - i
        if b != 0 && ((t - di) % b != 0)
            return false
        end
    end
    return true
end

function find_next_nonzero(buses)
    for i in 2:length(buses)
        if buses[i] > 0
            global bt2 = i
            break
        end
    end
end

# test_input = ["939", "7,13,x,x,59,x,31,19"]
test_input = readlines("./notes.txt")
println("Part 1: ", find_next_bus(test_input))
println("Part 2: ", find_next_bus(test_input, q2=true))