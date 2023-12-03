@testset "Day 01 Tests" begin
    test_str_part_1 = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """
    test_str_part_2 = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """
    @test day01.solve(IOBuffer(test_str_part_1)) == 142
    @test day01.solve2(IOBuffer(test_str_part_2)) == 281
end
