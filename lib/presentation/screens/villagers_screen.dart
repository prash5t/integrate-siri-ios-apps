import 'package:village_pay/exports.dart';

class VillagersScreen extends StatefulWidget {
  const VillagersScreen({super.key});

  @override
  State<VillagersScreen> createState() => _VillagersScreenState();
}

class _VillagersScreenState extends State<VillagersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetVillagersCubit>(context).getVillagers();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ColorConstants.backgroundColor(context),
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          TextConstants.villagers,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: ColorConstants.surfaceColor(context).withOpacity(0.8),
      ),
      child: SafeArea(
        child: BlocBuilder<GetVillagersCubit, GetVillagersState>(
          builder: (context, state) {
            if (state is VillagersLoadingState) {
              return const Center(
                child: CupertinoActivityIndicator(radius: 16),
              );
            }

            if (state is VillagersLoadedState) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: LoggedInUserCard(
                      villager:
                          context.read<GetVillagersCubit>().loggedInVillager,
                    ),
                  ),
                  if (state.villagers.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.person_2_fill,
                              size: 64,
                              color: ColorConstants.textSecondary(context),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              TextConstants.noVillagers,
                              style: TextStyle(
                                color: ColorConstants.textSecondary(context),
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final villager = state.villagers[index];
                          return VillagerCard(villager: villager);
                        },
                        childCount: state.villagers.length,
                      ),
                    ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
