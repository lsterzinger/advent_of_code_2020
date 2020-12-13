# Thanks again to Jonathan Paulson
# whose video https://youtu.be/d25r5GZa4us
# helped figure out a faster way to accomplish
# this puzzle

using StatsBase

function parse_input(input)
    nr = length(input)
    ns = length(input[1])
    input = reshape(split(join(input), ""), (ns, nr))

    return input
end

function fill_seats(input; part_one = true)
    (ns, nr) = size(input)
    while true
        output = deepcopy(input)
        change = false
        
        # Loop over all rows and seats
        for r in 1:nr
            for s in 1:ns
                
                # Find # of occurences
                nocc = 0
                for dr in [-1,0,1]
                    for ds in [-1,0,1]
                        if !(dr == 0 && ds == 0)
                            rr = r + dr
                            ss = s + ds

                            while 1<=(rr)<=nr && 1<=(ss)<=ns && input[ss,rr] == "." && !part_one
                                rr += dr
                                ss += ds
                            end
                            if 1<=(rr)<=nr && 1<=(ss)<=ns && input[ss,rr] == "#" 
                                nocc += 1
                            end
                        end
                    end
                end
                
                # Change output based on occurences
                if input[s,r] == "L" && nocc == 0
                    output[s,r] = "#"
                    change = true
                elseif input[s,r] == "#" && nocc >= (if part_one 4 else 5 end)
                    output[s,r] = "L"
                    change = true
                end
            end
        end
    
        if change == false return output end
        input = deepcopy(output)
    end
    
    
end

function total_empty(input)
    return countmap(input)["#"]
end


seats = readlines("seats.txt")

final_seats = fill_seats(parse_input(seats))
println("Part 1: ", total_empty(final_seats))

final_seats = fill_seats(parse_input(seats), part_one=false)
println("Part 2: ", total_empty(final_seats))