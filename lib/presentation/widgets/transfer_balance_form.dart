import 'package:village_pay/exports.dart';

class TransferBalanceForm extends StatefulWidget {
  final VillagerModel receiver;
  final VillagerModel sender;
  const TransferBalanceForm({
    super.key,
    required this.receiver,
    required this.sender,
  });

  @override
  State<TransferBalanceForm> createState() => _TransferBalanceFormState();
}

class _TransferBalanceFormState extends State<TransferBalanceForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _handleTransfer() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<BalanceOperationsCubit>().transferBalance(
            double.parse(_amountController.text.trim()),
            widget.sender.id,
            widget.receiver.id,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return BlocListener<BalanceOperationsCubit, BalanceOperationsState>(
      listener: (context, state) {
        if (state is BalanceOperationsSuccess) {
          Navigator.pop(context);
          context.read<GetVillagersCubit>().getVillagers();
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text(TextConstants.transferSuccess),
              actions: [
                CupertinoDialogAction(
                  child: const Text(TextConstants.ok),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        } else if (state is BalanceOperationsFailure) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text(TextConstants.error),
              content: Text(state.error),
              actions: [
                CupertinoDialogAction(
                  child: const Text(TextConstants.ok),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorConstants.textTertiary(context),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                CupertinoFormSection.insetGrouped(
                  backgroundColor: ColorConstants.cardColor(context),
                  children: [
                    CupertinoTextFormFieldRow(
                      controller: _amountController,
                      prefix: Text(
                        TextConstants.amountHint,
                        style: TextStyle(
                          color: ColorConstants.textPrimary(context),
                        ),
                      ),
                      placeholder: TextConstants.enterTransferAmount,
                      placeholderStyle: TextStyle(
                        color: ColorConstants.textTertiary(context),
                      ),
                      style: TextStyle(
                        color: ColorConstants.textPrimary(context),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      autofocus: true,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return TextConstants.balanceRequired;
                        }
                        final amount = double.tryParse(value!);
                        if (amount == null) {
                          return TextConstants.invalidNumber;
                        }
                        if (amount <= 0) {
                          return TextConstants.negativeBalance;
                        }
                        if (amount > widget.sender.balanceInRs) {
                          return TextConstants.insufficientBalance;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      onPressed: _handleTransfer,
                      child: const Text(TextConstants.transfer),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
