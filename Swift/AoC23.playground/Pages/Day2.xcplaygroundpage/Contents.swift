//: [Previous](@previous)

import Foundation

let sample = """
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
"""

struct Game {
    // MARK: - Properties

    var id: Int = 0
    var maxHands: [String: Int] = [:]
    
    // MARK: -
    
    var handPower: Int {
        maxHands.reduce(1) { $0 * $1.value }
    }
    
    func containsAtMost(hands: [String: Int]) -> Bool {
        for aHand in hands {
            if let count = maxHands[aHand.key], count > aHand.value {
                return false
            }
        }
        return true
    }
}

extension Game: CustomStringConvertible {
    var description: String {
        var result = "<Game \(id): "
        for aHand in maxHands {
            result.append("\(aHand.key) \(aHand.value); ")
        }
        result.append(">")
        return result
    }
}

extension Game {
    static func games(from aString: String) -> [Game] {
        let scanner = Scanner(string: aString)
        var result: [Game] = []

        while !scanner.isAtEnd {
            var game = Game()
            scanner.scanString("Game ")
            scanner.scanInt(&game.id)

            while !scanner.isAtEnd {
                scanner.scanCharacters(from: .whitespaces.union(.punctuationCharacters))

                var count: Int = 0
                scanner.scanInt(&count)

                scanner.scanCharacters(from: .whitespaces)
                
                if let color = scanner.scanCharacters(from: .letters) {
                    game.maxHands[String(color)] = max(game.maxHands[String(color)] ?? 0, count)
                }
                
                let nextIndex = aString.index(aString.startIndex, offsetBy: scanner.scanLocation)
                if nextIndex >= aString.endIndex || aString[nextIndex] == "\n" {
                    break
                }
            }
            result.append(game)
        }
        return result
    }
}


func part1() {
    let query = ["red": 12, "green": 13, "blue": 14]
    let answer = Game.games(from: stringFromResource(named: "day2")!)
        .filter { $0.containsAtMost(hands: query) }
        .reduce(0) { sum, game in
            return sum + game.id
        }
    
    print("Part 1: \(answer)")
}

func part2() {
    let answer = Game.games(from: stringFromResource(named: "day2")!)
        .reduce(0) { sum, game in
            return sum + game.handPower
        }
    
    print("Part 2: \(answer)")
}

part1()
part2()

//: [Next](@next)
