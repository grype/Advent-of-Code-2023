//: [Previous](@previous)

import Foundation

let sampleData = """
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
"""

let wordMap:[String] = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

let dataUrl = Bundle.main.url(forResource: "day1", withExtension: "txt")!
let data = String(data: Data.init(contentsOf: dataUrl), encoding: .utf8)!

extension String {
    static let calibrationValueRegex = try! NSRegularExpression(pattern: "[0-9]|(\(wordMap.joined(separator: ")|(")))")
    
    var calibrationValue: Int {
        let matches = String.calibrationValueRegex.matches(in: self, options: .reportCompletion, range: NSRange(location: 0, length: count))
        
        guard !matches.isEmpty else { return 0 }
        
        let firstString = String(NSString(string: self).substring(with: matches.first!.range))
        let lastString = String(NSString(string: self).substring(with: matches.last!.range))
        var firstInt = wordMap.firstIndex { $0 == firstString } ?? Int(firstString) ?? 0
        var lastInt = wordMap.firstIndex { $0 == lastString } ?? Int(lastString) ?? 0
        return Int("\(firstInt)\(lastInt)") ?? 0
    }
}
    
let answer = data.components(separatedBy: .newlines)
    .reduce(0) { partialResult, substring in
        partialResult + String(substring).calibrationValue
    }

print(answer)

//: [Next](@next)
