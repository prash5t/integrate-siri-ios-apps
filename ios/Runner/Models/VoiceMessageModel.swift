import Foundation

struct VoiceMessageModel: Codable {
    let role: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case role
        case content
    }
}
