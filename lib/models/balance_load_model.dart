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
    return BalanceLoadModel(
      id: json['id'],
      villagerId: json['villagerId'],
      balanceInRs: json['balanceInRs'],
      txnTimeStamp: DateTime.tryParse(json['txnTimeStamp']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'villagerId': villagerId,
      'balanceInRs': balanceInRs,
      'txnTimeStamp': txnTimeStamp.toString(),
    };
  }
}
