import Foundation

public func stringFromResource(named fileName: String) -> String? {
    guard let dataUrl = Bundle.main.url(forResource: fileName, withExtension: "txt") else { return nil }
    return try? String(data: Data.init(contentsOf: dataUrl), encoding: .utf8)
}
