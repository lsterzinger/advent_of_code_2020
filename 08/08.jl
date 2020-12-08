function run_program(file; change_inst = false)
    global i = 1
    global acc = 0
    global comp_lines = []
    global len = length(file)
    
    while true
        code = file[i]
        inst, num = split(code, " ")
        operator = string(num[1])
        # operator = Meta.parse(operator)
        val = parse(Int, num[2:length(num)])
        
        if i in comp_lines && change_inst == false
            break
        end
        
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
    return acc
end


code_file = readlines("./code.txt")
# code_file = readlines("./test_code.txt")

println(run_program(code_file))
# println(run_program(code_file, change_inst=true))
