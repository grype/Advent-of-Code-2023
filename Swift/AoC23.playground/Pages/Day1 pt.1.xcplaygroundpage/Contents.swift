//: [Previous](@previous)

import Foundation

let sampleData = """
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
"""

let dataUrl = Bundle.main.url(forResource: "day1", withExtension: "txt")!
let data = String(data: Data.init(contentsOf: dataUrl), encoding: .utf8)!

extension String {
    var calibrationValue: Int {
        let charSet = CharacterSet.decimalDigits
        let filtered = String(unicodeScalars.filter { charSet.contains($0) })
        guard filtered.count > 0 else { return 0 }
        return Int("\(filtered.first!)\(filtered.last!)") ?? 0
    }
}
    
let answer = data.components(separatedBy: .newlines)
    .reduce(0) { partialResult, substring in
        partialResult + String(substring).calibrationValue
    }

print(answer)

//: [Next](@next)
