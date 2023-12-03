module day01

function solve(input)
    cal_document = eachline(input)
    process(cal_document)
end

function process(lines)
    cal_digits = filter.(isdigit, lines)
    cal_numbers = map(filtered -> first(filtered) * last(filtered), cal_digits)
    sum(s -> parse(Int, s), cal_numbers)
end

function solve2(input)
    cal_document = eachline(input)
    # cal_document_fixed =
    #     replace.(
    #         cal_document,
    #         "one" => "o1e",
    #         "two" => "2o",
    #         "three" => "3e",
    #         "four" => "4",
    #         "five" => "5e",
    #         "six" => "6",
    #         "seven" => "7n",
    #         "eight" => "e8t",
    #         "nine" => "9e",
    #     )

    # The documentation of replace states "Multiple patterns can be specified,
    # and they will be applied left-to-right simultaneously, so only one pattern
    # will be applied to any character, and the patterns will only be applied to
    # the input text, not the replacements." So we cannot do the replacements in
    # one go without losing adjacent words. We have to break it up into groups.
    cal_document_fixed =
        replace.(
            replace.(
                replace.(cal_document, "eight" => "e8t", "seven" => "7n"),
                "one" => "o1",
                "six" => "6",
                "nine" => "9",
                "three" => "3",
                "four" => "4",
                "five" => "5",
            ),
            "two" => "2",
        )
    process(cal_document_fixed)
end

end
