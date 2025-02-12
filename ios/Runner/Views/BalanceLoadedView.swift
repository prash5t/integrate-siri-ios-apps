import SwiftUI
import AppIntents

struct BalanceLoadedView: View {
    let loadedAmount: Int
    let updatedBalance: Double
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 48))
                .foregroundColor(.green)
            
            VStack(spacing: 8) {
                Text("Amount Loaded")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("₹\(loadedAmount)")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.blue)
            }
            
            Divider()
                .padding(.vertical, 8)
            
            VStack(spacing: 8) {
                Text("Updated Balance")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("₹\(String(format: "%.2f", updatedBalance))")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    BalanceLoadedView(loadedAmount: 100, updatedBalance: 1500.50)
} 
