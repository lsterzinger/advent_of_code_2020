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
    
    println(is_valid(adapters))
    count_jumps(adapters)
    # count_combs(adapters)
end

function jumps(adapters)
    jumps = []
    a = adapters[1]
    for i in adapters[2:length(adapters)]
        push!(jumps, i-a)
        a = i
    end
    return jumps
end


# I was stuck on part 2, figured this out thanks to 
# dynamic programming tip from  Jonathan Paulson
# https://youtu.be/cE88K2kFZn0
comb_dict = Dict()
function num_comb(i)
    println(adapters)
    if i == length(adapters)
        return 1
    end

    if haskey(comb_dict, i)
        return comb_dict[i]
    end

    n = 0
    for j = (i+1):length(adapters)
        if adapters[j] - adapters[i] <= 3
            n += num_comb(j)
        end
    end
    comb_dict[i] = n
    return n
end

# adapters = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
# adapters = to_str(readlines("./test_input.txt"))
adapters = to_str(readlines("./adapters.txt"))

process_input(adapters)
println("Number of combinations: ", num_comb(1))