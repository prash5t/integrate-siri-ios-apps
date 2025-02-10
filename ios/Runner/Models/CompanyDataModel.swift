import Foundation

struct CompanyDataModel: Codable {
    let company: CompanyModel
    let price: PriceModel
    let numTrans: Int
    let tradedShares: Int
    let amount: Double
    
    enum CodingKeys: String, CodingKey {
        case company
        case price
        case numTrans
        case tradedShares
        case amount
    }
} 