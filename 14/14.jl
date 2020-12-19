
function parse_inst(val)
    reg = r"\[(.*?)\]"
    addr, val = split(val, "=")
    
    val = parse(Int, val)
    addr = parse(Int, match(reg, addr).captures[1])
    return addr, val
end

function apply_mask(mask, val)
    bval = collect(bitstring(val)[29:64])
    bmask = collect(mask)
    # println(bval)
    # println(bmask)
    # if size(bval) != size(bmask) error("bit string wrong size!") end

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

function sum_mem(mem)
    s = 0
    for key in keys(mem)
        s += mem[key]
    end
    return s
end

function run_program(file)
    mem = Dict()
    
    for line in readlines("./init_program.txt")
        if line[1:6] == "mask ="
            global mask = line[8:length(line)]
        else
            addr, val = parse_inst(line)
            # println("mem[$addr] = $val")
            val = apply_mask(mask, val)
            mem[addr] = Int(val)
        end
    end
    return sum_mem(mem)
end
# println(mem)
println(run_program("./init_program.txt"))

