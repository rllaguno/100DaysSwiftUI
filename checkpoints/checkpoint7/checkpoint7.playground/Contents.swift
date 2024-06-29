import Cocoa

class Animal {
    let legs: Int
    
    init(){
        legs = 4
    }
}

class Dog: Animal {
    func speak() {
        print("Bark Bark")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Corgi Bark Bark")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Poodle Bark Bark")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init()
    }
    
    func speak() {
        print("Meow Meow")
    }
}

class Persian: Cat {
    override func speak() {
        print("Cat Meow Meow")
    }
}

class Lion: Cat {
    override func speak() {
        print("Lion Roar Roar")
    }
}

let petDog = Corgi()
print("My pet corgi has \(petDog.legs) legs")
petDog.speak()

let petDog2 = Poodle()
print("My pet poodle has \(petDog.legs) legs")
petDog2.speak()

let petCat = Persian(isTame: true)
print("My pet cat has \(petCat.legs) legs and is \(petCat.isTame == true ? "tame" : "not tame")")
petCat.speak()

let wildCat = Lion(isTame: false)
print("The wild cat has \(wildCat.legs) legs and is \(wildCat.isTame ? "tame" : "not tame")")
wildCat.speak()
