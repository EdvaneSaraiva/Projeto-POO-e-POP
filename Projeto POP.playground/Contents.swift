import UIKit


protocol Car {
    var idNumber: Int { get }
    var name: String { get }
    var canParkItself: Bool { get }
}

protocol AutomaticPilot {
    var hasOnboardComputer: Bool { get }
}

protocol Speed {
    mutating func topSpeed()
}

extension Car {
    var canParkItself: Bool { return self is AutomaticPilot }
}

struct Ferrari: Car, AutomaticPilot {
    let idNumber: Int
    let name: String
    let maximumSpeed: Double
    let hasOnboardComputer: Bool
}

extension Ferrari: Speed {
    func topSpeed() {
        print("A Velocidade máxima do carro \(name) é \(maximumSpeed)")
    }
}

class Mclaren: Car, Speed {
    var idNumber: Int = 0
    var name: String = ""
    var canParkItself: Bool = false
    var maximumSpeed: Double = 0.0
    
    init(idNumber: Int, name: String, maximumSpeed: Double) {
        self.idNumber = idNumber
        self.name = name
        self.maximumSpeed = maximumSpeed
    }
    
    func topSpeed() {
        print("A Velocidade máxima do carro \(name) é \(maximumSpeed)")
    }
}

func fetchCarId(from server: String) async -> Int {
    if server == "primary" {
        return 121212
    }
    return 134562
}

func fetchCarName(from server: String) async -> String {
    let carId = await fetchCarId(from: server)
    if carId == 134562 {
        return "Ferrari"
    }
    return "Mclaren"
}

func connectUser(to server: String) async {
    async let carId = fetchCarId(from: server)
    async let carName = fetchCarName(from: server)
    let message = await "O \(carName), tem ID \(carId)"
    print(message)
}

func main() {
    var ferrari = Ferrari(idNumber: 134562, name: "Ferrari", maximumSpeed: 340.0, hasOnboardComputer: false)
    ferrari.topSpeed()
    print("A \(ferrari.name) pode estacionar sozinho? \(ferrari.canParkItself ? "Sim!" : "Não")")
    var maclaren = Mclaren(idNumber: 121212, name: "Mclaren", maximumSpeed: 330.0)
    maclaren.topSpeed()
    
    Task {
        await connectUser(to: "primary")
    }
}

main()
