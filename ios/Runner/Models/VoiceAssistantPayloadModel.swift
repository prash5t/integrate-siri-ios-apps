import Foundation

struct VoiceAssistantPayloadModel: Codable {
    let conversationHistory: [VoiceMessageModel]
    let currentQuery: String
    
    enum CodingKeys: String, CodingKey {
        case conversationHistory = "conversation_history"
        case currentQuery = "current_query"
    }
}
