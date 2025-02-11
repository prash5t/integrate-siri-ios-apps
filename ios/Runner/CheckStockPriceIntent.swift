import AppIntents
import SwiftUI

struct CheckStockPriceIntent: AppIntent {
    static var title: LocalizedStringResource = "Check Stock Price"
    static var description = IntentDescription("Check stock prices from village pay app")
    static var openAppWhenRun: Bool = false
    let appName: String = "Village Pay"
    
    @Parameter(title: "Company", description: "Name of the company")
    var company: String?
    
    init() {
        self.company = nil
    }
    
    init(company: String?){
        self.company = company
    }
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        guard SharedPrefsHelper.shared.getLoggedInVillager() != nil else {
            let errMsg: LocalizedStringResource = "Account not found. Please log in to the app first."
            let errorDialog = IntentDialog(full: errMsg, supporting: errMsg)
            return .result(dialog: errorDialog)
        }
        
        guard let unwrappedStockName = company else {
            let errMsg: LocalizedStringResource = "Which company do you want to check?"
            throw $company.needsValueError(IntentDialog(full: errMsg, supporting: errMsg))
        }
        
        do {
            print("=== Check Stock Price Debug Start ===")
            print("Checking stock price for: \(unwrappedStockName)")
            
            let repository = NepseRepository()
            guard let companyData = await repository.getCompany(companyToSearch: unwrappedStockName) else {
                let errMsg: LocalizedStringResource = "'\(unwrappedStockName)' not found"
                let errorDialog = IntentDialog(full: errMsg, supporting: errMsg)
                return .result(dialog: errorDialog)
            }
            
            print("✅ Found company data for: \(companyData.company.name)")
            
            // Create success dialog
            let successMsg: LocalizedStringResource = "\(companyData.company.name) opened at Rs. \(String(format: "%.2f", companyData.price.open)), closed at Rs. \(String(format: "%.2f", companyData.price.close)). The day's high was Rs. \(String(format: "%.2f", companyData.price.max)) and low was Rs. \(String(format: "%.2f", companyData.price.min))"
            let dialog = IntentDialog(full: successMsg, supporting: successMsg)
            
            // Return result with dialog and snippet view
            return .result(
                dialog: dialog,
                view: StockPriceView(companyData: companyData)
            )
            
        } 
//        catch {
//            print("❌ Failed to check stock price: \(error.localizedDescription)")
//            let errorMsg: LocalizedStringResource = "Failed to check stock price: \(error.localizedDescription)"
//            let dialog = IntentDialog(full: errorMsg, supporting: errorMsg)
//            return .result(dialog: dialog)
//        }
    }
}

extension CheckStockPriceIntent {
    static var parameterSummary: some ParameterSummary {
        Summary("Check stock price of \(\.$company)")
    }
}
