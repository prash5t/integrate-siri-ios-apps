import Foundation

struct CompanyModel: Codable {
    let code: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case name
    }
} 