import Foundation
import WidgetKit

class SharedPrefsHelper {
    // Match exact keys from SharedPrefsConstants.dart
    static let kLoggedInVillagerId = "flutter.loggedInVillagerId"  // Changed to static
    static let kVillagersList = "flutter.villagersList"  // Changed to static
    static let kTransactionsList = "flutter.transactionsList"  // Added new key
    static let kLastViewedStock = "flutter.lastViewedStock"  // Add this line
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
        print("=== Load Balance Debug Start ===")
        
        // 1. Debug logged in user
        guard let loggedInId = getLoggedInVillagerId() else {
            print("❌ No logged in user ID found")
            throw NSError(domain: "VillagePay", code: 1, userInfo: [NSLocalizedDescriptionKey: "No logged in user found"])
        }
        print("✅ Found logged in ID: \(loggedInId)")
        
        // 2. Debug villagers list
        guard var villagers = getVillagersList() else {
            print("❌ No villagers list found")
            throw NSError(domain: "VillagePay", code: 2, userInfo: [NSLocalizedDescriptionKey: "Villagers list not found"])
        }
        print("✅ Found villagers list with \(villagers.count) villagers")
        
        // 3. Debug finding user in list
        guard let index = villagers.firstIndex(where: { $0.id == loggedInId }) else {
            print("❌ Logged in user \(loggedInId) not found in villagers list")
            print("Available villager IDs: \(villagers.map { $0.id })")
            throw NSError(domain: "VillagePay", code: 2, userInfo: [NSLocalizedDescriptionKey: "Logged in user not found in villagers list"])
        }
        print("✅ Found user at index: \(index)")
        
        // 4. Debug current balance
        let currentBalance = villagers[index].balanceInRs
        print("Current balance: \(currentBalance)")
        print("Adding amount: \(amount)")
        
        // Create balance load transaction
        let balanceLoad = BalanceLoadModel(
            id: UUID().uuidString,
            villagerId: loggedInId,
            balanceInRs: amount,
            txnTimeStamp: Date()
        )
        print("✅ Created balance load model")
        
//         Create transaction record
        let transaction = TransactionModel(
            id: UUID().uuidString,
            transactionType: .balanceLoad,
            balanceLoadModel: balanceLoad,
            balanceTransferModel: nil
        )
        print("✅ Created transaction model")
        
        // Update villager's balance
        let updatedVillager = VillagerModel(
            id: villagers[index].id,
            name: villagers[index].name,
            balanceInRs: currentBalance + amount,
            joinedAt: villagers[index].joinedAt
        )
        print("New balance will be: \(updatedVillager.balanceInRs)")
        villagers[index] = updatedVillager
        
//         5. Debug transactions list
        var transactions: [TransactionModel] = []
        if let transactionsJson = userDefaults.stringArray(forKey: SharedPrefsHelper.kTransactionsList) {
            print("Found existing transactions: \(transactionsJson.count)")
            transactions = transactionsJson.compactMap { jsonString in
                guard let jsonData = jsonString.data(using: .utf8) else {
                    print("❌ Failed to convert transaction string to data")
                    return nil
                }
                do {
                    let transaction = try JSONDecoder().decode(TransactionModel.self, from: jsonData)
                    print("✅ Successfully decoded transaction")
                    return transaction
                } catch {
                    print("❌ Failed to decode transaction: \(error)")
                    return nil
                }
            }
        }
        
        // Add new transaction
        transactions.append(transaction)
        print("✅ Added new transaction. Total transactions: \(transactions.count)")
        
//         6. Debug saving villagers list
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.outputFormatting = .prettyPrinted
            let villagersJson = try villagers.map { villager -> String in
                let jsonData = try 
//                JSONEncoder()
                    encoder.encode(villager)
                guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                    throw NSError(domain: "VillagePay", code: 3, userInfo: [NSLocalizedDescriptionKey: "Failed to encode villager data"])
                }
                return jsonString
            }
            userDefaults.set(villagersJson, forKey: SharedPrefsHelper.kVillagersList)
            print("✅ Saved updated villagers list")
        } catch {
            print("❌ Failed to save villagers: \(error)")
            throw error
        }
        
        // 7. Debug saving transactions list
        do {
            let transactionsJson = try transactions.map { transaction -> String in
                let jsonData = try JSONEncoder().encode(transaction)
                guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                    throw NSError(domain: "VillagePay", code: 4, userInfo: [NSLocalizedDescriptionKey: "Failed to encode transaction data"])
                }
                return jsonString
            }
            userDefaults.set(transactionsJson, forKey: SharedPrefsHelper.kTransactionsList)
            print("✅ Saved updated transactions list")
        } catch {
            print("❌ Failed to save transactions: \(error)")
            throw error
        }
        
        // 8. Verify the save
        userDefaults.synchronize()
        if let verifyVillager = getLoggedInVillager() {
            print("✅ Verification: New balance is \(verifyVillager.balanceInRs)")
        } else {
            print("❌ Verification failed: Could not read back saved data")
        }
        
        print("=== Load Balance Debug End ===")
    }
    
    func saveLastViewedStock(companyData: CompanyDataModel) {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(companyData)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                userDefaults.set(jsonString, forKey: SharedPrefsHelper.kLastViewedStock)
                userDefaults.synchronize()
                print("✅ Saved last viewed stock: \(companyData.company.name)")
                
                // verify saved stock
                if let savedStock: CompanyDataModel = getLastViewedStock() {
                    print("Saved last stock: \(savedStock.company.name)")
                }
                
                // Trigger widget reload
                WidgetCenter.shared.reloadTimelines(ofKind: "StockWidget")
            }
        } catch {
            print("❌ Failed to save last viewed stock: \(error)")
        }
    }
    
    func getLastViewedStock() -> CompanyDataModel? {
        
        guard let jsonString = userDefaults.string(forKey: SharedPrefsHelper.kLastViewedStock),
              let jsonData = jsonString.data(using: .utf8) else {
            print("Last Viewed Stock Not Found")
            return nil
        }
        
        do {
            let companyData = try JSONDecoder().decode(CompanyDataModel.self, from: jsonData)
            print("Last Viewed Stock: \(companyData.company.name)")
            return companyData
        } catch {
            print("❌ Failed to decode last viewed stock: \(error)")
            return nil
        }
    }
} 
