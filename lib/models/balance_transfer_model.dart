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
    DateTime txnTime;
    try {
      txnTime = DateTime.tryParse(json['txnTimeStamp']) ?? DateTime.now();
    } catch (e) {
      txnTime = DateTime.now();
    }
    double amount;
    try {
      amount = double.tryParse(json['amount']) ?? 0.0;
    } catch (e) {
      amount = (json['amount'] as num).toDouble();
      // int.tryParse(json['amount'])?.toDouble() ?? 0.0;
    }
    return BalanceTransferModel(
      id: json['id'],
      fromId: json['fromId'],
      toId: json['toId'],
      amount: amount,
      txnTimeStamp: txnTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromId': fromId,
      'toId': toId,
      'amount': amount,
      'txnTimeStamp': txnTimeStamp.toIso8601String(),
    };
  }
}
