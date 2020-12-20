function play_game(input; iend=2020)
    len = length(input)
    hist = Dict()
    last_num = nothing
    first = true

    for i in 1:iend
        if i <= len
            last_num = input[i]
        elseif first
            last_num = 0 
        else 
            # last num = last time - time before that 
            last_num = hist[last_num][1] - hist[last_num][2]
        end

        first = !haskey(hist, last_num)
        if first
            hist[last_num] = [i, nothing]
        else
            hist[last_num] = [i, hist[last_num][1]]
        end
        # println("$i\t$last_num")
    end
    println(last_num)
end

test_input = [0,3,6]
real_input = [6,4,12,1,20,0,16]
play_game(real_input)
play_game(real_input, iend=30000000)
