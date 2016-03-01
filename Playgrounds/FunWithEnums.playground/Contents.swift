//: Playground - noun: a place where people can play

import UIKit

/**
 Fun with enums
 */

indirect enum Directions {
    case Forward(Directions)
    case Left(Directions)
    case Right(Directions)
    case Stop
}

extension Directions: CustomStringConvertible {
    var description: String {
        switch self {
        case Forward(_): return "Forward"
        case Left(_): return "Left"
        case Right(_): return "Right"
        case Stop: return "Stop"
        }
    }
}

func evaluate(directions: Directions) {
    print("-> \(directions)")
    switch directions {
    case .Forward(let forward):
        evaluate(forward)
    case .Left(let left):
        evaluate(left)
    case .Right(let right):
        evaluate(right)
    case .Stop:
        break
    }
}

let directions = Directions.Forward(.Left(.Right(.Stop)))
evaluate(directions)
