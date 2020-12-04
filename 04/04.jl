using DelimitedFiles
using Printf


function test_passports(file, req_fields)
    open(file, "r") do f
        total = 0
        inval = 0
        dict = Dict()

        for l in eachline(f)
            if l == ""
                total += 1
                for key in req_fields
                    if haskey(dict, key) == false
                        inval += 1
                        break
                    end
                end
                dict = Dict()
            else
                for string in split(l, " ")
                    pair = split(string, ":")
                    # println(pair)
                    dict[pair[1]] = pair[2]
                end
            end
        end
        println(file)
        println("Total\t",total)
        println("Invalid\t",inval)
        println("Valid\t",total-inval)
    end
end

# print("Total\t$(total)\nInvalid\t$(inval)\n")
req_fields = [
    "byr", 
    "iyr", 
    "eyr", 
    "hgt",     
    "hcl", 
    "ecl", 
    "pid", 
]

test_passports("./input.dat", req_fields)
test_passports("./test_input.txt", req_fields)