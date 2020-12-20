# Function to parse instruction and return address and value
function parse_inst(val)
    reg = r"\[(.*?)\]"
    addr, val = split(val, "=")
    
    val = parse(Int, val)
    addr = parse(Int, match(reg, addr).captures[1])
    return addr, val
end

# Apply a mask either in part1 or part2 format
function apply_mask(mask, val; part2=false)
    
    # Part 1: change the value everywhere the mask != X
    if !part2
        bval = collect(bitstring(val)[29:64])
        bmask = collect(mask)
        for i in 1:36
            if bmask[i] != 'X'
                bval[i] = bmask[i]
            end
        end

        bval = join(bval)   
        newval = parse(UInt, bval, base=2)
        # println("Changed $val to $bval = $newval")
        return newval
    
    # Part 2: Change value (address in this case)
    # where mask == X or mask == 1
    else
        bval = collect(bitstring(val)[29:64])
        bmask = collect(mask)
        for i in 1:36
            if bmask[i] == 'X' || bmask[i] == '1'
                bval[i] = bmask[i]
            end
        end

        bval = join(bval)   
        return bval
    end
end

# Take the output of apply_mask with part2 output
# and treat X as a floating value, can equal 1 or 0.
# Return all possible combinations using recusion
function get_possible_addrs(masklist)
    newmasklist = []
    for mask in masklist
        bmask = collect(mask)
        if !('X' in bmask) return masklist end
        for (i,c) in enumerate(bmask)
            if c == 'X'
                bmask[i] = '1'
                newmasklist = vcat(newmasklist, join(bmask))
                bmask[i] = '0'
                newmasklist = vcat(newmasklist, join(bmask))
                break
            end
        end
    end
    # This part is the recusion
    return get_possible_addrs(newmasklist)
end

# Sum all values in mem dict
function sum_mem(mem)
    s = 0
    for key in keys(mem)
        s += mem[key]
    end
    return s
end

# Main function to run the program.
# Parses lines and applies the masks correctly.
function run_program(file; part2 = false)
    mem = Dict()
    
    for line in readlines(file)
        if line[1:6] == "mask ="
            global mask = line[8:length(line)]
        elseif !part2
            addr, val = parse_inst(line)
            # println("mem[$addr] = $val")
            val = apply_mask(mask, val)
            mem[addr] = Int(val)
        else
            addr, val = parse_inst(line)
            masked_addr = apply_mask(mask, addr, part2=true)
            addrlist = get_possible_addrs([masked_addr])
            for a in addrlist
                a_int = parse(UInt, a, base=2)
                mem[a_int] = val
            end

        end
    end
    return sum_mem(mem)
end

println("Part 1: ", run_program("./init_program.txt"))
println("Part 2: ", run_program("./init_program.txt", part2=true))
