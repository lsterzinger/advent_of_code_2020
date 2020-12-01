using DelimitedFiles
using Printf
using Combinatorics

# Import Data
nums = readdlm("./input_a.dat")

# Function to check all possible sums of `arr` in groups of `n` that equal `target`
function check_sums(arr, n, target)
    pairs = collect(combinations(arr, n))
    for p in pairs
        if sum(p) == target
            @printf("Combination of %d values that results in %d\n", n, target)
            println(p)
            @printf("Sum: %i\tProduct: %i\n\n", sum(p), prod(p))
            return p
        end
    end
end

check_sums(nums, 2, 2020) # Check 2 values that sum to 2020
check_sums(nums, 3, 2020) # Check 3 values that sum to 2020
