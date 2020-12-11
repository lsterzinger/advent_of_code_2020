function to_str(input)
    out = []
    for i in input
        push!(out, parse(Int, i))
    end
    return out
end

function process_input(adapters)
    sort!(adapters)

    prepend!(adapters, 0)
    append!(adapters, adapters[end] + 3)
    
    count_jumps(adapters)
    # count_combs(adapters)
end

function count_jumps(adapters)
    n1 = 0
    n3 = 0
    for i in 1:(length(adapters)-1)
        d = adapters[i+1] - adapters[i]
        if d == 1
            n1 += 1
        elseif d ==3
            n3 += 1
        end
    end

    println("n1 * n3 = ", n1 * n3)
end

adapters = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
# adapters = to_str(readlines("./test_input.txt"))
# adapters = to_str(readlines("./adapters.txt"))

process_input(adapters)