import AppIntents
import SwiftUI

struct LoadBalanceIntent: AppIntent {
    static var title: LocalizedStringResource = "Load balance"
    static var description = IntentDescription("Load balance in your village pay account")
    static var openAppWhenRun: Bool = true
    let appName: String = "Village Pay"
    
    @Parameter(title: "Amount", description: "Amount to load in NPR", inclusiveRange: (1,1000))
    var amount: Int?
    
    init() {
        self.amount = nil
    }
    
    init(amount: Int?) {
        self.amount = amount
    }
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        guard let loggedInVillager = SharedPrefsHelper.shared.getLoggedInVillager() else {
            let errMsg: LocalizedStringResource = "Account not found. Please log in to the app first."
            let errorDialog = IntentDialog(full: errMsg, supporting: errMsg)
            return .result(dialog: errorDialog)
        }
        
        guard let unwrappedAmount = amount else {
            let errMsg: LocalizedStringResource = "How much money you want to load?"
            throw $amount.needsValueError(IntentDialog(full: errMsg, supporting: errMsg))
        }
        
        // Validate amount
        guard unwrappedAmount > 0 && unwrappedAmount <= 1000 else {
            let errMsg: LocalizedStringResource = "Please enter an amount between ₹1 and ₹1000"
            let errorDialog = IntentDialog(full: errMsg, supporting: errMsg)
            return .result(dialog: errorDialog)
        }
        
        do {
            try SharedPrefsHelper.shared.loadBalance(amount: Double(unwrappedAmount))
            print("✅ Successfully loaded balance of ₹\(unwrappedAmount) for \(loggedInVillager.name)")
            
            // Get updated balance after successful load
            if let updatedVillager = SharedPrefsHelper.shared.getLoggedInVillager() {
                let successMsg: LocalizedStringResource = "Successfully loaded ₹\(unwrappedAmount) to \(loggedInVillager.name)'s account. New balance: ₹\(String(format: "%.2f", updatedVillager.balanceInRs))"
                let dialog = IntentDialog(full: successMsg, supporting: successMsg)
                return .result(dialog: dialog, view: BalanceLoadedView(
                    loadedAmount: unwrappedAmount,
                    updatedBalance: updatedVillager.balanceInRs
                ))
            } else {
                throw NSError(domain: "VillagePay", code: 5, userInfo: [NSLocalizedDescriptionKey: "Failed to get updated balance"])
            }
        } catch {
            print("❌ Failed to load balance: \(error.localizedDescription)")
            let errorMsg: LocalizedStringResource = "Failed to load balance: \(error.localizedDescription)"
            let dialog = IntentDialog(full: errorMsg, supporting: errorMsg)
            return .result(dialog: dialog)
        }
    }
}

extension LoadBalanceIntent {
    static var parameterSummary: some ParameterSummary {
        Summary("Load money in your account")
    }
}
