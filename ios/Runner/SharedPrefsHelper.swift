import Foundation

class SharedPrefsHelper {
    let kLoggedInVillagerId = "loggedInVillagerId"
    let kVillagersList = "villagersList"
    let kGroup = "group.com.example.villagePay"
    static let shared = SharedPrefsHelper()
    
    private let userDefaults = UserDefaults()
//    UserDefaults.standard
    
    func getLoggedInVillagerId() -> String? {
        return userDefaults.string(forKey: kLoggedInVillagerId)
    }
    
    func getVillagersList() -> [VillagerModel]? {
        guard let villagersJsonArray = userDefaults.stringArray(forKey: kVillagersList) else {
            return nil
        }
        
        return villagersJsonArray.compactMap { jsonString in
            guard let jsonData = jsonString.data(using: .utf8) else { return nil }
            return try? JSONDecoder().decode(VillagerModel.self, from: jsonData)
        }
    }
    
    func getLoggedInVillager() -> VillagerModel? {
        guard let loggedInId = getLoggedInVillagerId(),
              let villagers = getVillagersList() else {
            return nil
        }
        
        return villagers.first { $0.id == loggedInId }
    }
} 
