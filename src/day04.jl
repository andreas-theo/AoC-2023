module day04
using ParserCombinator: line_at
using ParserCombinator

struct Card
    winning::Set{Int}
    draw::Vector{Int}
end

function build_grammar()
    header = E"Card" + Repeat(E" ", 1, 5) + P"\d+" + E":"
    winning_number = Repeat(E" ", 1, 3) + PInt()
    winning_numbers = winning_number[1:end] |> v -> Set{Int}(v)
    divider = E" |"
    draw_number = Repeat(E" ", 1, 3) + PInt()
    draw_numbers = (draw_number[1:end] + (E"\n" | Eos())) |> v -> Vector{Int}(v)
    (header + winning_numbers + divider + draw_numbers) |> v -> Card(v[1], v[2])
end

function parse_cards(file)
    p = build_grammar()
    map(eachline(file)) do line
        parse_one(line, p) |> only
    end
end

function solve_part_1(file)
    cards = parse_cards(file)
    values = map(cards) do card
        nr_winners = count(card.draw .∈ (card.winning,))
        value = nr_winners > 0 ? 2^(nr_winners - 1) : 0
        value
    end
    sum(values)
end

function solve_part_2(file)
    cards = parse_cards(file)
    copies_of_cards = ones(Int, length(cards))
    for (i, card) in enumerate(cards)
        nr_winners = count(card.draw .∈ (card.winning,))
        copies_of_cards[i+1:i+nr_winners] .+= copies_of_cards[i]
    end
    sum(copies_of_cards)
end

end
