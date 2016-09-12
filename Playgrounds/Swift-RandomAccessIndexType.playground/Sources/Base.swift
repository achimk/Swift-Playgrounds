import UIKit
import Foundation
import XCPlayground

public func playgroundShouldContinueIndefinitely() {
    XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
}

infix operator >>> { associativity left }
public func >>> <T>(lhs: T -> T, rhs: T -> T) -> T -> T {
    return { val in
        rhs(lhs(val))
    }
}

public func example(description: String? = nil, action: Void -> Void) {
    if let description = description {
        print("\n--- \(description) example ---")
        action()
    } else {
        action()
    }
}

public func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
