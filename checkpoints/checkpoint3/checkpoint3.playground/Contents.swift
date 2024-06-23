import Cocoa

for i in 1...100 {
    if i.isMultiple(of: 3) == true && i.isMultiple(of: 5) == false {
        print("Fizz")
    }else if i.isMultiple(of: 3) == false && i.isMultiple(of: 5) == true {
        print("Buzz")
    }else if i.isMultiple(of: 3) == true && i.isMultiple(of: 5) == true {
        print("FizzBuzz")
    }else{
        print(i)
    }
}
