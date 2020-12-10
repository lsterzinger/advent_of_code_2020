using Combinatorics

# Checks if val is sum of n values in arr
function is_sum(val, arr; n=2)
    s = with_replacement_combinations(arr, n)
    sums = []
    for i in s
        push!(sums, sum(i))
    end

    if val in sums
        return true
    else
        return false
    end
end

# Check all vals in a window of size preamble
function check_vals(file; preamble = 25)
    i = 1
    while i <= (length(file) - preamble)
        j = i + preamble - 1
        arr = file[i:j]
        val = file[j+1]

        if is_sum(val, arr)
            i += 1
        else
            return val
        end
    end
end

# Function to find the weakness
# Defined as the sum of the min and max
# values of a continuous section of code
# that sum to the invalid value
function find_weakness(file, val)
    i = 1
    di = 1
    
    # Do forever!
    while true
        j = i + di
        arr = file[i:j]
        s = sum(arr)

        if s == val
            return minimum(arr) + maximum(arr)
        elseif s > val
            i += 1
            di = 1
        else
            di += 1
        end
    end
     
end

# Test values
test_vals = [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576,]

data =  parse.(Int, readlines("./XMAS_data.txt"))
println("Test: ", check_vals(test_vals, preamble=5))
inval = check_vals(data)
println("Real: ", inval)
println("Encryption weakness: ", find_weakness(data, inval))
