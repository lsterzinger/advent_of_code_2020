
# Function to parse instruction line 
# into inst, operator, and val
function parse_instruction(code)
    inst, num = split(code, " ")
    operator = string(num[1])
    # operator = Meta.parse(operator)
    val = parse(Int, num[2:length(num)])

    return inst, operator, val
end

# run the program as given
function run_program(file)
    global i = 1                # line counter 
    global acc = 0              # accumulator
    global read_lines = []      # storage for already read lines
    global len = length(file)   # length of file
    global valid_exit = false   # false if infinite loop

    # Run this loop until a break
    while true
        if i in read_lines  # check for infinite loop
            valid_exit = false
            break
        elseif i == (len+1) # check for valid program halt
            valid_exit = true
            break
        end

        inst, operator, val = parse_instruction(file[i])
        
        append!(read_lines, i)  # add line to read_lines
        
        # Check each inst and change i/acc accordingly
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
    return acc, valid_exit
end

# Function to change the program and test
# all possible single changes of "jmp" <=> "nop" 
function change_program(file)

    new_file = copy(file)   # temporary instruction set
    for i in  1:length(new_file)
        newline = new_file[i]

        if newline[1:3] == "jmp"
            newline = replace(newline, "jmp" => "nop")
        elseif newline[1:3] == "nop"
            newline = replace(newline, "nop" => "jmp")
        end

        new_file[i] = newline
        results = run_program(new_file)

        if results[2] == true  # if run_program was valid
            return results
        else
            new_file = copy(file)
        end
    end
end
code_file = readlines("./code.txt")
# code_file = readlines("./test_code.txt")

println("Part 1: acc = ", run_program(code_file), " before infinite loop")
println("Part 2: acc = ", change_program(code_file), " after successful completion")
# println(run_program(code_file, change_inst=true))
