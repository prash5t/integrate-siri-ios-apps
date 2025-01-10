class BalanceTransferModel {
  final String id;
  final String fromId;
  final String toId;
  final double amount;
  final DateTime txnTimeStamp;

  BalanceTransferModel(
      {required this.id,
      required this.fromId,
      required this.toId,
      required this.amount,
      required this.txnTimeStamp});

  factory BalanceTransferModel.fromJson(Map<String, dynamic> json) {
    return BalanceTransferModel(
      id: json['id'],
      fromId: json['fromId'],
      toId: json['toId'],
      amount: json['amount'],
      txnTimeStamp: json['txnTimeStamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromId': fromId,
      'toId': toId,
      'amount': amount,
      'txnTimeStamp': txnTimeStamp,
    };
  }
}
