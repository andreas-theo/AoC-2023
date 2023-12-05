function ≂(x, y)
    if !isempty(fieldnames(typeof(x))) && typeof(x) == typeof(y)
        mapreduce(
            n -> getfield(x, n) == getfield(y, n),
            (a, b) -> a && b,
            fieldnames(typeof(x)),
        )
    else
        x == y
    end
end

@testset "Day 02 Tests" begin
    test_day_02 = """Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """
    test_day_02_res = [
        day02.Game(
            1,
            day02.Drawset[
                day02.Drawset(4, 0, 3),
                day02.Drawset(1, 2, 6),
                day02.Drawset(0, 2, 0),
            ],
        ),
        day02.Game(
            2,
            day02.Drawset[
                day02.Drawset(0, 2, 1),
                day02.Drawset(1, 3, 4),
                day02.Drawset(0, 1, 1),
            ],
        ),
        day02.Game(
            3,
            day02.Drawset[
                day02.Drawset(20, 8, 6),
                day02.Drawset(4, 13, 5),
                day02.Drawset(1, 5, 0),
            ],
        ),
        day02.Game(
            4,
            day02.Drawset[
                day02.Drawset(3, 1, 6),
                day02.Drawset(6, 3, 0),
                day02.Drawset(14, 3, 15),
            ],
        ),
        day02.Game(5, day02.Drawset[day02.Drawset(6, 3, 1), day02.Drawset(1, 2, 2)]),
    ]
    parsed_res = day02.parse_game(IOBuffer(test_day_02))
    @test getfield.(parsed_res, :game_id) == getfield.(test_day_02_res, :game_id)
    @test getfield.(parsed_res, :drawsets) == getfield.(test_day_02_res, :drawsets)
    valid_games = BitVector((true, true, false, false, true))
    test_drawsets = getfield.(test_day_02_res, :drawsets)
    @test day02.is_game_valid.(test_drawsets) == valid_games
end
