import Foundation

struct NepseLatestDataModel: Codable {
    let metadata: MetaDataModel
    let data: [CompanyDataModel]
    
    enum CodingKeys: String, CodingKey {
        case metadata
        case data
    }
} 