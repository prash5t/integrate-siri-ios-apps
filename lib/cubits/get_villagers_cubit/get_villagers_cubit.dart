import 'package:village_pay/exports.dart';

class GetVillagersCubit extends Cubit<GetVillagersState> {
  GetVillagersCubit() : super(VillagersLoadingState());

  ValueNotifier<VillagerModel?> loggedInVillager = ValueNotifier(null);
  ValueNotifier<List<VillagerModel>> villagers = ValueNotifier([]);

  Future<void> getVillagers() async {
    emit(VillagersLoadingState());

    List<String>? villagersJson = locator<SharedPreferences>()
        .getStringList(SharedPrefsConstants.villagersList);

    String? loggedInVillagerId = locator<SharedPreferences>()
        .getString(SharedPrefsConstants.loggedInVillagerId);

    if (villagersJson != null) {
      try {
        List<VillagerModel> villagersList = [];
        for (var villager in villagersJson) {
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
        List<VillagerModel> updatedVillagers = villagersList;
        villagers.value = updatedVillagers;
        emit(VillagersLoadedState(updatedVillagers, null));
      } catch (e) {
        emit(VillagersLoadedState([], e.toString()));
      }
    } else {
      villagers.value = [];
      emit(VillagersLoadedState([], null));
    }
  }
}
