import WidgetKit
import SwiftUI

struct StockEntry: TimelineEntry {
    let date: Date
    let companyData: CompanyDataModel?
}

struct StockWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> StockEntry {
        StockEntry(date: Date(), companyData:
                    CompanyDataModel(
                        company: CompanyModel(code: "NABIL", name: "Nabil Bank Limited"),
                        price: PriceModel(
                            open: 1000.0,
                            max: 1020.0,
                            min: 995.0,
                            close: 1015.0,
                            prevClose: 1005.0,
                            diff: 10.0
                        ),
                        numTrans: 500,
                        tradedShares: 10000,
                        amount: 10150000.0
                    )
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (StockEntry) -> ()) {
        let stock = CompanyDataModel(
            company: CompanyModel(code: "NABIL", name: "Nabil Bank Limited"),
            price: PriceModel(
                open: 1000.0,
                max: 1020.0,
                min: 995.0,
                close: 1015.0,
                prevClose: 1005.0,
                diff: 10.0
            ),
            numTrans: 500,
            tradedShares: 10000,
            amount: 10150000.0
        )
        let entry = StockEntry(date: Date(), companyData: stock)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<StockEntry>) -> ()) {
        print("Fetching last saved stock")
        let stock = SharedPrefsHelper.shared.getLastViewedStock()
        let entry = StockEntry(date: Date(), companyData: stock)
        
        // Create multiple entries for more frequent updates
        var entries: [StockEntry] = []
        
        // Current entry
        entries.append(entry)
        
        // Future entries every 5 minutes for the next hour
        let calendar = Calendar.current
        for minute in stride(from: 5, through: 60, by: 5) {
            guard let futureDate = calendar.date(byAdding: .minute, value: minute, to: Date()) else {
                continue
            }
            entries.append(StockEntry(date: futureDate, companyData: stock))
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct StockWidgetEntryView : View {
    var entry: StockEntry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        if let companyData = entry.companyData {
            StockPriceView(companyData: companyData)
        } else {
            ZStack {
                Color(red: 0.129, green: 0.588, blue: 0.953)
                VStack(spacing: 8) {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                    Text("No stocks viewed yet")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                    Text("Search a stock to see details here")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding()
            }
        }
    }
}

struct StockWidget: Widget {
    let kind: String = "StockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: StockWidgetProvider()) { entry in
            StockWidgetEntryView(entry: entry)
                .containerBackground(.clear, for: .widget)
        }
        .configurationDisplayName("Last Viewed Stock")
        .description("Shows details of your last viewed stock")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

#Preview(as: .systemLarge) {
    StockWidget()
} timeline: {
    StockEntry(
        date: .now,
        companyData: CompanyDataModel(
            company: CompanyModel(code: "NABIL", name: "Nabil Bank Limited"),
            price: PriceModel(
                open: 1000.0,
                max: 1020.0,
                min: 995.0,
                close: 1015.0,
                prevClose: 1005.0,
                diff: 10.0
            ),
            numTrans: 500,
            tradedShares: 10000,
            amount: 10150000.0
        )
    )
} 
