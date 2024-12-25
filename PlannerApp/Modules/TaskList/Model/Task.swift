import Foundation

struct Task: Decodable {
    let id: Int
    let dateStart: TimeInterval
    let dateFinish: TimeInterval
    let name: String
    let description: String?
}
