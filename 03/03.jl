using DelimitedFiles
using Printf

function count_trees(sf, dh, dv)
    nrows = size(sf)[1]
    ncols = length(sf[1,1][:])
    
    pos = 1
    ntree = 0
    
    for i in 1+dv:dv:nrows
        # println(i)
        # println(sf[i,1][:])

        pos = pos + dh
        if pos > ncols
            pos = pos - ncols
        end

        if sf[i,1][pos] == '#'
            ntree += 1
        end
    end
    return ntree
end

slope = readdlm("./input.dat")

println("Part a:\t", count_trees(slope, 3, 1))

a = count_trees(slope, 1, 1)
b = count_trees(slope, 3, 1)
c = count_trees(slope, 5, 1)
d = count_trees(slope, 7, 1)
e = count_trees(slope, 1, 2)

println("===================")
println("R1, D1\t", a)
println("R3, D1\t", b)
println("R5, D1\t", c)
println("R7, D1\t", d)
println("R1, D2\t", e)
println("===================")
println("Product: ", a*b*c*d*e)