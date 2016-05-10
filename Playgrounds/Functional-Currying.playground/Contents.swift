//: Playground - noun: a place where people can play

import UIKit
import Foundation

var hello = "Hello, This is a demo for Currying"

// MARK: - Curry
func curry<A, B, R>(f: (A, B) -> R) -> A -> B -> R {
    return { a in { b in f(a, b) } }
}

func curry<A, B, C, R>(f: (A, B, C) -> R) -> A -> B -> C -> R {
    return { a in { b in { c in f(a, b, c) } } }
}

func curry<A, B, C, D, R>(f: (A, B, C, D) -> R) -> A -> B -> C -> D -> R {
    return { a in { b in { c in { d in f(a, b, c, d) } } } }
}

func curry<A, B, C, D, E, R>(f: (A, B, C, D, E) -> R) -> A -> B -> C -> D -> E -> R {
    return { a in { b in { c in { d in { e in f(a, b, c, d, e) } } } } }
}

// MARK: - Operator |> (apply)
infix operator |> { associativity left }
func |> <A, R>(f: A -> R, x: A) -> R {
    return f(x)
}

// **********************************************
// MARK: - Examples

// Ex1: Add, then scale
func addWithScale(op1: Double, op2: Double, scale: Double = 1) -> Double {
    return (op1 + op2) * scale
}

let curriedAddWithScale = curry(addWithScale)
let result1 = curriedAddWithScale |> 1.0 |> 2.0 |> 2.0
let result2 = curriedAddWithScale |> (op1: 1.0) |> (op2: 2.0) |> (scale: 2.0)

// Ex2: Color
let orangeWithAlpha = curry(UIColor.init(red:green:blue:alpha:)) |> 0.945 |> 0.353 |> 0.133
orangeWithAlpha |> 0.9
orangeWithAlpha |> 0.3


// Ex3: Fetch data from path
func fetchData(path: String, successfulHandler: String -> Void, failedHandler: NSError -> Void) {
    // Do something here
}

// conventional implementation
// This is so bad-looking b/c successfulHandler and failedHandler should have the same indent
fetchData("www.mysite.com", successfulHandler: { data in
    // Handle success
    }, failedHandler: { error in
        // Handle failure
})

// Using currying
// The calling is better-looking now
let fetchDataWithHandlers = curry(fetchData) |> "www.mysite.com"
fetchDataWithHandlers
    |> (successful: { data in
        // Handle success
    })
    |> (failed: { error in
        // Handle failure
    })


// The same happen when you use UIView.animateWithDuration
let curriedAnimate = curry(UIView.animateWithDuration(_:animations:completion:))
curriedAnimate
    |> (duration: 0.25)
    |> (animation: { _ in
        // Animation here
    })
    |> (completion: nil)




