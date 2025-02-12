class BalanceLoadModel {
  final String id;
  final String villagerId;
  final double balanceInRs;
  final DateTime txnTimeStamp;

  BalanceLoadModel(
      {required this.id,
      required this.villagerId,
      required this.balanceInRs,
      required this.txnTimeStamp});

  factory BalanceLoadModel.fromJson(Map<String, dynamic> json) {
    DateTime txnTime;
    try {
      txnTime = DateTime.tryParse(json['txnTimeStamp']) ?? DateTime.now();
    } catch (e) {
      txnTime = DateTime.now();
    }
    double balanceInRs;
    try {
      balanceInRs = double.tryParse(json['balanceInRs']) ?? 0.0;
    } catch (e) {
      balanceInRs = (json['balanceInRs'] as num).toDouble();
      // int.tryParse(json['balanceInRs'])?.toDouble() ?? 0.0;
    }
    return BalanceLoadModel(
      id: json['id'],
      villagerId: json['villagerId'],
      balanceInRs: balanceInRs,
      txnTimeStamp: txnTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'villagerId': villagerId,
      'balanceInRs': balanceInRs,
      'txnTimeStamp': txnTimeStamp.toIso8601String(),
    };
  }
}
