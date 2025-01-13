//

import AppIntents

struct Village_Pay: AppIntent {
    static var title: LocalizedStringResource = "Village Pay"
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
