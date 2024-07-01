import Cocoa

func randomInt(array: [Int]?) -> Int { array?.randomElement() ?? Int.random(in: 1...100) }

let intArray: [Int]? = [9, 18, 93, 35, 68, 49, 81, 2]
print(randomInt(array: intArray))

let nilIntArray: [Int]? = nil
print(randomInt(array: nilIntArray))
