//: Playground - noun: a place where people can play

import UIKit
import Foundation

// MARK: Stack example

struct Stack<T>: CustomStringConvertible, SequenceType, CollectionType {
    typealias Element = T
    private var contents: [T] = []
    
    // MARK: Init
    
    init() { }
    init<S: SequenceType where S.Generator.Element == T>(_ sequence: S) {
        contents = Array<T>(sequence)
    }
    
    // MARK: Push / Pop
    
    mutating func push(newElement: T) {
        contents.append(newElement)
    }
    
    mutating func pop() {
        if contents.count > 0 {
            contents.removeLast()
        }
    }
    
    // MARK: CustomStringConvertible
    
    var description: String {
        return "Stack {content: \(contents)}"
    }
    
    // MARK: SequenceType
    
    typealias Generator = AnyGenerator<T>
    
    func generate() -> Generator {
        return AnyGenerator(contents.generate())
    }

    // MARK: CollectionType
    
    typealias Index = Int
    
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return contents.count
    }
    
    subscript(i: Int) -> T {
        return contents[i]
    }
}

// MARK: Example

let initial = [1, 2, 3]
var stack = Stack<Int>(initial)
print(stack)

stack.push(10)
print(stack)

stack.pop()
print(stack)

print("\nSequenceType enumeration:")
for (index, value) in stack.enumerate() {
    print("[\(index)] -> \(value)")
}

print("\nCollectionType enumeration:")
for index in stack.startIndex ..< stack.endIndex {
    print("[\(index)] -> \(stack[index])")
}
