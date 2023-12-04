@testset "Day 02 Tests" begin
    test_day_02 = """Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """
    test_day_02_res = [
        [
            Dict("blue" => 3, "green" => 0, "red" => 4),
            Dict("blue" => 6, "green" => 2, "red" => 1),
            Dict("blue" => 0, "green" => 2, "red" => 0),
        ],
        [
            Dict("blue" => 1, "green" => 2, "red" => 0),
            Dict("blue" => 4, "green" => 3, "red" => 1),
            Dict("blue" => 1, "green" => 1, "red" => 0),
        ],
        [
            Dict("blue" => 6, "green" => 8, "red" => 20),
            Dict("blue" => 5, "green" => 13, "red" => 4),
            Dict("blue" => 0, "green" => 5, "red" => 1),
        ],
        [
            Dict("blue" => 6, "green" => 1, "red" => 3),
            Dict("blue" => 0, "green" => 3, "red" => 6),
            Dict("blue" => 15, "green" => 3, "red" => 14),
        ],
        [
            Dict("blue" => 1, "green" => 3, "red" => 6),
            Dict("blue" => 2, "green" => 2, "red" => 1),
        ],
    ]
    @test day02.parse_game(test_day_02) == test_day_02_res
    valid_games = BitVector((true, true, false, false, true))
    @test day02.is_game_valid.(test_day_02_res) == valid_games
end
