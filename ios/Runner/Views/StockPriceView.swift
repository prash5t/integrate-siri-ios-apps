import SwiftUI

struct StockPriceView: View {
    let companyData: CompanyDataModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Company Header
            VStack(alignment: .center, spacing: 8) {
                Text(companyData.company.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(companyData.company.code)
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            .padding(.bottom)
            
            // Price Information
            VStack(spacing: 16) {
                // Current Price and Change
                HStack {
                    Text("Rs. \(String(format: "%.2f", companyData.price.close))")
                        .font(.system(size: 28, weight: .bold))
                    
                    PriceChangeView(change: companyData.price.diff)
                }
                
                // Price Grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    PriceInfoRow(title: "Open", value: companyData.price.open)
                    PriceInfoRow(title: "Prev. Close", value: companyData.price.prevClose)
                    PriceInfoRow(title: "High", value: companyData.price.max)
                    PriceInfoRow(title: "Low", value: companyData.price.min)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            
            // Trading Information
            VStack(spacing: 16) {
                TradingInfoRow(title: "Traded Shares", value: companyData.tradedShares.formatted())
                TradingInfoRow(title: "Transactions", value: companyData.numTrans.formatted())
                TradingInfoRow(title: "Turnover Amount", value: "Rs. " + String(format: "%.2f", companyData.amount))
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
    }
}

// Helper Views
struct PriceChangeView: View {
    let change: Double
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: change >= 0 ? "arrow.up.right" : "arrow.down.right")
            Text(String(format: "%.2f", abs(change)))
        }
        .foregroundColor(change >= 0 ? .green : .red)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            (change >= 0 ? Color.green : Color.red)
                .opacity(0.1)
                .cornerRadius(6)
        )
    }
}

struct PriceInfoRow: View {
    let title: String
    let value: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Rs. \(String(format: "%.2f", value))")
                .font(.headline)
        }
    }
}

struct TradingInfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    // Sample data for preview
    let sampleCompanyData = CompanyDataModel(
        company: CompanyModel(
            code: "NABIL",
            name: "Nabil Bank Limited"
        ),
        price: PriceModel(
            open: 495.0,
            max: 495.0,
            min: 485.0,
            close: 486.3,
            prevClose: 486.7,
            diff: -0.4
        ),
        numTrans: 525,
        tradedShares: 49012,
        amount: 23879846.4
    )
    
    return StockPriceView(companyData: sampleCompanyData)
}
