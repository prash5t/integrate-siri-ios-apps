//import SwiftUI
//import AppIntents
//
//struct LoadBalanceView: View {
//    let amount: Int
//    let onConfirm: () -> Void
//    
//    var body: some View {
//        VStack(spacing: 16) {
//            Text("Confirm Deposit")
//                .font(.headline)
//            
//            Text("₹\(amount)")
//                .font(.system(size: 32, weight: .bold))
//                .foregroundColor(.blue)
//            
//            HStack(spacing: 16) {
//                Button(role: .cancel) {
//                    // Cancel action handled by Siri
//                } label: {
//                    Text("Cancel")
//                        .frame(maxWidth: .infinity)
//                }
//                .buttonStyle(.bordered)
//                
//                Button {
//                    print("Depositing amount: ₹\(amount)")
//                    onConfirm()
//                } label: {
//                    Text("Deposit")
//                        .frame(maxWidth: .infinity)
//                }
//                .buttonStyle(.borderedProminent)
//            }
//        }
//        .padding()
//        .background(Color(.systemBackground))
//        .cornerRadius(12)
//    }
//}
//
//#Preview {
//    LoadBalanceView(amount: 100, onConfirm: {})
//} 
