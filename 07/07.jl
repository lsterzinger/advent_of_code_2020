# Function to take input and return dict
function parse_bags(instructions)

    big_dict = Dict()

    # Loop over all instructions
    for instruction in instructions
        origin, contents = split(instruction, " contain ")

        contents = replace(contents, "." => "")
        contents = replace(contents, "bags" => "bag")
        origin = replace(origin, "bags" => "bag")

        # Split contents
        if ',' in contents
            big_dict[origin] = split(contents, ", ")
        else
            big_dict[origin] = [contents]
        end
    end
    return strip_number(big_dict)
end

# Function to strip the number off of text
# TODO parse number and make it a property
function strip_number(big_dict)
    for (bag, contents) in big_dict
        # println(bag)

        new_contents = []
        content_dict = Dict() # dict with "number" => nbags, "contents" => bag contents
        nbags = Dict() # nbags is dict with "bag_name" => number

        # Strip number from bag name and add to nbags
        for c in contents
            new_contents = vcat(new_contents, c[3:length(c)])
            nbags[c[3:length(c)]] = 0
            if c != "no other bag"
                nbags[c[3:length(c)]] += parse(Int, c[1])
            end
        end

        content_dict["number"] = nbags
        content_dict["contents"] = new_contents
        big_dict[bag] = content_dict
    end

    # println(big_dict)
    return big_dict
end

# Recursive function to follow bag trees
function bag_in_bag(big_dict, bag, bag_goal)

    # Loop over contents of current bag
    for c in big_dict[bag]["contents"]
        if c == " other bag"
            return false
        end

        if c == bag_goal 
            return true
        elseif bag_in_bag(big_dict, c, bag_goal)
            return true
        end
    end
    return false
end

# Find if the goal is in the bag
function goal_in_bag(instructions, bag_goal)
    ins = parse_bags(instructions)

    n_goal = 0
    for (bag,_) in ins
        if bag_in_bag(ins, bag, bag_goal)
            n_goal += 1
        end
    end

    return n_goal
end

function num_bags(instructions, start_bag; orig=false)
    ins = parse_bags(instructions)
    sbag = ins[start_bag]

    nbags = 1

    # println("Checking ", sbag)
    for c in sbag["contents"] 
        if c != " other bag"
            nbags += sbag["number"][c] * num_bags(instructions, c)
        end
    end

    # Return nbags-1 if this is the "original bag"
    if orig
        return nbags -1 
    else
        return nbags
    end
end

instructions = readlines("./instructions.txt")

println("Part One: ", goal_in_bag(instructions, "shiny gold bag"))
println("Part Two: ", num_bags(instructions, "shiny gold bag", orig=true))