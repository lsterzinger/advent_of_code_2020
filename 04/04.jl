using DelimitedFiles
using Printf

open("./input.dat", "r") do f
    total = 0
    inval = 0
    dict = Dict()

    req_fields = [
        "byr",
        "iyr",
        "eyr",
        "hgt",
        "hcl",
        "ecl",
        "pid"
    ]

    for l in eachline(f)
        if l == ""
            for key in req_fields
                if haskey(dict, key) == false
                    inval += 1
                    break
                end
            end
            total += 1
            dict = Dict()
        else
            for string in split(l, " ")
                pair = split(string, ":")
                dict[pair[1]] = pair[2]
            end
        end
    end
    println(total)
    println(inval)
    println(total-inval)
end

# print("Total\t$(total)\nInvalid\t$(inval)\n")