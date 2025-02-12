import AppIntents
import SwiftUI

struct CheckBalanceIntent: AppIntent {
    static var title: LocalizedStringResource = "Check balance"
    static var description = IntentDescription("Check balance in your village pay account")
    static var openAppWhenRun: Bool = false
    let appName: String = "Village Pay"
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        guard let loggedInVillager = SharedPrefsHelper.shared.getLoggedInVillager() else {
            let errMsg: LocalizedStringResource = "Account not found"
            let errorDialog = IntentDialog(full: errMsg, supporting: errMsg)
            return .result(dialog: errorDialog)
        }
        
        let balance = Float(loggedInVillager.balanceInRs)
        let userName = loggedInVillager.name
        let toSpeak: LocalizedStringResource = "\(userName), You have Rs.\(String(format: "%.2f", balance)) in \(appName)"
        let dialog = IntentDialog(full: toSpeak, supporting: toSpeak)
        
        let snippet = BalanceWidgetView(balance: balance)
        
        return .result(dialog: dialog, view: snippet)
        
    }
}

extension CheckBalanceIntent {
    static var parameterSummary: some ParameterSummary {
        Summary("Check your current balance")
    }
}
