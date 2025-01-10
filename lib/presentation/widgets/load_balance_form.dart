import 'package:village_pay/exports.dart';

class LoadBalanceForm extends StatefulWidget {
  final VillagerModel villager;
  const LoadBalanceForm({super.key, required this.villager});

  @override
  State<LoadBalanceForm> createState() => _LoadBalanceFormState();
}

class _LoadBalanceFormState extends State<LoadBalanceForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _handleLoadBalance() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<BalanceOperationsCubit>().loadBalance(
            double.parse(_amountController.text.trim()),
            widget.villager.id,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the bottom padding to account for keyboard
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return BlocListener<BalanceOperationsCubit, BalanceOperationsState>(
      listener: (context, state) {
        if (state is BalanceOperationsSuccess) {
          Navigator.pop(context);
          context.read<GetVillagersCubit>().getVillagers();
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text(TextConstants.loadSuccess),
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
                // Drag handle
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
                      placeholder: TextConstants.enterAmount,
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
                      onPressed: _handleLoadBalance,
                      child: const Text(
                        TextConstants.load,
                        style: TextStyle(
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                // Extra padding at bottom for better spacing
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
