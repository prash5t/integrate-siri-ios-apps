import 'package:intl/intl.dart';
import 'package:village_pay/exports.dart';

class SelfProfileScreen extends StatelessWidget {
  final VillagerModel villager;
  const SelfProfileScreen({super.key, required this.villager});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.read<GetVillagersCubit>().loggedInVillager,
      builder: (context, villager, child) {
        return CupertinoPageScaffold(
          backgroundColor: ColorConstants.backgroundColor(context),
          navigationBar: CupertinoNavigationBar(
            middle: const Text(
              TextConstants.selfProfile,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            backgroundColor:
                ColorConstants.surfaceColor(context).withOpacity(0.8),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(
                CupertinoIcons.square_arrow_right,
                color: ColorConstants.error(context),
              ),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text(TextConstants.logout),
                    content: const Text(TextConstants.areYouSure),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text(TextConstants.cancel),
                        onPressed: () => Navigator.pop(context),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          Navigator.pop(context);
                          BlocProvider.of<LoginCheckerCubit>(context)
                              .signOutUser();
                        },
                        child: const Text(TextConstants.logoutConfirmation),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: ColorConstants.cardColor(context),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.textPrimary(context)
                            .withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor(context)
                              .withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            villager!.name.characters.first.toUpperCase(),
                            style: TextStyle(
                              color: ColorConstants.primaryColor(context),
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        villager.name,
                        style: TextStyle(
                          color: ColorConstants.textPrimary(context),
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${TextConstants.villagerBalance}${villager.balanceInRs.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: ColorConstants.textSecondary(context),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorConstants.cardColor(context),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.textPrimary(context)
                            .withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TextConstants.accountDetails,
                        style: TextStyle(
                          color: ColorConstants.textPrimary(context),
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow(
                        context,
                        TextConstants.id,
                        villager.id,
                        CupertinoIcons.person_crop_circle_badge_checkmark,
                      ),
                      const SizedBox(height: 12),
                      _buildDetailRow(
                        context,
                        TextConstants.joined,
                        DateFormat('dd MMM yyyy').format(villager.joinedAt),
                        CupertinoIcons.calendar,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ColorConstants.backgroundColor(context),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              TextConstants.loadBalance,
                              style: TextStyle(
                                color: ColorConstants.textPrimary(context),
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            BlocProvider(
                              create: (context) => BalanceOperationsCubit(),
                              child: LoadBalanceForm(villager: villager),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorConstants.cardColor(context),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.textPrimary(context)
                              .withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              TextConstants.loadBalance,
                              style: TextStyle(
                                color: ColorConstants.textPrimary(context),
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: null,
                              child: Icon(
                                CupertinoIcons.add_circled_solid,
                                color: ColorConstants.primaryColor(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorConstants.cardColor(context),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.textPrimary(context)
                            .withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TextConstants.transactions,
                        style: TextStyle(
                          color: ColorConstants.textPrimary(context),
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TransactionList(villagerId: villager.id),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorConstants.textSecondary(context),
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          "$label: ",
          style: TextStyle(
            color: ColorConstants.textSecondary(context),
            fontSize: 15,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: ColorConstants.textPrimary(context),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
