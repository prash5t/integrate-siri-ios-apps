import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), villager: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let villager = VillagerModel(
            id: "123",
            name: "John Doe",
            balanceInRs: 1500.50,
            joinedAt: "2024-01-01T00:00:00.000Z"
        )
        let entry = SimpleEntry(date: Date(), villager: villager)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let villager = SharedPrefsHelper.shared.getLoggedInVillager()
        let entry = SimpleEntry(date: Date(), villager: villager)
        
        // Update every minute
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let villager: VillagerModel?
}

struct ProfileWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        if let villager = entry.villager {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.129, green: 0.588, blue: 0.953),  // #2196F3
                        Color(red: 0.012, green: 0.663, blue: 0.957)   // #03A9F5
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Content
                VStack(alignment: .leading, spacing: 12) {
                    // Header with name
                    Text(villager.name)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Balance section
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Balance")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text("Rs. \(String(format: "%.2f", villager.balanceInRs))")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    // Member since
                    Text("Member since \(formatDate(villager.joinedAt))")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding()
            }
        } else {
            // Placeholder when no user is logged in
            ZStack {
                Color(red: 0.129, green: 0.588, blue: 0.953)
                VStack {
                    Text("Please log in to Village Pay")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
    }
    
    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: date)
        }
        return dateString
    }
}

struct ProfileWidget: Widget {
    let kind: String = "ProfileWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ProfileWidgetEntryView(entry: entry)
                .containerBackground(.clear, for: .widget)
        }
        .configurationDisplayName("Village Pay Profile")
        .description("View your Village Pay balance and profile")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .systemLarge,
            .systemExtraLarge
        ])
    }
}

#Preview(as: .systemMedium) {
    ProfileWidget()
} timeline: {
    SimpleEntry(
        date: .now,
        villager: VillagerModel(
            id: "123",
            name: "John Doe",
            balanceInRs: 1500.50,
            joinedAt: "2024-01-01T00:00:00.000Z"
        )
    )
}
