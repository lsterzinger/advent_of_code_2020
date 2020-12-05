using DelimitedFiles

# slist = [
    #     "BFFFBBFRRR",
    #     "FFFBBBFRRR",
    #     "BBFFBBFRLL"
    # ]
    
    
function to_rowcol(pass, nrow, ncol)
    r1 = 0
    r2 = nrow - 1
    c1 = 0
    c2 = ncol - 1
    # println(seat)
    for d in pass[1:c2]
        dr = r2 - r1
        
        if d == 'F'
            r2 = floor(r2 - dr/2)    
        elseif d == 'B'
            r1 = ceil(r1 + dr/2)
        end
    end
    
    for d in pass[c2+1:10]
        dc = c2 - c1
        if d == 'L'
            c2 = floor(c2 - dc/2)    
        elseif d == 'R'
            c1 = ceil(c1 + dc/2)
        end
    end
    
    return((r1, c1, (r1*8 + c1)))
end


function process_seat(chart, r, c)
    r = Int(r) + 1
    c = Int(c) + 1

    chart[r,c] = false
    return(chart)
end
    
function find_seat(chart, nrows)
    for r in 1:nrows
        # println(chart[i,:])
        row = chart[r,:]
        if count(row) == 1
            c = findfirst(x->x==true, row)
            return(r-1 , c-1)
        end
    end
end

nrow = 128
ncol = 8

global chart = trues((nrow, ncol))

slist = readdlm("./seats.dat")

global max_id = 0
for pass in slist
    x,y,id = to_rowcol(pass, nrow, ncol)
    global chart = process_seat(chart, x,y)
    global max_id = max(id, max_id)
end

println("Maximum ", max_id)
myr, myc = find_seat(chart, nrow)
println(myr*8 + myc)