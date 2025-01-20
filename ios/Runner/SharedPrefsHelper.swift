import Foundation

class SharedPrefsHelper {
    // Match exact keys from SharedPrefsConstants.dart
    static let kLoggedInVillagerId = "flutter.loggedInVillagerId"  // Changed to static
    static let kVillagersList = "flutter.villagersList"  // Changed to static
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
} 
