using DelimitedFiles
using Printf

function count_trees(slope_file, dh, dv)
    nrows = size(slope_file)[1]
    ncol = length(slope_file[1])

    position = 1
    tree_count = 0
    println(ncol)
    for vert in 1+dv:dv:(nrows-dv)
        horiz = position + dh
        if horiz > ncol
            horiz = horiz - position - 1
        end 
        # println(vert, " ", horiz)

        if slope_file[vert][horiz] == '#'
            tree_count += 1
        end 
        
        position = horiz
    end

    return tree_count
end

slope = readdlm("./input.dat")
println(count_trees(slope, 3, 1))