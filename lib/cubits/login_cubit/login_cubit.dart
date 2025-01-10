import 'package:village_pay/exports.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(VillagerModel villagerToLogin) async {
    emit(LoginLoading());

    // seeding villagers initially
    List<VillagerModel> otherVillagersAlongWithThisVillager =
        villagersToSeed + [villagerToLogin];

    // saving villagers to shared prefs
    List<String> encodedVillagers = [];
    for (var villager in otherVillagersAlongWithThisVillager) {
      encodedVillagers.add(jsonEncode(villager.toJson()));
    }

    bool villagersSaved = await locator<SharedPreferences>()
        .setStringList(SharedPrefsConstants.villagersList, encodedVillagers);

    // setting logged in villager id
    bool loginSaved = await locator<SharedPreferences>()
        .setString(SharedPrefsConstants.loggedInVillagerId, villagerToLogin.id);
    if (villagersSaved && loginSaved) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure(errorMessage: TextConstants.loginFailed));
    }
  }
}
