import AppIntents
import SwiftUI

struct LoadBalanceIntent: AppIntent {
    static var title: LocalizedStringResource = "Load Balance"
    static var description = IntentDescription("Loads money into your Village Pay account")
    static var openAppWhenRun: Bool = true
    
    @Parameter(title: "Amount", 
              description: "Amount to deposit in rupees")
    var amount: Double
    
    let appName: String = "Village Pay"
    
    init() {
        self.amount = 0.0
    }
    
    init(amount: Double) {
        self.amount = amount
    }
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog &  ShowsSnippetView {
        guard let loggedInVillager = SharedPrefsHelper.shared.getLoggedInVillager() else {
            let errMsg: LocalizedStringResource = "Account not found"
            let errorDialog = IntentDialog(full: errMsg, supporting: errMsg)
            return .result(dialog: errorDialog)
        }
        
        let view = LoadBalanceView(amount: Float(amount)) {
            print("User confirmed deposit of ₹\(amount) for \(loggedInVillager.name)")
        }
        
        let toSpeak: LocalizedStringResource = "Are you sure you want to deposit Rs.\(String(format: "%.2f", amount))?"
        
        let dialog = IntentDialog(full: toSpeak, supporting: toSpeak)
        
        return .result(dialog: dialog, view: view)
    }
}

extension LoadBalanceIntent {
    static var parameterSummary: some ParameterSummary {
        Summary("Load \(\.$amount) in Village Pay")
    }
} 
