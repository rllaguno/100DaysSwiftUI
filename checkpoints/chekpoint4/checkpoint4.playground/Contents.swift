import Cocoa

enum sqrtError: Error {
    case outOfBounds, noRoot
}

func squareRoot(of number: Int) throws -> Int {
    if number < 1 || number > 10_000 {throw sqrtError.outOfBounds}
    
    for i in 1...100 {
        if i * i == number {
            return i
        }
    }
    
    throw sqrtError.noRoot
}

let number = 64
do {
    let result = try squareRoot(of: number)
    print("Square root of \(number) is \(result)")
} catch sqrtError.outOfBounds {
    print("Number is out of bounds")
} catch sqrtError.noRoot {
    print("Number does not have an integer root")
}
