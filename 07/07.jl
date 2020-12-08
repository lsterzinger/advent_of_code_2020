function parse_bag(instruction)
    bag = Dict()
    # println(inst)
    origin, contents = split(instruction, " contain ")
    # println(origin, "\t", contents)
    bag["name"] = origin
    
    # Check if end of trail
    if contents == "no other bags."
        println("end of trail found:\t", origin)
        return
    end
    
    # Strip "." and "bags" -> "bag"
    contents = replace(contents, "." => "")
    contents = replace(contents, "bags" => "bag")

    # Split contents
    if ',' in contents
        bag["contents"] = split(contents, ", ")
    else
        bag["contents"] = [contents]
    end
    return strip_number(bag)
end

function strip_number(bag)
    new_contents = []
    for b in bag["contents"]
        new =  b[3:length(b)]
        new_contents = vcat(new_contents,new)
    end
    bag["contents"] = new_contents
    return bag
end

function bag_in_bag(instructions, bag, bag_goal)
    for inst in instructions
        current_bag = parse_bag(inst)
        if current_bag["name"] == bag_goal
            return true
        elseif current_bag["name"] == bag
            for b in current_bag["contents"]
                if bag_in_bag(instructions, b, bag_goal) == true
                    return true
                end
            end
        end
    end
end

# instructions = readlines("./instructions.txt")
instructions = readlines("./test_inst.txt")
first_bag = parse_bag(instructions[1])
# println(first_bag)
bag_in_bag(instructions, first_bag["name"], "shiny gold bag")
