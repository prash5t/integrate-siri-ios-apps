import 'package:village_pay/exports.dart';

abstract class GetVillagersState {}

class VillagersLoadingState extends GetVillagersState {}

class VillagersLoadedState extends GetVillagersState {
  final List<VillagerModel> villagers;

  VillagersLoadedState(this.villagers);
}
