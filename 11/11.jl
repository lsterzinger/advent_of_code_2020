using StatsBase

function get_adjacent(input, row, seat)
    nrows = length(input)
    nseat = length(input[1])
    # adj = Array{Char}(undef, 3,3)
    adj = []
    if row == 1
        r1 = 1
        r2 = row + 1
    elseif row == nrows
        r1 = row - 1
        r2 = nrows
    else
        r1 = row -1
        r2 = row + 1
    end

    if seat == 1
        s1 = 1
        s2 = seat + 1
    elseif seat == nseat
        s1 = seat - 1
        s2 = nseat
    else
        s1 = seat - 1
        s2 = seat + 1
    end
    for (i,r) in enumerate(input[r1:r2])
        append!(adj, collect(r[s1:s2]))
        
        # adj[i,1:(s2-s1)+1] = collect(r[s1:s2])
    end
    return adj
end  

function count_occupied(seats)
    return try countmap(seats)['#'] catch; 0 end
end

function parse_input(input)
    new_input = []
    for row in input
        push!(new_input, collect(row))
    end
    return new_input
end

function fill_seats(input)
    change = true
    input = parse_input(input)
    
    nrows = length(input)
    nseat = length(input[1])

    row = 1
    seat = 1
    while change == true
        change = false
        for r in 1:length(input)
            row = input[r]
            for (s,seat) in enumerate(row) 
                nfull = count_occupied(get_adjacent(input,r,s))
                # println(nfull)
                if seat == 'L' && nfull == 0
                    input[r,s] = '#'
                    change = true
                elseif seat == '#' && nfull >= 5 # 5 including full seat
                    input[r,s] = 'L'
                    change = true
                end
            end
        end
    end
end

test_input = [
    "L.LL.LL.LL",
    "LLLLLLL.LL",
    "L.L.L..L..",
    "LLLL.LL.LL",
    "L.LL.LL.LL",
    "L.LLLLL.LL",
    "..L.L.....",
    "LLLLLLLLLL",
    "L.LLLLLL.L",
    "L.LLLLL.LL",

]

test_input2 = [
    "#.##.##.##",
    "#######.##",
    "#.#.#..#..",
    "####.##.##",
    "#.##.##.##",
    "#.#####.##",
    "..#.#.....",
    "##########",
    "#.######.#",
    "#.#####.##",

]

fill_seats(test_input)