
function parse_inst(val)
    reg = r"\[(.*?)\]"
    addr, val = split(val, "=")
    
    val = parse(Int, val)
    addr = parse(Int, match(reg, addr).captures[1])
    return addr, val
end

function apply_mask(mask, val; part2=false)
    
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
    end
end

function get_possible_masks(masklist)
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
                # return get_possible_masks(newmasklist)
            end
        end
    end
    return get_possible_masks(newmasklist)
end

function sum_mem(mem)
    s = 0
    for key in keys(mem)
        s += mem[key]
    end
    return s
end

function run_program(file; part2 = false)
    mem = Dict()
    
    for line in readlines("./init_program.txt")
        if line[1:6] == "mask ="
            global mask = line[8:length(line)]
        elseif !part2
            addr, val = parse_inst(line)
            # println("mem[$addr] = $val")
            val = apply_mask(mask, val)
            mem[addr] = Int(val)
        else
            addr, val = parse_inst(line)
            addr_list = apply_mask(mask, addr)
            for addr in addr_list
                mem[addr] = Int(val)
            end
        end
    end
    return sum_mem(mem)
end
# println(mem)
# println(run_program("./init_program.txt"))
println(get_possible_masks(["000000000000000000000000000000X1001X"]))
