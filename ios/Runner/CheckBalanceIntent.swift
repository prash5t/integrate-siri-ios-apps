import AppIntents
import SwiftUI

struct CheckBalanceIntent: AppIntent {
    static var title: LocalizedStringResource = "Check Balance"
    static var description = IntentDescription("Tells you the current balance at the moment")
    static var openAppWhenRun: Bool = true
    let appName: String = "Village Pay"
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        guard let loggedInVillager = SharedPrefsHelper.shared.getLoggedInVillager() else {
            let errMsg: LocalizedStringResource = "Account not found"
            let errorDialog = IntentDialog(full: errMsg, supporting: errMsg)
            return .result(dialog: errorDialog)
        }
        
        let balance = Float(loggedInVillager.balanceInRs)
        let toSpeak: LocalizedStringResource = "You have Rs.\(String(format: "%.2f", balance)) in \(appName)"
        let dialog = IntentDialog(full: toSpeak, supporting: toSpeak)
        
        return .result(dialog: dialog)
        
    }
}
