function parse_bags(instructions)

    big_dict = Dict()

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

    println(big_dict)
    return big_dict
end

function bag_in_bag(big_dict, bag, bag_goal)

    contents = big_dict[bag]
    println("\tChecking ", bag)
    for c in contents
        if c == " other bag"
            return false
        end
        if c == bag_goal 
            println("\t\t!!", bag_goal, " found in ", bag)
            return true
        elseif bag_in_bag(big_dict, c, bag_goal)
            return true
        end
    end
    return false
end

function count_bags(instructions, bag_goal)
    instructs = parse_bags(instructions)

    n = 0
    for (bag,_) in instructs
        println("Checking: ",bag)
        if bag_in_bag(instructs, bag, bag_goal)
            n += 1
        end
    end

    return n
end
# function parse_input(instructions)
#     big_dict = Dict()
#     for i in instructions
        
#     end

instructions = readlines("./instructions.txt")
# instructions = readlines("./test_inst.txt")

println(count_bags(instructions, "shiny gold bag"))