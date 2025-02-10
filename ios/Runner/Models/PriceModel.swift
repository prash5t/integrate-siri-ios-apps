import Foundation

struct PriceModel: Codable {
    let open: Double
    let max: Double
    let min: Double
    let close: Double
    let prevClose: Double
    let diff: Double
    
    enum CodingKeys: String, CodingKey {
        case open
        case max
        case min
        case close
        case prevClose
        case diff
    }
} 