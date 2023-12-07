module day03

function create_window(arr, pos_s, pos_e, row)
    first_i_rows = firstindex(arr, 1)
    last_i_rows = lastindex(arr, 1)
    window_idx_row_s = max(first_i_rows, row - 1)
    window_idx_row_e = min(row + 1, last_i_rows)
    first_i_cols = firstindex(arr, 2)
    last_i_cols = lastindex(arr, 2)
    window_idx_col_s = max(first_i_cols, pos_s - 1)
    window_idx_col_e = min(pos_e + 1, last_i_cols)
    CartesianIndices((window_idx_row_s:window_idx_row_e, window_idx_col_s:window_idx_col_e))
end

issymbol(c) = !isdigit(c) && !isletter(c) && !isspace(c) && !(c == '.')

function ingest_schematic(path_to_file)
    mapreduce(permutedims ∘ collect, vcat, eachline(path_to_file))
end

function solve_part_1(io::IO)
    # Create a copy in case an IOBuffer is passed so as not to consume the stream
    schematics_to_be_ingested = copy(io)
    schematics = ingest_schematic(schematics_to_be_ingested)
    solve(io, schematics)
end

function solve_part_1(filename::AbstractString)
    schematics = ingest_schematic(filename)
    solve(filename, schematics)
end

function solve(f, schematics)
    acc = 0
    for (i, line) in enumerate(eachline(f))
        for number in eachmatch(r"\d+", line)
            window_idx = create_window(
                schematics,
                number.offset,
                number.offset + length(number.match) - 1,
                i,
            )
            is_part_nr = schematics[window_idx] .|> issymbol |> any
            if is_part_nr
                acc += parse(Int, number.match)
            end
        end
    end
    acc
end

function solve_part_2(io::IO)
    schematics_to_be_ingested = copy(io)
    schematics = ingest_schematic(schematics_to_be_ingested)
    solve_gear_ratios(io, schematics)
end

function solve_part_2(f::AbstractString)
    schematics = ingest_schematic(f)
    solve_gear_ratios(f, schematics)
end

function solve_gear_ratios(f, schematics)
    acc = 0
    for (i, line) in enumerate(eachline(f))
        for number in eachmatch(r"\*", line)
            window = create_window(
                schematics,
                number.offset,
                number.offset + length(number.match) - 1,
                i,
            )
            is_gear = schematics[window] .|> isdigit |> any
            if is_gear
                adjacent_digit_idx = window |> ids -> findall(isdigit, schematics[ids])
                gear_pos = CartesianIndex(i, number.offset)
                adjacent_digit_idx =
                    map(idx -> idx + gear_pos - CartesianIndex(2, 2), adjacent_digit_idx)
                acc += gear_ratio(schematics, adjacent_digit_idx)
            end
        end
    end
    acc
end

function gear_ratio(gears, adjacent_digit_idx)
    seen = Set{CartesianIndex{2}}()
    numbers = Vector{Int}()
    for index in adjacent_digit_idx
        current_pos = index
        adjacents = Vector{Char}()
        while isassigned(gears, current_pos)
            if isassigned(gears, current_pos) &&
               isdigit(gears[current_pos]) &&
               (current_pos ∉ seen)
                push!(seen, current_pos)
                pushfirst!(adjacents, gears[current_pos])
                current_pos -= CartesianIndex(0, 1)
            else
                break
            end
        end
        current_pos = index + CartesianIndex(0, 1)
        while isassigned(gears, current_pos)
            if isassigned(gears, current_pos) &&
               isdigit(gears[current_pos]) &&
               (current_pos ∉ seen)
                push!(seen, current_pos)
                push!(adjacents, gears[current_pos])
                current_pos += CartesianIndex(0, 1)
            else
                break
            end
        end
        !isempty(adjacents) ? push!(numbers, parse(Int, join(adjacents))) : continue
    end
    gear_ratio = length(numbers) == 2 ? prod(numbers) : 0
end

end
