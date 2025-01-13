import AppIntents
import intelligence

struct CheckBalanceIntent: AppIntent {
  static var title: LocalizedStringResource = "Check Balance"
  static var openAppWhenRun: Bool = true
    let kCheckBalance: String = "check_balance"
  
  @MainActor
  func perform() async throws -> some IntentResult {
    IntelligencePlugin.notifier.push(kCheckBalance)
    return .result()
  }
}
