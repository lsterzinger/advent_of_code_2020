using DelimitedFiles
using Printf
nums = readdlm("./input_a.dat")
#println(nums)
n = length(nums)
n2 = Int(n/2)

for i  = 1:200
    for j = 1:200
        a = nums[i]
        b = nums[j]
        if i != j
            if a+b == 2020
                @printf("Double! %.0f * %.0f = %.0f\n", a,b,a*b)
                
            end
            for k = 1:200
                c = nums[k]
                if i != j != k
                    if a + b + c == 2020
                        @printf("Triple! %.0f * %.0f * %.0f = %.0f\n", a,b,c,a*b*c)
                    end
                end
            end
        end
    end
end