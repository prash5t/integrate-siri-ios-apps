import 'package:village_pay/exports.dart';

class SelfProfileScreen extends StatelessWidget {
  final VillagerModel villager;
  const SelfProfileScreen({super.key, required this.villager});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Self Profile"),
      ),
      child: Container(),
    );
  }
}
