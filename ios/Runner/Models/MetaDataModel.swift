import Foundation

struct MetaDataModel: Codable {
    let totalAmt: Double?
    let totalQty: Double?
    let totalTrans: Double?
    
    enum CodingKeys: String, CodingKey {
        case totalAmt
        case totalQty
        case totalTrans
    }
} 