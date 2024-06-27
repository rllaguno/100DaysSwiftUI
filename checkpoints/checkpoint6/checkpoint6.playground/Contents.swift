import Cocoa

enum gearChange {
    case up, down
}
enum carOnOff {
    case on, off
}

struct Car {
    let model: String
    let seats: Int
    private var turnedOn: Bool
    private var gear: Int
    
    init(model: String, seats: Int) {
        self.model = model
        self.seats = seats
        self.turnedOn = false
        self.gear = 0
    }
    
    mutating func changeGear(change: gearChange){
        if turnedOn == true {
            if change == gearChange.up{
                if gear < 10 {
                    gear += 1
                    print("Gear changed up to: \(gear)")
                }else {
                    print("Gear is at its maximmum value: \(gear)")
                }
            } else {
                if gear <= -1 {
                    print("Gear is at its minimmum value: \(gear)")
                }else {
                    gear -= 1
                    print("Gear changed down to: \(gear)")
                }
            }
        } else {
            print("Car must be turned on first")
        }
    }
    
    mutating func turnOnOff(action: carOnOff){
        if action == carOnOff.on{
            turnedOn = true
            print("Car turned on")
        }
        else{
            turnedOn = false
            print("Car turned off")
        }
    }
    
}

var car = Car(model: "Mazda MX-5", seats: 2)
car.changeGear(change: gearChange.up)
car.turnOnOff(action: carOnOff.on)
car.changeGear(change: gearChange.up)
car.changeGear(change: gearChange.up)
car.changeGear(change: gearChange.up)
car.changeGear(change: gearChange.down)
car.changeGear(change: gearChange.down)
car.changeGear(change: gearChange.down)
car.changeGear(change: gearChange.down)
car.changeGear(change: gearChange.down)
car.changeGear(change: gearChange.up)
car.turnOnOff(action: carOnOff.off)
