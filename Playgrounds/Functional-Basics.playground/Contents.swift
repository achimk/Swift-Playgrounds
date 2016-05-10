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

func compose(lhs: Filter, rhs: Filter) -> Filter {
    return { val in
        rhs(lhs(val))
    }
}

infix operator >>> { associativity left }
func >>> (lhs: Filter, rhs: Filter) -> Filter {
    return { val in
        rhs(lhs(val))
    }
}

let filter = minimal(10) >>> maximal(0)
let result = filter(5)
