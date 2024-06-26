import Cocoa

let numbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

let even = { (numbers: [Int]) -> [Int] in
    return numbers.filter{ !$0.isMultiple(of: 2) }
}

let ascending = {(numbers: [Int]) -> [Int] in
    return numbers.sorted()
}

let format = { (numbers: [Int]) -> [String] in
    return numbers.map {String("\($0) is my lucky number")}
}

func luckyNumbers(numbers: [Int]) -> [String] {
    return format(ascending(even(numbers)))
}

let lucky = luckyNumbers(numbers: numbers)
for i in lucky {
    print(i)
}
