@testset "Day 03 tests" begin
    schematics_input = raw"""
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598.."""

    expected_matrix = [
        '4' '6' '7' '.' '.' '1' '1' '4' '.' '.'
        '.' '.' '.' '*' '.' '.' '.' '.' '.' '.'
        '.' '.' '3' '5' '.' '.' '6' '3' '3' '.'
        '.' '.' '.' '.' '.' '.' '#' '.' '.' '.'
        '6' '1' '7' '*' '.' '.' '.' '.' '.' '.'
        '.' '.' '.' '.' '.' '+' '.' '5' '8' '.'
        '.' '.' '5' '9' '2' '.' '.' '.' '.' '.'
        '.' '.' '.' '.' '.' '.' '7' '5' '5' '.'
        '.' '.' '.' '$' '.' '*' '.' '.' '.' '.'
        '.' '6' '6' '4' '.' '5' '9' '8' '.' '.'
    ]
    @test day03.ingest_schematic(IOBuffer(schematics_input)) == expected_matrix
    @test day03.solve(IOBuffer(schematics_input), expected_matrix) == 4361
    adjacent_idxs = [CartesianIndex(10, 6), CartesianIndex(8, 7), CartesianIndex(10, 7)]
    @test day03.gear_ratio(expected_matrix, adjacent_idxs) == 451490
    adjacent_idxs = [CartesianIndex(1, 3), CartesianIndex(3, 3), CartesianIndex(3, 4)]
    @test day03.gear_ratio(expected_matrix, adjacent_idxs) == 16345

end
