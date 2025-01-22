import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        print("guard mathi")
        guard intent is LoadBalanceIntent else {
            print("fatal ma")
            fatalError("Unhandled Intent error : \(intent)")
        }
        print("return vanda mathi")
        return LoadBalanceIntentHandler()
    }
    
}


class LoadBalanceIntentHandler : NSObject, LoadBalanceIntentHandling {
    
    func handle(intent: LoadBalanceIntent, completion: @escaping (LoadBalanceIntentResponse) -> Void) {
    print("load balance handler call")
        if let amount = intent.amount {
            do {
                try SharedPrefsHelper.shared.loadBalance(amount: Double(truncating: amount))
                completion(LoadBalanceIntentResponse.success(amount: amount))
            } catch {
                print("Failed to load balance: \(error.localizedDescription)")
                completion(LoadBalanceIntentResponse.failure(amount: amount))
            }
        } else {
            print("Failed to load balance: no amount from user")
            completion(LoadBalanceIntentResponse.failure(amount: intent.amount ?? 0))
        }
    }
    
    func resolveAmount(for intent: LoadBalanceIntent, with completion: @escaping (LoadBalanceAmountResolutionResult) -> Void) {
        
        guard let amount = intent.amount else {
            completion(LoadBalanceAmountResolutionResult.needsValue())
            return
        }
        
        completion(LoadBalanceAmountResolutionResult.success(with: Int(truncating: amount)))
    }
    

}
