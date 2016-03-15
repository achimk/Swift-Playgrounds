//: Playground - noun: a place where people can play

import UIKit

enum Error: ErrorType {
    case ResponseFileEmpty(filename: String)
    case ResponseFileNotExists(filename: String)
    case ResponseFileReadFailed(filename: String)
    case ResponseFileEncodingFailed(filename: String)
    case ResponseFileIsNotFileReference(url: NSURL)
}

extension Error: CustomStringConvertible {
    var description: String {
        switch self {
        case .ResponseFileEmpty(let filename):
            return "🚨 Empty response file: \(filename)"
        case .ResponseFileNotExists(let filename):
            return "🚨 Failed to find a response file: \(filename)"
        case .ResponseFileReadFailed(let filename):
            return "🚨 Failed to open a response file: \(filename)"
        case .ResponseFileEncodingFailed(let filename):
            return "🚨 Failed to encode a response file: \(filename)"
        case .ResponseFileIsNotFileReference(let url):
            return "🚨 Failed to open an url (not a file reference): \(url)"
        }
    }
}

func data(filename: String, response: String?, parameters: [String : String] = [:]) throws -> NSData {
    let bundle = NSBundle.mainBundle()
    let name = (filename as NSString).stringByDeletingPathExtension
    let extention = (filename as NSString).pathExtension
    guard let path = bundle.pathForResource(name, ofType: extention) else {
        throw Error.ResponseFileNotExists(filename: filename)
    }
    
    let url = NSURL(fileURLWithPath: path)
    
    if url.isFileReferenceURL() {
        throw Error.ResponseFileIsNotFileReference(url: url)
    }
    
    let filename = url.lastPathComponent!
    var response: String?
    do {
        response = try String(contentsOfURL: url, encoding: NSUTF8StringEncoding)
    } catch _ {
        throw Error.ResponseFileReadFailed(filename: filename)
    }
    
    guard var output = response where output.characters.count > 0 else {
        throw Error.ResponseFileEmpty(filename: filename)
    }
    
    for (key, value) in parameters {
        output = output.stringByReplacingOccurrencesOfString(key, withString: value)
    }
    
    guard let data = output.dataUsingEncoding(NSUTF8StringEncoding) else {
        throw Error.ResponseFileEncodingFailed(filename: filename)
    }
    
    return data
}

do {
    let response = try data("test.txt", response: "")
} catch {
    print(error)
}
