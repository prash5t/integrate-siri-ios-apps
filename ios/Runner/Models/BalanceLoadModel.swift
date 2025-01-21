import Foundation

struct BalanceLoadModel: Codable {
    let id: String
    let villagerId: String
    let balanceInRs: Double
    let txnTimeStamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case villagerId
        case balanceInRs
        case txnTimeStamp
    }
} 