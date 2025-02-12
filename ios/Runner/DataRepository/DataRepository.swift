import Foundation

class DataRepository {
    func getVoiceAssistanceForSiri(voiceAssistantPayloadModel: VoiceAssistantPayloadModel) async -> VoiceAssistantResponseModel? {
        guard let url = URL(string: ApiConstants.kVoiceAssistant) else { return nil }
        
        do {
            // Create request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Encode payload to JSON
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(voiceAssistantPayloadModel)
            
            // Make request
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Check response status
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("❌ Invalid response or status code")
                return nil
            }
            
            // Decode response
            let decoder = JSONDecoder()
            let voiceResponse = try decoder.decode(VoiceAssistantResponseModel.self, from: data)
            return voiceResponse
            
        } catch {
            print("❌ Voice Assistant API Error: \(error.localizedDescription)")
            return nil
        }
    }
}
