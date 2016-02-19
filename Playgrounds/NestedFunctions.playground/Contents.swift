//: Playground - noun: a place where people can play

import UIKit
import Foundation

typealias TaxCallback = Double -> Double

func applySalesTaxForState(state: String) -> TaxCallback {
    func applyTN(amount: Double) -> Double { return amount * 0.07 }
    func applyDE(amount: Double) -> Double { return amount * 0.06 }
    func applyPA(amount: Double) -> Double { return amount * 0.04 }
    func applyGeneric(amount: Double) -> Double { return amount * 0.05 }
    
    
    switch state {
    case "TN": return applyTN
    case "DE": return applyDE
    case "PA": return applyPA
    default: return applyGeneric
    }
}

let taxForPA = applySalesTaxForState("PA")
let tax = taxForPA(100)
print(tax)
