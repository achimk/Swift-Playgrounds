//: Playground - noun: a place where people can play

import UIKit

/**
 Basic Generic Protocols
 */

protocol Edible { }
protocol Meaty: Edible { }
protocol Veggie: Edible { }

protocol Eating {
    typealias FoodType: Edible
    func eat(food: FoodType)
}

extension Eating {
    func eat(food: FoodType) {
        print("\(self.dynamicType): nom, nom, nom")
    }
}

protocol Cuddly {
    func cuddle(cuddlee:Cuddly) // Using cuddle(cuddlee:Self) make this protocol Generic
    func findCuddlePartner() -> Self
}

/**
 Generic Types
 */

class DogFood: Meaty { }
class Lettuce: Veggie { }

class Dog<Food: Meaty>: Eating {
    typealias FoodType = Food
}

class Rabbit<Food: Veggie>: Eating {
    typealias FoodType = Food
}

let dog = Dog<DogFood>()
let dogFood = DogFood()
dog.eat(dogFood)

let rabbit = Rabbit<Lettuce>()
let lettuce = Lettuce()
rabbit.eat(lettuce)

// error: rabbit.eat(dogFood)
// error: dog.eat(lettuce)

/**
 Thunk
 */
class EatingThunk<Food: Edible>: Eating {
    private let _eat: (food: Food) -> (Void)
    
    init<Wrapped: Eating where Wrapped.FoodType == Food>(_ wrapped: Wrapped) {
        _eat = wrapped.eat
    }
    
    func eat(food: Food) {
        _eat(food: food)
    }
}

let dogFoodEater: EatingThunk<DogFood> = EatingThunk(dog)
dogFoodEater.eat(dogFood)
// error: dogFoodEater.eat(lettuce)

let lettuceEater: EatingThunk<Lettuce> = EatingThunk(rabbit)
lettuceEater.eat(lettuce)
// error: lettuceEater.eat(dogFood)




