import 'package:village_pay/exports.dart';

class TransactionModel {
  final String id;
  final TransactionType transactionType;
  final BalanceLoadModel? balanceLoadModel;
  final BalanceTransferModel? balanceTransferModel;

  TransactionModel({
    required this.id,
    required this.transactionType,
    this.balanceLoadModel,
    this.balanceTransferModel,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      transactionType: TransactionType.values.firstWhere(
        (type) => type.name == json['transactionType'],
        orElse: () => TransactionType.balanceLoad,
      ),
      balanceLoadModel: json['balanceLoadModel'] != null
          ? BalanceLoadModel.fromJson(json['balanceLoadModel'])
          : null,
      balanceTransferModel: json['balanceTransferModel'] != null
          ? BalanceTransferModel.fromJson(json['balanceTransferModel'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transactionType': transactionType.name,
      'balanceLoadModel': balanceLoadModel?.toJson(),
      'balanceTransferModel': balanceTransferModel?.toJson(),
    };
  }
}
