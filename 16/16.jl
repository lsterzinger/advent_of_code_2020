# Function to read the header and 
# return dict of rules and ranges
function read_header(f)
    rules = Dict()
    for line in readlines(f, keep=true)
        if line == "\n" break end
        inst, range = split(line, ": ")
        range = split(range, " or ")
        
        min1, max1 = split(range[1], "-")
        min2, max2 = split(range[2], "-")

        range1 = [parse(Int, x) for x in [min1, max1]]
        range2 = [parse(Int, x) for x in [min2, max2]]

        rules[inst] = [range1, range2]
    end 
    return rules
end


# Get the line numbers for "your ticket" and 
# "nearby tickets"
function get_line_numbers(f)
    my_ticket = 0
    nearby_tickets = 0
    for (i, line) in enumerate(readlines(f))
        if line == "your ticket:"
            my_ticket = i 
        elseif line == "nearby tickets:" 
            nearby_tickets = i 
            break 
        end
    end
    return my_ticket, nearby_tickets
end


# Parse line into array of ticket values
function parse_ticket(line)
    linearr = split(line, ",")
    iline = []
    for c in linearr
        append!(iline, parse(Int, c))
    end
    return iline
end


# Function to check if a ticket (line) is valid
# Requires that ticket already be parsed
function check_ticket_valid(ticket, rules)
    invals = []

    # Loop over all values in ticket
    for val in ticket
        valid = false
        for (rule, lims) in rules
            min1, max1 = lims[1][1], lims[1][2]
            min2, max2 = lims[2][1], lims[2][2]
            
            if min1<=val<=max1 || min2<=val<=max2 valid = true end
        end
        if !valid append!(invals, val) end
    end
    return invals
end


# Main program function
function run_program(file)
    # get rules as dict
    rules = read_header(file)

    # get my ticket and nearby ticket line numbers
    my_ticket, nearby_tickets = get_line_numbers(file)

    # get array of ticket lines
    tickets = readlines(file)[nearby_tickets+1:length(readlines(file))]
    invals = [] # empty array of invalid values

    # loop over all tickets and append to invals if invalid
    for (i,rawticket) in enumerate(tickets)
        ticket = parse_ticket(rawticket)
        ticketcheck = check_ticket_valid(ticket, rules)
        
        # if invalid values not empty, append
        if ticketcheck != []
            append!(invals, ticketcheck)
        end
    end
    println(invals)
    println(sum(invals))
end


rules = run_program("./tickets.txt")
# rules = run_program("./test_input.txt")
# println(parse_line("12,156,6"))
# println(rules)