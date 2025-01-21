import Foundation

struct BalanceTransferModel: Codable {
    let id: String
    let senderId: String
    let receiverId: String
    let balanceInRs: Double
    let txnTimeStamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case senderId
        case receiverId
        case balanceInRs
        case txnTimeStamp
    }
} 