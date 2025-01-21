import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        
        guard intent is LoadBalanceIntent else {
            fatalError("Unhandled Intent error : \(intent)")
        }
        
        return LoadBalanceIntentHandler()
    }
    
}


class LoadBalanceIntentHandler : NSObject, LoadBalanceIntentHandling {
    
    func handle(intent: LoadBalanceIntent, completion: @escaping (LoadBalanceIntentResponse) -> Void) {
    
        if let amount = intent.amount {
            do {
                try SharedPrefsHelper.shared.loadBalance(amount: Double(truncating: amount))
                completion(LoadBalanceIntentResponse.success(amount: amount))
            } catch {
                print("Failed to load balance: \(error.localizedDescription)")
                completion(LoadBalanceIntentResponse.failure(amount: 0))
            }
        } else {
            completion(LoadBalanceIntentResponse.failure(amount: 0))
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
