using DelimitedFiles


# Count number of qs in a group
function count_occur(group, qs)
    n = 0
    
    # Loop over qs
    for q in qs
        
        # n++ if q in group
        if q in join(group)
            n +=1
        end
    end
    return n
end

# Count qs answered by each person
function count_each_person(group, qs)
    n = 0 # total number of questions answered by each member
    
    # Loop over questions answered by first member
    for q in group[1]
        dne = true
        for p in range(2,stop = size(group)[1])
            entry = group[p]
            if !(q in entry)
                # Setting to false signals this question did not exist in this response
                dne = false 
            end
        end
        
        # If dne is still true, then increment i
        if dne == true
            n += 1
        end
    end  
    return n
end

# Read file. ('new=true' for part b)
function read_file(file, qs; new=false)
    # using old or new instructions?
    if !new
        count = count_occur
    else
        count = count_each_person
    end
    
    open(file) do f
        ntot = 0
        group = []
        while !eof(f)
            line = readline(f)
            
            # Empty line denotes end of group
            if line == ""
                ntot += count(group, qs)
                group = []
            else
                group = vcat(group, line)
            end
        end
        
        # Count last group before EOF
        ntot += count(group, qs)
        return ntot
    end
end

##############
# START HERE #
##############

file = "./input.txt"

qs = [
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
    'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
]
println("Old instructions:\t", read_file(file, qs))
println("New instructions:\t", read_file(file, qs, new=true))