import AppIntents
import SwiftUI


struct TalkToVillagerIntent: AppIntent {
    static var title: LocalizedStringResource = "Voice Assistant"
    static var description = IntentDescription("Access app features directly from voice")
    static var openAppWhenRun: Bool = false
    let appName: String = "Village Pay"
    
    let staticErrorMsg: String = "Sorry, Voice Assistant Feature is not working at the moment."
    
    @Parameter(title: "Query", description: "What do you want to do?")
    var userQuery: String?
    
    init (){
        self.userQuery = nil
    }
    
    init(userQuery: String?) {
        self.userQuery = userQuery
    }
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        guard SharedPrefsHelper.shared.getLoggedInVillager() != nil else {
            let errMsg: LocalizedStringResource = "Account not found. Please log in to the app first."
            let errorDialog = IntentDialog(full: errMsg, supporting: errMsg)
            return .result(dialog: errorDialog)
        }
        
        guard let unwrappedUserQuery = userQuery else {
            let errMsg: LocalizedStringResource = "Hi, I am your villager, How can I help you?"
            
            // Clear existing conversation when starting new
            SharedPrefsHelper.shared.clearVoiceConversation()
            
            throw $userQuery.needsValueError(IntentDialog(full: errMsg, supporting: errMsg))
        }
        
        do {
            print("Assistant/UserRequest: \(unwrappedUserQuery)")
            
            // Get existing conversation or start new one
            var conversationHistory = SharedPrefsHelper.shared.getVoiceConversation()
            
            // Add user's message to conversation
            let userMessage = VoiceMessageModel(role: "user", content: unwrappedUserQuery)
            conversationHistory.append(userMessage)
            
            // Create payload for API
            let payload = VoiceAssistantPayloadModel(
                conversationHistory: conversationHistory,
                currentQuery: unwrappedUserQuery
            )
            
            // Make API call
            let repository = DataRepository()
            guard let assistantResponse = await repository.getVoiceAssistanceForSiri(voiceAssistantPayloadModel: payload) else {
                let errMsg: LocalizedStringResource = "\(staticErrorMsg)"
                let errorDialog = IntentDialog(full: errMsg, supporting: errMsg)
                return .result(dialog: errorDialog)
            }
            
            print("Assistant/AssistantResponse: \(assistantResponse.sentenceSiriShouldSay)")
            
            if assistantResponse.continueConversation {
                // Add assistant's response to conversation history
                let assistantMessage = VoiceMessageModel(
                    role: "assistant",
                    content: assistantResponse.sentenceSiriShouldSay
                )
                conversationHistory.append(assistantMessage)
                
                // Save updated conversation
                SharedPrefsHelper.shared.saveVoiceConversation(messages: conversationHistory)
                
                // Throw needs value error to continue conversation
                let followUpMsg: LocalizedStringResource = "\(assistantResponse.sentenceSiriShouldSay)"
                throw $userQuery.needsValueError(
                    IntentDialog(
                        full: followUpMsg,
                        supporting: followUpMsg
                    )
                )
            } else {
                // Clear conversation as it's complete
                SharedPrefsHelper.shared.clearVoiceConversation()
                
                let finalMsg: LocalizedStringResource = "\(assistantResponse.sentenceSiriShouldSay)"
                // Return final response
                return .result(
                    dialog: IntentDialog(
                        full: finalMsg,
                        supporting: finalMsg
                    )
                )
            }
        } catch let error as LocalizedError {
            print("❌ Voice Assistant Error: \(error.localizedDescription)")
            let errorMsg: LocalizedStringResource = "Sorry, something went wrong: \(error.localizedDescription)"
            let dialog = IntentDialog(full: errorMsg, supporting: errorMsg)
            return .result(dialog: dialog)
        }
    }
}


extension TalkToVillagerIntent {
    static var parameterSummary: some ParameterSummary {
        Summary("Ask villager to \(\.$userQuery)")
    }
}
