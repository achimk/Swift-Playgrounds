//: Playground - noun: a place where people can play

import UIKit

struct Options: OptionSetType {
    let rawValue: UInt8
    static let None     = Options(rawValue: 0b000)  // 0
    static let First    = Options(rawValue: 0b001)  // 1 << 0
    static let Second   = Options(rawValue: 0b010)  // 1 << 1
    static let Third    = Options(rawValue: 0b100)  // 1 << 2
    static let All: Options = [.First, .Second, .Third]
}

let options: Options = [Options.First, Options.Second]
print(options.rawValue)
