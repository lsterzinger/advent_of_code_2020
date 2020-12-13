function update_pos(pos, inst)
    # print("$pos => ")
    dir = inst[1]
    amt = parse(Int,inst[2:length(inst)])

    if dir in ['N','W','E','S'] pos = cardinal(pos, dir, amt)

    elseif dir in ['L', 'R'] pos = lr(pos, dir, amt)
    
    elseif dir == 'F' pos = cardinal(pos, pos[3], amt) end
end

function cardinal(pos, dir, amt)
    if dir == 'N' pos[2] += amt 
    elseif dir == 'E' pos[1] += amt
    elseif dir == 'W' pos[1] -= amt
    elseif dir == 'S' pos[2] -= amt
    end
    return pos
end

function lr(pos, dir, amt)
    headings = Dict('N' => 0, 'E' => 90, 'S' => 180, 'W' => 270)
    inv_headings = Dict(value => key for (key, value) in headings)
    h = headings[pos[3]]

    if dir == 'L' h -= amt
    elseif dir == 'R' h += amt end 

    if h >= 360 h-= 360 
    elseif h < 0 h+= 360 end
    pos[3] = inv_headings[h]
    return pos
end

function  manhattan_distance(pos)
   return abs(pos[1]) + abs(pos[2]) 
end

test_in = [
    "F10",
    "N3",
    "F7",
    "R90",
    "F11",
]



global p = [0,0,'E']
for i in readlines("./instructions.txt")
    global p = update_pos(p, i)
end
println(manhattan_distance(p))