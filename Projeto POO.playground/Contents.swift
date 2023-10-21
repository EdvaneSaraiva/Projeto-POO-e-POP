import UIKit

enum Category: String {
    case terrestrial
    case aerial
    case aquatic
}

struct Measure {
    var weight = 0.0
    
    init(weight: Double = 0.0) {
        self.weight = weight
    }
    
    func simpleDescription() -> String {
        return "pesa \(weight) kilos"
    }
}

class Vehicle {
    var color: String = ""
    var category: Category
    var name: String = ""
    
    init(color: String, category: Category, name: String) {
        self.color = color
        self.category = category
        self.name = name
    }
    
    func move(vehicle: String) {
        print("O \(vehicle) andou")
    }
}

class Car: Vehicle {
    
    private var idNumber: Int
    var measure: Measure
    var doorsCount: Int = 0
    
    init(color: String, category: Category, name: String, idNumber: Int, doorsCount: Int, measure: Measure) {
        self.idNumber = idNumber
        self.doorsCount = doorsCount
        self.measure = measure
        super.init(color: color, category: category, name: name)
    }
    
    func printIdNumber() {
        print("O Chassi do carro é \(idNumber)")
    }
}

class Plane: Vehicle {
    override func move(vehicle: String) {
        fly(vehicle: vehicle)
    }

    private func fly(vehicle: String) {
        print("O avião da \(vehicle) voou!")
    }

}

func listCars(cars: [Car]) {
    print("\nLista de carros:")
    for car in cars {
        print(car.name)
    }
    print("")
}

func printHeavierCar(cars: [Car], verifyHeavier: ([Car]) -> String) {
    print(verifyHeavier(cars))
}

func checkHeavier(cars: [Car]) -> String {
    var heavierCar: Car? = cars[0]
    for i in 0..<cars.count - 1 {
        if cars[i].measure.weight < cars[i+1].measure.weight {
            heavierCar = cars[i+1]
        }
    }
    if let heavierCar = heavierCar {
        return "O carro mais pesado é o \(heavierCar.name) \n"
    } else {
        return "Não possui carro mais pesado"
    }
}

func checkCarWeight(measure: Measure) {
    switch measure.weight {
    case 0...3500:
        print("Veículo leve")
    default:
        print("Veículo pesado")
    }
}


func main() {
    let car = Car(color: "Vermelho", category: Category.terrestrial, name: "Fusca", idNumber: 123456, doorsCount: 3, measure: Measure(weight: 1364))
    car.move(vehicle: car.name)
    print("O \(car.name) tem \(car.doorsCount) portas")
    print("O \(car.name) é um veículo \(car.category)" )
    print("O \(car.name) \(car.measure.simpleDescription())")
    car.printIdNumber()
    
    let car2 = Car(color: "Preto", category: Category.terrestrial, name: "Onix Plus", idNumber: 654321, doorsCount: 5, measure: Measure(weight: 1112))
    
    let car3 = Car(color: "branco", category: Category.terrestrial, name: "Corolla", idNumber: 123123, doorsCount: 5, measure: Measure(weight: 1485))
    print("O \(car3.name) é \(car3.color)\n")
    
    var cars: [Car] = []
    cars.append(car)
    cars.append(car2)
    cars.append(car3)
    listCars(cars: cars)
    printHeavierCar(cars: cars, verifyHeavier: checkHeavier)
    
    car3.color = "Rosa"
    print("Agora o \(car3.name) é \(car3.color)\n")
    
    let plane = Plane(color: "Branco", category: Category.aerial, name: "Gol")
    plane.move(vehicle: "Gol")
    print("O Avião da \(plane.name) é \(plane.color)")
    print("O Avião da \(plane.name) é um veículo \(plane.category)")
    
    checkCarWeight(measure: car.measure)
}

main()


