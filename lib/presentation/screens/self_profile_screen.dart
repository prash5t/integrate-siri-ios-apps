import 'package:village_pay/exports.dart';

class SelfProfileScreen extends StatelessWidget {
  final VillagerModel villager;
  const SelfProfileScreen({super.key, required this.villager});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ColorConstants.backgroundColor(context),
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Self Profile",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: ColorConstants.surfaceColor(context).withOpacity(0.8),
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
                title: const Text("Logout"),
                content: const Text("Are you sure you want to logout?"),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                      BlocProvider.of<LoginCheckerCubit>(context).signOutUser();
                    },
                    child: const Text("Logout"),
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
                    width: 100,
                    height: 100,
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
                    color:
                        ColorConstants.textPrimary(context).withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account Details",
                    style: TextStyle(
                      color: ColorConstants.textPrimary(context),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    context,
                    "ID",
                    villager.id,
                    CupertinoIcons.person_crop_circle_badge_checkmark,
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    context,
                    "Joined",
                    "Today", // You can add a timestamp to VillagerModel if needed
                    CupertinoIcons.calendar,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
