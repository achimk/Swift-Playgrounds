//: Playground - noun: a place where people can play

import UIKit

protocol Wheel {
    var name: String { get }
}

extension Wheel {
    var name: String {
        return ""
    }
}

class GoldenWheel: Wheel {
    var name: String {
        return "Golden"
    }
}
class SilverWheel: Wheel {
    var name: String {
        return "Silver"
    }
}
class PlatiniumWheel: Wheel {
    var name: String {
        return "Platinium"
    }
}

class AnyVehicle {
    
    var wheels: Wheel
    
    init(numberOfWheels: Wheel) {
        self.wheels = numberOfWheels
    }
}

class Vehicle<WheelType: Wheel>: AnyVehicle {
    typealias Wheel = WheelType
    
    init(numberOfWheels: WheelType) {
        super.init(numberOfWheels: numberOfWheels)
    }
}

extension Vehicle {
    func flatMap() -> WheelType? {
        return self.wheels as? WheelType
    }
}

let v = [Vehicle<GoldenWheel>(numberOfWheels: GoldenWheel()), Vehicle<SilverWheel>(numberOfWheels: SilverWheel()), Vehicle<GoldenWheel>(numberOfWheels: GoldenWheel()), Vehicle<SilverWheel>(numberOfWheels: SilverWheel()), AnyVehicle(numberOfWheels:PlatiniumWheel())]

var descriptions = [String]()
v.forEach {
    descriptions.append($0.wheels.name)
}

print(descriptions)

