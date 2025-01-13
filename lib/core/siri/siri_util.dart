import 'package:village_pay/exports.dart';

class SiriUtil {
  static const String kCheckBalance = 'check_balance';
  static const String kLoadBalance = 'load_balance';
  Future<void> init() async {
    await populateSiriShortcut();
    Intelligence().selectionsStream().listen(
      (event) async {
        await handleSelection(event);
      },
      onError: (error) {
        debugPrint("SiriUtil: $error");
      },
    );
  }

  Future<void> populateSiriShortcut() async {
    try {
      await Intelligence().populate(const [
        Representable(
          id: kCheckBalance,
          representation: 'Check Balance',
        ),
      ]);
    } catch (e) {
      debugPrint("populateSiriShortcut: $e");
    }
  }

  Future<void> handleSelection(String selection) async {
    switch (selection) {
      case kCheckBalance:
        debugPrint("check_balance");
        Navigator.of(navigatorKey.currentContext!).pushNamed(
            AppRoutes.selfProfileScreen,
            arguments:
                BlocProvider.of<GetVillagersCubit>(navigatorKey.currentContext!)
                    .loggedInVillager
                    .value);

        break;
      case kLoadBalance:
        debugPrint("load_balance");
        break;
    }
  }
}
