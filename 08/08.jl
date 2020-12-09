function parse_instruction(code)
    inst, num = split(code, " ")
    operator = string(num[1])
    # operator = Meta.parse(operator)
    val = parse(Int, num[2:length(num)])

    return inst, operator, val
end

function run_program(file; change_inst = false)
    global i = 1
    global acc = 0
    global comp_lines = []
    global len = length(file)
    global inf = false
    global test = false


    while true
        if i in comp_lines # && change_inst == false
            inf = true
            break
        elseif i == (len+1)
            inf = false
            break
        end

        inst, operator, val = parse_instruction(file[i])
        
        append!(comp_lines, i)
        if inst == "acc"
            exp = Meta.parse(join([acc, operator, val]))
            global acc = eval(exp)
            global i += 1
            
        elseif inst == "nop"           
            global i += 1 
            
        elseif inst == "jmp"
            exp = Meta.parse(join([i, operator, val]))
            i = eval(exp)
        end
        
    end
    return acc, inf
end

function change_program(file)
    new_file = copy(file)
    for i in  1:length(new_file)
        newline = new_file[i]
        if newline[1:3] == "jmp"
            print("Replacing ", newline)
            newline = replace(newline, "jmp" => "nop")
            println("\twith ", newline)
        elseif newline[1:3] == "nop"
            print("Replacing ", newline)
            newline = replace(newline, "nop" => "jmp")
            println("\twith ", newline)
        end
        new_file[i] = newline
        results = run_program(new_file)
        if results[2] == false
            return results
        else
            new_file = copy(file)
        end
    end
end
code_file = readlines("./code.txt")
# code_file = readlines("./test_code.txt")

# println(run_program(code_file))
println(change_program(code_file))
# println(run_program(code_file, change_inst=true))
