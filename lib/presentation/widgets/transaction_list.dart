import 'package:intl/intl.dart';
import 'package:village_pay/exports.dart';

class TransactionList extends StatelessWidget {
  final String villagerId;
  const TransactionList({super.key, required this.villagerId});

  @override
  Widget build(BuildContext context) {
    List<String>? transactionsJson = locator<SharedPreferences>()
        .getStringList(SharedPrefsConstants.transactionsList);

    if (transactionsJson == null || transactionsJson.isEmpty) {
      return Center(
        child: Text(
          TextConstants.noTransactions,
          style: TextStyle(
            color: ColorConstants.textSecondary(context),
            fontSize: 17,
          ),
        ),
      );
    }

    List<TransactionModel> transactions = transactionsJson
        .map((e) => TransactionModel.fromJson(jsonDecode(e)))
        .where((t) =>
            (t.transactionType == TransactionType.balanceLoad &&
                t.balanceLoadModel?.villagerId == villagerId) ||
            (t.transactionType == TransactionType.balanceTransfer &&
                (t.balanceTransferModel?.fromId == villagerId ||
                    t.balanceTransferModel?.toId == villagerId)))
        .toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final isLoad =
            transaction.transactionType == TransactionType.balanceLoad;

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorConstants.cardColor(context),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isLoad
                      ? CupertinoColors.activeGreen.withOpacity(0.1)
                      : CupertinoColors.systemBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isLoad
                      ? CupertinoIcons.arrow_down_circle_fill
                      : CupertinoIcons.arrow_right_circle_fill,
                  color: isLoad
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.systemBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isLoad
                          ? 'Loaded ₹${transaction.balanceLoadModel?.balanceInRs.toStringAsFixed(2)}'
                          : 'Transfer ₹${transaction.balanceTransferModel?.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: ColorConstants.textPrimary(context),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DateFormat('dd MMM yyyy, hh:mm a').format(isLoad
                          ? transaction.balanceLoadModel!.txnTimeStamp
                          : transaction.balanceTransferModel!.txnTimeStamp),
                      style: TextStyle(
                        color: ColorConstants.textSecondary(context),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
