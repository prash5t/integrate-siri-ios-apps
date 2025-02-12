import Foundation

struct TransactionModel: Codable {
    let id: String
    let transactionType: TransactionType
    let balanceLoadModel: BalanceLoadModel?
    let balanceTransferModel: BalanceTransferModel?
} 