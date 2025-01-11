import 'package:village_pay/exports.dart';

class VillagerProfileScreen extends StatelessWidget {
  final VillagerModel villager;
  const VillagerProfileScreen({super.key, required this.villager});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ColorConstants.backgroundColor(context),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: ColorConstants.backgroundColor(context),
        middle: Text(villager.name),
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
                    color:
                        ColorConstants.textPrimary(context).withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color:
                          ColorConstants.primaryColor(context).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        villager.name.characters.first.toUpperCase(),
                        style: TextStyle(
                          color: ColorConstants.primaryColor(context),
                          fontSize: 32,
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
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${TextConstants.villagerBalance}${villager.balanceInRs.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: ColorConstants.textSecondary(context),
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
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
                          TextConstants.transferBalance,
                          style: TextStyle(
                            color: ColorConstants.textPrimary(context),
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        BlocProvider(
                          create: (context) => BalanceOperationsCubit(),
                          child: TransferBalanceForm(
                            receiver: villager,
                            sender: context
                                .read<GetVillagersCubit>()
                                .loggedInVillager
                                .value!,
                          ),
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
                      color:
                          ColorConstants.textPrimary(context).withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TextConstants.transferBalance,
                      style: TextStyle(
                        color: ColorConstants.textPrimary(context),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      CupertinoIcons.arrow_right_circle_fill,
                      color: ColorConstants.primaryColor(context),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TransactionList(villagerId: villager.id),
          ],
        ),
      ),
    );
  }
}
