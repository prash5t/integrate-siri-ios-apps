import 'package:village_pay/exports.dart';

class VillagerProfileScreen extends StatelessWidget {
  final VillagerModel villager;
  const VillagerProfileScreen({super.key, required this.villager});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ColorConstants.backgroundColor(context),
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          villager.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: ColorConstants.surfaceColor(context).withOpacity(0.8),
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
            const SizedBox(height: 24),
            // More sections can be added here for transactions, etc.
          ],
        ),
      ),
    );
  }
}
