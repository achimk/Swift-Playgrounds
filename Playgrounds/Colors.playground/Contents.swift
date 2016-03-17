//: Playground - noun: a place where people can play

import UIKit
import Foundation


enum Color: UInt {
    case Black  = 0xff000000
    case Red    = 0xffff0000
    case Green  = 0xff00ff00
    case Blue   = 0xff0000ff
    case White  = 0xffffffff
}

extension Color {
    func toColor() -> UIColor {
        let r = (self.rawValue >> 16) & 0xff
        let g = (self.rawValue >> 8) & 0xff
        let b = self.rawValue & 0xff
        let a = (self.rawValue >> 24) & 0xff
        return UIColor(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: CGFloat(a) / 255.0)
    }
}

Color.Black.toColor()
Color.Red.toColor()
Color.Green.toColor()
Color.Blue.toColor()
Color.White.toColor()

class InternalColor: UIColor, IntegerLiteralConvertible {
    convenience required init(integerLiteral value: Int) {
        let r = (value >> 16) & 0xff
        let g = (value >> 8) & 0xff
        let b = value & 0xff
        let a = (value >> 24) & 0xff
        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: CGFloat(a) / 255.0)
    }
}

enum AppColor: InternalColor {
    case Black  = 0xff000000
    case Red    = 0xffff0000
    case Green  = 0xff00ff00
    case Blue   = 0xff0000ff
    case White  = 0xffffffff
}

AppColor.Black.rawValue
AppColor.Red.rawValue
AppColor.Green.rawValue
AppColor.Blue.rawValue
AppColor.White.rawValue

