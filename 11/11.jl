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
    return try countmap(Iterators.flatten(seats))['#'] catch; 0 end
end

function parse_input(input)
    new_input = []
    for row in input
        push!(new_input, collect(row))
    end
    return new_input
end

function fill_seats(input)
    nrows = length(input)
    nseats = length(input[1])

    while true
        output = deepcopy(input)
        change = false
        for (r, row) in enumerate(input)
            for (s, seat) in enumerate(row)
                nocc = count_occupied(get_adjacent(input, r, s))
                if seat == 'L' && nocc == 0
                    output[r][s] = '#'
                    change = true
                elseif seat == '#' && nocc >= 5 # n_occurence > 4, +1 for seat in question
                    output[r][s] = 'L'
                    change = true
                end
            end
        end
        input = deepcopy(output)
        if change == false return input end
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
seats = readlines("seats.txt")
println(count_occupied(fill_seats(parse_input(seats))))