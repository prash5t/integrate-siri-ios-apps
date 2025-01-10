import 'package:village_pay/exports.dart';

class GetVillagersCubit extends Cubit<GetVillagersState> {
  GetVillagersCubit() : super(VillagersLoadingState());

  ValueNotifier<VillagerModel?> loggedInVillager = ValueNotifier(null);

  Future<void> getVillagers() async {
    emit(VillagersLoadingState());

    List<String>? villagers = locator<SharedPreferences>()
        .getStringList(SharedPrefsConstants.villagersList);

    String? loggedInVillagerId = locator<SharedPreferences>()
        .getString(SharedPrefsConstants.loggedInVillagerId);

    if (villagers != null) {
      List<VillagerModel> villagersList = [];
      for (var villager in villagers) {
        VillagerModel villagerModel =
            VillagerModel.fromJson(jsonDecode(villager));
        // excluding the logged in villager
        if (villagerModel.id != loggedInVillagerId) {
          villagersList.add(villagerModel);
        }
        if (villagerModel.id == loggedInVillagerId) {
          loggedInVillager.value = villagerModel;
        }
      }
      emit(VillagersLoadedState(villagersList));
    } else {
      emit(VillagersLoadedState([]));
    }
  }
}
