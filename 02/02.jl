using DelimitedFiles
using Printf

function check_valid_old(line)
    range = split(line[1], "-")
    r1, r2 = parse(Int64, range[1]) , parse(Int64, range[2])
    letter = line[2][1]
    passwd = line[3]

    num_letter = 0
    # Loop over password letters
    for c in passwd
        if c == letter
            num_letter += 1
        end
    end

    if (num_letter >= r1) && (num_letter <= r2)
        return true
    else
        return false
    end

end

function check_valid_new(line)
    range = split(line[1], "-")
    r1, r2 = parse(Int64, range[1]) , parse(Int64, range[2])
    letter = line[2][1]
    passwd = line[3]
    # println(passwd[r1], " ", passwd[r2])
    if xor((passwd[r1] == letter), (passwd[r2] == letter))
        return true
    else
        return false
    end
end

function count_true(list,method)
    num_false = 0
    
    if method == "old"
        check_valid = check_valid_old
    elseif method == "new"
        check_valid = check_valid_new
    end

    for i in 1:size(list)[1]
        if check_valid(list[i,:]) == true
            num_false += 1
        end
    end

    return num_false
end

list = readdlm("./input.dat")
println("Old: ",count_true(list, "old"))
println("New: ",count_true(list, "new"))