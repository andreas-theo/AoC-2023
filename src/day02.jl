module day02

const max_red = 12
const max_green = 13
const max_blue = 14

function parse_game(game_records)
    lines = filter(v -> v != "", split(game_records, "\n"))
    parse_line.(lines)
end

function parse_line(s)
    balls_in_game = getindex(split(s, ": "), 2)
    balls_per_round = split(balls_in_game, "; ")
    parse_round.(balls_per_round)
end

function parse_round(balls_in_round)
    colours = Dict("red" => 0, "green" => 0, "blue" => 0)
    for round in split(balls_in_round, ", ")
        count, colour = split.(round, " ")
        colours[colour] += parse(Int, count)
    end
    colours
end

is_round_valid(round) =
    (round["red"] ≤ max_red) && (round["green"] ≤ max_green) && (round["blue"] ≤ max_blue)

is_game_valid(rounds) = all(is_round_valid.(rounds))

end
