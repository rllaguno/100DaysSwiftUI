import Cocoa

let numbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

func luckyNumber(inputNumbers: [Int], evenFilter: (_ array: [Int]) -> [Int], ascendingFilter: (_ array: [Int]) -> [Int], mapFilter: (_ array: [Int]) -> [String]) -> [String] {
    mapFilter(ascendingFilter(evenFilter(numbers)))
}

let stringLuckyNumbers = luckyNumber(inputNumbers: numbers){ array -> [Int] in
    array.filter { $0 % 2 == 1 }
} ascendingFilter: { array in
    array.sorted { $0 < $1 }
} mapFilter: { array in
    array.map { String("\($0) is a lucky number")}
}

for i in stringLuckyNumbers {
    print(i)
}
