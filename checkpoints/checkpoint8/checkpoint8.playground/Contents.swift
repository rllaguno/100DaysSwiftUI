import Cocoa

protocol Building {
    var rooms: Int { get }
    var cost: Int { get set }
    var estateAgent: String { get set }
    
    func salesSummary()
}

struct House: Building {
    let rooms: Int
    var cost: Int
    var estateAgent: String
    
    func salesSummary() {
        print("House with \(rooms) rooms goes for $\(cost), please contact \(estateAgent)")
    }
}

struct Office: Building {
    let rooms: Int
    var cost: Int
    var estateAgent: String
    
    func salesSummary() {
        print("Office with \(rooms) rooms goes for $\(cost), please contact \(estateAgent)")
    }
}

func inquiry(name: String, building: Building) {
    print("Thank you for contacting us \(name).")
    building.salesSummary()
}

let house = House(rooms: 4, cost: 1_400, estateAgent: "John Smith")
let office = Office(rooms: 8, cost: 3_350, estateAgent: "Angela Watkins")

inquiry(name: "Rodrigo Llaguno", building: house)
inquiry(name: "Rodrigo Llaguno", building: office)
