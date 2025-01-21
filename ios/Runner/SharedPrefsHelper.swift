import Foundation

class SharedPrefsHelper {
    // Match exact keys from SharedPrefsConstants.dart
    static let kLoggedInVillagerId = "flutter.loggedInVillagerId"  // Changed to static
    static let kVillagersList = "flutter.villagersList"  // Changed to static
    static let kTransactionsList = "flutter.transactionsList"  // Added new key
    static let shared = SharedPrefsHelper()
    
    private let userDefaults = UserDefaults.standard
    
    func debugPrintAllUserDefaults() {
        print("==== All UserDefaults ====")
        let defaults = userDefaults.dictionaryRepresentation()
        print("Total items in UserDefaults: \(defaults.count)")
        for (key, value) in defaults {
            print("\(key): \(String(describing: value))")
        }
        print("Specifically checking our keys:")
        print("loggedInVillagerId: \(userDefaults.string(forKey: SharedPrefsHelper.kLoggedInVillagerId) ?? "nil")")
        print("villagersList: \(userDefaults.stringArray(forKey: SharedPrefsHelper.kVillagersList) ?? [])")
        print("========================")
    }
    
    func getLoggedInVillagerId() -> String? {
        debugPrintAllUserDefaults()
        let villagerId: String? = userDefaults.string(forKey: SharedPrefsHelper.kLoggedInVillagerId)
        print("Trying to get villager ID with key: \(SharedPrefsHelper.kLoggedInVillagerId)")
        print("Villager ID found: \(String(describing: villagerId))")
        return villagerId
    }
    
    func getVillagersList() -> [VillagerModel]? {
        print("Trying to get villagers list with key: \(SharedPrefsHelper.kVillagersList)")
        guard let villagersJsonArray = userDefaults.stringArray(forKey: SharedPrefsHelper.kVillagersList) else {
            print("No villagers found in UserDefaults")
            return nil
        }
        
        print("Found villagers array with \(villagersJsonArray.count) items")
        print("First villager JSON: \(villagersJsonArray.first ?? "none")")
        
        return villagersJsonArray.compactMap { jsonString in
            guard let jsonData = jsonString.data(using: .utf8) else {
                print("Failed to convert string to data: \(jsonString)")
                return nil
            }
            do {
                let villager = try JSONDecoder().decode(VillagerModel.self, from: jsonData)
                print("Successfully decoded villager: \(villager)")
                return villager
            } catch {
                print("Failed to decode villager with error: \(error)")
                print("JSON string that failed: \(jsonString)")
                return nil
            }
        }
    }
    
    func getLoggedInVillager() -> VillagerModel? {
        guard let loggedInId = getLoggedInVillagerId(),
              let villagers = getVillagersList() else {
            print("Either loggedInId or villagers list is nil")
            return nil
        }
        
        let foundVillager = villagers.first { $0.id == loggedInId }
        print("Found logged in villager: \(String(describing: foundVillager))")
        return foundVillager
    }
    
    func loadBalance(amount: Double) throws {
        // Get logged in villager
        guard let loggedInId = getLoggedInVillagerId(),
              var villagers = getVillagersList() else {
            throw NSError(domain: "VillagePay", code: 1, userInfo: [NSLocalizedDescriptionKey: "No logged in user found"])
        }
        
        // Find and update villager's balance
        guard let index = villagers.firstIndex(where: { $0.id == loggedInId }) else {
            throw NSError(domain: "VillagePay", code: 2, userInfo: [NSLocalizedDescriptionKey: "Logged in user not found in villagers list"])
        }
        
        // Create balance load transaction
        let balanceLoad = BalanceLoadModel(
            id: UUID().uuidString,
            villagerId: loggedInId,
            balanceInRs: amount,
            txnTimeStamp: Date()
        )
        
        // Create transaction record
        let transaction = TransactionModel(
            id: UUID().uuidString,
            transactionType: .balanceLoad,
            balanceLoadModel: balanceLoad,
            balanceTransferModel: nil
        )
        
        // Update villager's balance
        let updatedVillager = VillagerModel(
            id: villagers[index].id,
            name: villagers[index].name,
            balanceInRs: villagers[index].balanceInRs + amount,
            joinedAt: villagers[index].joinedAt
        )
        villagers[index] = updatedVillager
        
        // Get existing transactions
        var transactions: [TransactionModel] = []
        if let transactionsJson = userDefaults.stringArray(forKey: SharedPrefsHelper.kTransactionsList) {
            transactions = transactionsJson.compactMap { jsonString in
                guard let jsonData = jsonString.data(using: .utf8) else { return nil }
                return try? JSONDecoder().decode(TransactionModel.self, from: jsonData)
            }
        }
        
        // Add new transaction
        transactions.append(transaction)
        
        // Save updated villagers list
        let villagersJson = villagers.map { villager -> String in
            let jsonData = try! JSONEncoder().encode(villager)
            return String(data: jsonData, encoding: .utf8)!
        }
        userDefaults.set(villagersJson, forKey: SharedPrefsHelper.kVillagersList)
        
        // Save updated transactions list
        let transactionsJson = transactions.map { transaction -> String in
            let jsonData = try! JSONEncoder().encode(transaction)
            return String(data: jsonData, encoding: .utf8)!
        }
        userDefaults.set(transactionsJson, forKey: SharedPrefsHelper.kTransactionsList)
        
        // Ensure changes are saved
        userDefaults.synchronize()
    }
} 
