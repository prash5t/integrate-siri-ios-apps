import 'package:village_pay/exports.dart';

class VillagerCard extends StatelessWidget {
  final VillagerModel villager;

  const VillagerCard({super.key, required this.villager});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.villagerProfileScreen,
          arguments: villager,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: ColorConstants.cardColor(context),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.textPrimary(context).withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: CupertinoListTile(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leadingSize: 48,
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor(context).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                villager.name.characters.first.toUpperCase(),
                style: TextStyle(
                  color: ColorConstants.primaryColor(context),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          title: Text(
            villager.name,
            style: TextStyle(
              color: ColorConstants.textPrimary(context),
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            '${TextConstants.villagerBalance}${villager.balanceInRs.toStringAsFixed(2)}',
            style: TextStyle(
              color: ColorConstants.textSecondary(context),
              fontSize: 15,
            ),
          ),
          trailing: Icon(
            CupertinoIcons.chevron_right,
            color: ColorConstants.textTertiary(context),
          ),
        ),
      ),
    );
  }
}
