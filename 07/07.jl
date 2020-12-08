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
    new_contents = []
    for (bag, contents) in big_dict
        # println(bag)
        new_contents = []
        for c in contents
            new_contents = vcat(new_contents, c[3:length(c)])
        end
        big_dict[bag] = new_contents
    end

    # println(big_dict)
    return big_dict
end

# Recursive function to follow bag trees
function bag_in_bag(big_dict, bag, bag_goal)

    # Loop over contents of current bag
    for c in big_dict[bag]
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

# Loop over all instructions and count
function count_bags(instructions, bag_goal)
    instructs = parse_bags(instructions)

    n = 0
    for (bag,_) in instructs
        if bag_in_bag(instructs, bag, bag_goal)
            n += 1
        end
    end

    return n
end

instructions = readlines("./instructions.txt")
# instructions = readlines("./test_inst.txt")

println("Part One: ",count_bags(instructions, "shiny gold bag"))