import 'package:village_pay/exports.dart';

class GetVillagersCubit extends Cubit<GetVillagersState> {
  GetVillagersCubit() : super(VillagersLoadingState());

  Future<void> getVillagers() async {
    emit(VillagersLoadingState());

    List<String>? villagers = locator<SharedPreferences>()
        .getStringList(SharedPrefsConstants.villagersList);

    if (villagers != null) {
      List<VillagerModel> villagersList = [];
      for (var villager in villagers) {
        villagersList.add(VillagerModel.fromJson(jsonDecode(villager)));
      }
      emit(VillagersLoadedState(villagersList));
    } else {
      emit(VillagersLoadedState([]));
    }
  }
}
