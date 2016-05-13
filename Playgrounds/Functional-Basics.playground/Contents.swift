//: Playground - noun: a place where people can play

import UIKit

typealias Filter = Int -> Int

func minimal(minimal: Int) -> Filter {
    return { val in
        min(val, minimal)
    }
}

func maximal(maximal: Int) -> Filter {
    return { val in
        max(val, maximal)
    }
}

func debug(prefix: String = "->") -> Filter {
    return { val in
        print("\(prefix) \(val)")
        return val
    }
}

func compose(lhs: Filter, rhs: Filter) -> Filter {
    return { val in
        rhs(lhs(val))
    }
}

infix operator >>> { associativity left }
func >>> <T>(lhs: T -> T, rhs: T -> T) -> T -> T {
    return { val in
        rhs(lhs(val))
    }
}

let filter = debug("start:") >>> minimal(10) >>> debug("min(10):") >>> maximal(0) >>> debug("max(0):")
let result = filter(-1)
