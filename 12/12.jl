# Master function to update all positions
function update_pos(pos, inst; p2=false, wpos=nothing)
    # print("$pos => ")
    dir = inst[1]
    amt = parse(Int,inst[2:length(inst)])

    # Handle cardinal commands
    if dir in ['N','W','E','S'] 
        if !p2 pos = cardinal(pos, dir, amt)
        elseif p2 wpos = cardinal(wpos, dir, amt) end

    # Handle L/R commands
    elseif dir in ['L', 'R'] 
        if !p2 pos = lr(pos, dir, amt)
        elseif p2 wpos = wp_lr(wpos, dir, amt) end
        
    # Handle F commands
    elseif dir == 'F' 
        if !p2 pos = cardinal(pos, pos[3], amt) 
        elseif p2 pos = move_to_waypoint(pos, wpos, amt) end
    end
    return (p, wpos)
end

# Move ship amt * wpos
function move_to_waypoint(pos, wpos, amt)
    pos[1] += wpos[1] * amt
    pos[2] += wpos[2] * amt
    return pos
end

# Rotate waypoint
function wp_lr(wpos, dir, amt)
    
    # Some instructions are > 180 degrees, 
    # So convert them to <180 (and flip L/R)
    while amt > 180
        amt -= 180
        if dir == 'L' dir ='R'
        elseif dir == 'R' dir ='L' end
    end

    if amt == 180
        wpos = [-1*wpos[1], -1*wpos[2]]
    elseif dir == 'L' && amt == 90
        wpos = [-1*wpos[2], wpos[1]]
    elseif dir == 'R' && amt == 90
        wpos = [wpos[2], -1 * wpos[1]]
    else println("ERROR $dir, $amt" )
    end 

    return wpos
end

# Move according to cardial dirs
# (can be used on ship or waypoint)
function cardinal(pos, dir, amt)
    if dir == 'N' pos[2] += amt 
    elseif dir == 'E' pos[1] += amt
    elseif dir == 'W' pos[1] -= amt
    elseif dir == 'S' pos[2] -= amt
    end
    return pos
end

# Rotate the ship left/right without moving position
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

# Calculate manhattan distance
function  manhattan_distance(pos)
   return abs(pos[1]) + abs(pos[2]) 
end

instructions = [
    "F10",
    "N3",
    "F7",
    "R90",
    "F11",
]

instructions = readlines("./instructions.txt")

global p = [0,0,'E']
global wp = [10, 1]
for i in instructions
    global (p, wp) = update_pos(p, i)
end
println("Part 1: ", manhattan_distance(p))

# println("Inst\tShip\t\t\tWP")
global p = [0,0,'E']
global wp = [10, 1]
for i in instructions
    global (p, wp) = update_pos(p, i, p2=true, wpos = wp)
    # println("$i\t$p\t$wp")
end
println("Part 2: ", manhattan_distance(p))