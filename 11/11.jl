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

function parse_input(input)
    out = []
    for line in input
        l = Array(split(line, ""))
        append!(out, l)
    end
    return out
end

function fill_seats(input)
    changed = false
    new_input = copy(input)
    for i in 1:length(input)
        for j in 1:length(input[i])
            check_adjacent(input, i, j)
        end
    end
end

function check_adjacent(input, i, j)
    n = 0
    if i > 1 && j > 1
        ilist = (i-1):(i+1)
        jlist = (j-1):(j+1)
    end
    println(ilist, jlist)
    for ii in ilist
        for jj in jlist
            println("Checking ", [ii, jj])
            if input[ii][jj] == "#" && ((ii != i) && (jj != j)) 
                println("\tFound")
                n += 1
            end
        end
    end
    return n
end
# fill_seats(test_input)
