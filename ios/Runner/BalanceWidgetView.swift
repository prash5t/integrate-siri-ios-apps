import SwiftUI
import AppIntents

struct BalanceWidgetView: View {
    let balance: Float
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Current Balance")
                .font(.headline)
            Text("₹\(String(format: "%.2f", balance))")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    BalanceWidgetView(balance: 500.0)
} 