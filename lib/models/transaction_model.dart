import 'package:village_pay/exports.dart';

class TransactionModel {
  final String id;
  final TransactionType transactionType;
  final BalanceLoadModel? balanceLoadModel;
  final BalanceTransferModel? balanceTransferModel;

  TransactionModel(
      {required this.id,
      required this.transactionType,
      required this.balanceLoadModel,
      required this.balanceTransferModel});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      transactionType: json['transactionType'],
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
      'transactionType': transactionType,
      'balanceLoadModel': balanceLoadModel?.toJson(),
      'balanceTransferModel': balanceTransferModel?.toJson(),
    };
  }
}
