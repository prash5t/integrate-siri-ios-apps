import Foundation

class NepseRepository {
    func getCompany(companyToSearch: String) async -> CompanyDataModel? {
        guard let url = URL(string: ApiConstants.kLatestData) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let nepseData = try decoder.decode(NepseLatestDataModel.self, from: data)
            
            // Search for company by code or name (case insensitive)
            let searchText = companyToSearch.lowercased()
            return nepseData.data.first { company in
                company.company.code.lowercased().contains(searchText) ||
                company.company.name.lowercased().contains(searchText)
            }
            
        } catch {
            print("Error fetching or decoding data: \(error)")
            return nil
        }
    }
}
 
