import Foundation

struct VoiceAssistantResponseModel: Codable {
    let continueConversation: Bool
    let sentenceSiriShouldSay: String
    
    enum CodingKeys: String, CodingKey {
        case continueConversation
        case sentenceSiriShouldSay
    }
    
}
