//: Playground - noun: a place where people can play

import UIKit
import Foundation
import XCPlayground

struct Index: RandomAccessIndexType, CustomStringConvertible {
    let value: Int
    
    var description: String {
        return "Index { \(value) }"
    }
    
    init() {
        self.value = 0
    }
    
    init(_ index: Int) {
        self.value = index
    }
    
    func successor() -> Index {
        return Index(value.successor())
    }
    
    func predecessor() -> Index {
        return Index(value.predecessor())
    }
    
    func advancedBy(n: Int) -> Index {
        return Index(value + n)
    }
}

extension Index: Equatable { }
func ==(lhs: Index, rhs: Index) -> Bool {
    return lhs.value == rhs.value
}

example("Init") {
    let item = Index()
    print(item)
}

example("Successor") {
    let item = Index()
    print(item)
    print(item.successor())
}

example("Predecessor") {
    let item = Index()
    print(item)
    print(item.predecessor())
}

example("Advance by 2") {
    let item = Index()
    print(item)
    print(item.advancedBy(2))
}

example("Advance by limit 12") {
    let item = Index()
    print(item)
    print(item.advancedBy(12, limit: Index(5)))
}

example("Distance to 5") {
    let item = Index()
    print(item)
    print(item.distanceTo(Index(5)))
}

example("Stride to 10 by 2") {
    let item = Index()
    let strider = item.stride(to: Index(10), by: 2)
    for stride in strider {
        print(stride)
    }
}

example("Stride through 10 by 2") {
    let item = Index()
    let strider = item.stride(through: Index(10), by: 2)
    for stride in strider {
        print(stride)
    }
}