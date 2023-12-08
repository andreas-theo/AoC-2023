@testset "Day 04 tests" begin
    test_str = """Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
    Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
    Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
    Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
    Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"""
    p = day04.build_grammar()
    expected_out = [
        day04.Card(Set([83, 41, 86, 17, 48]), [83, 86, 6, 31, 17, 9, 48, 53]),
        day04.Card(Set([32, 13, 16, 20, 61]), [61, 30, 68, 82, 17, 32, 24, 19]),
        day04.Card(Set([59, 21, 44, 1, 53]), [69, 82, 63, 72, 16, 21, 14, 1]),
        day04.Card(Set([84, 92, 41, 69, 73]), [59, 84, 76, 51, 58, 5, 54, 83]),
        day04.Card(Set([83, 32, 26, 87, 28]), [88, 30, 70, 12, 93, 22, 82, 36]),
        day04.Card(Set([13, 56, 18, 31, 72]), [74, 77, 10, 23, 35, 67, 36, 11]),
    ]
    cards = day04.parse_cards(IOBuffer(test_str))
    @test getfield.(cards, :winning) == getfield.(expected_out, :winning)
    @test getfield.(cards, :draw) == getfield.(expected_out, :draw)
    @test day04.solve_part_1(IOBuffer(test_str)) == 13
end
