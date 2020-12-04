using DelimitedFiles
using Printf


# Tests all passports in file with requested keys
# Call function with valcheck=true to test values
function test_passports(file, req_keys; valcheck=false)
    # Initialize variables
    total = 0
    inval = 0

    # Open the files and read through lines
    open(file) do f
        # Empty dict
        dict = Dict()

        # While not at the end of file
        while !eof(f)
            line = readline(f) # read line

            if line != "" # if line is not empty
                # Split by space and then by key:val pairs
                pairs = split(line, " ")

                for p in pairs
                    a,b = split(p, ":")
                    dict[a] = b # add value to dictionary
                end
            
            # If line is empty, assume passport entry is over. 
            else
                total += 1 # increment total passports

                # Check if any keys are missing
                if check_keys(dict, req_keys) == false
                    inval += 1

                # Check if values are valid (if valcheck == true)
                elseif valcheck && check_vals(dict) == false
                    inval += 1
                end

                # Empty dict
                dict = Dict()
            end
        end

        # Do a check one more time for last passport entry
        # (last line doesn't catch the [if line != ""] statement)
        if check_keys(dict, req_keys) == false
            inval += 1
        elseif valcheck && check_vals(dict) == false
            inval += 1
        end
        total +=1 
    end

    # Print output
    println(file)
    println("Total\t",total)
    println("Invalid\t",inval)
    println("Valid\t",total-inval)
end

# Function to loop through all req_keys and check for existence
function check_keys(dict, req_keys)
    for key in req_keys
        if haskey(dict, key) == false
            return false
        end
    end
    return true
end

# Function to check values for correctness
function check_vals(dict)

    # Regex matching for each key
    tests = [
        ["byr", r"^(19[2-9]\d|20[0-1]\d|2020)$"],
        ["iyr", r"^(20[1]\d|2020)$"],
        ["eyr", r"^(202\d|2030)$"],
        ["hgt", r"^(1[5-8]\d|19[0-3])cm|(59|6\d|7[0-6])in$"],
        ["hcl", r"^#[a-f0-9]{6}$"],
        ["ecl", r"^(amb|blu|brn|gry|grn|hzl|oth)$"],
        ["pid", r"^[0-9]{9}$"],
    ]

    # Check each value and return false if not valid
    for t in tests
        key = t[1]
        test = t[2]
        if occursin(test, dict[key]) == false
            return false
        end
    end
    return true
end

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
println("============")
test_passports("./input.dat", req_keys, valcheck=true)