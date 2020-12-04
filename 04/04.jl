using DelimitedFiles
using Printf


function test_passports(file, req_keys)
    total = 0
    inval = 0
    dict = Dict()

    open(file) do f
        dict = Dict()

        while !eof(f)
            line = readline(f)
            if line != ""
                pairs = split(line, " ")
                for p in pairs
                    a,b = split(p, ":")
                    dict[a] = b
                end
            else
                total += 1

                if check_keys(dict, req_keys) == false
                    inval += 1
                end

                dict = Dict()
            end
        end
        if check_keys(dict, req_keys) == false
            inval += 1
        end
        total +=1 
    end
    # println(total)
    println(file)
    println("Total\t",total)
    println("Invalid\t",inval)
    println("Valid\t",total-inval)
end

function check_keys(dict, req_keys)
    for key in req_keys
        if haskey(dict, key) == false
            return false
        end
    end
    return true
end

# print("Total\t$(total)\nInvalid\t$(inval)\n")
req_keys = [
    "byr", 
    "iyr", 
    "eyr", 
    "hgt",     
    "hcl", 
    "ecl", 
    "pid", 
]

test_passports("./input.dat", req_keys)
# test_passports("./test_input.txt", req_keys)