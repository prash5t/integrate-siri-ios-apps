import Foundation

struct VillagerModel: Codable {
    let id: String
    let name: String
    let balanceInRs: Double
    let joinedAt: String
}

class SharedPrefsHelper {
    static let shared = SharedPrefsHelper()
    
    private let userDefaults = UserDefaults.standard
    
    func getLoggedInVillagerId() -> String? {
        return userDefaults.string(forKey: "loggedInVillagerId")
    }
    
    func getVillagersList() -> [VillagerModel]? {
        guard let villagersJsonArray = userDefaults.stringArray(forKey: "villagersList") else {
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
