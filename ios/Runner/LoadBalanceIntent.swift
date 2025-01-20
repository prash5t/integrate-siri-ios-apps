import AppIntents
import SwiftUI

struct LoadBalanceIntent: AppIntent {
    static var title: LocalizedStringResource = "Load Balance"
    static var description = IntentDescription("Loads money into your Village Pay account")
    static var openAppWhenRun: Bool = true
    
    @Parameter(
        title: "Amount",
        description: "Amount to deposit in rupees",
        inclusiveRange: (1, 1000)
    )
    var amount: Int
    
    init() {
        self.amount = 100
    }
    
    init(amount: Int) {
        self.amount = amount
    }
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        guard let loggedInVillager = SharedPrefsHelper.shared.getLoggedInVillager() else {
            let errMsg: LocalizedStringResource = "Account not found. Please log in to the app first."
            let errorDialog = IntentDialog(full: errMsg, supporting: errMsg)
            return .result(dialog: errorDialog)
        }
        
        // Validate amount
        guard amount > 0 && amount <= 1000 else {
            let errMsg: LocalizedStringResource = "Please enter an amount between ₹1 and ₹1000"
            let errorDialog = IntentDialog(full: errMsg, supporting: errMsg)
            return .result(dialog: errorDialog)
        }
        
        let view = LoadBalanceView(amount: amount) {
            print("User confirmed deposit of ₹\(amount) for \(loggedInVillager.name)")
        }
        
        let toSpeak: LocalizedStringResource = "Are you sure you want to deposit ₹\(amount) to \(loggedInVillager.name)'s account?"
        let dialog = IntentDialog(full: toSpeak, supporting: toSpeak)
        
        return .result(dialog: dialog, view: view)
    }
}

extension LoadBalanceIntent {
    static var parameterSummary: some ParameterSummary {
        Summary("Load amount in Village Pay")
    }
} 
