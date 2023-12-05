module day02
using ParserCombinator

const max_red = 12
const max_green = 13
const max_blue = 14

@kwdef struct Drawset
    red::Int = 0
    green::Int = 0
    blue::Int = 0
end

@kwdef struct Game
    game_id::Int = 0
    drawsets::Vector{Drawset}
end

function build_grammar()
    header = E"Game " + PInt() + E":"
    red = Equal("red")
    green = Equal("green")
    blue = Equal("blue")
    draw =
        E" " + PInt() + E" " + (red | green | blue) + Star(E",") |>
        v -> Symbol(v[2]) => v[1]
    drawset = Repeat(draw, 1, 3) + (E";" | E"\n" | Eos()) |> v -> Drawset(; v...)
    drawsets = drawset[1:end]
    game = header + drawsets |> v -> Game(v[1], v[2:end])
    game
end

function parse_game(game_record)
    game = build_grammar()
    map(eachline(game_record)) do line
        parse_one(line, game) |> only
    end
end

is_round_valid(draw) =
    (draw.red ≤ max_red) && (draw.green ≤ max_green) && (draw.blue ≤ max_blue)

is_game_valid(rounds) = all(is_round_valid.(rounds))

function sum_valid_game_ids(game_record)
    games = parse_game(game_record)
    valid_ids = getfield.(games[is_game_valid.(getfield.(games, :drawsets))], :game_id)
    sum(valid_ids)
end

end
