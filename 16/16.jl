function read_header(file)
    f = open(file, "r")
    
    rules = Dict()
    for line in readlines(f, keep=true)
        if line == "\n" break end

        inst, range = split(line, ": ")
        range = split(range, " or ")
        
        min1, max1 = split(range[1], "-")
        min2, max2 = split(range[2], "-")

        range1 = [parse(Int, x) for x in [min1, max1]]
        range2 = [parse(Int, x) for x in [min2, max2]]

        rules[inst] = [range1, range2]
    end 
    close(f)
    println(rules["class"][1])
end

read_header("./test_input.txt")