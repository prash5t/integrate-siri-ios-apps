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

  Widget _buildLoggedInVillagerCard(VillagerModel villager) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.selfProfileScreen,
          arguments: villager,
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorConstants.primaryColor(context),
              ColorConstants.primaryColor(context).withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.primaryColor(context).withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color:
                        ColorConstants.surfaceColor(context).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      villager.name.characters.first.toUpperCase(),
                      style: TextStyle(
                        color: ColorConstants.surfaceColor(context),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        villager.name,
                        style: TextStyle(
                          color: ColorConstants.surfaceColor(context),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.surfaceColor(context)
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Account Owner",
                          style: TextStyle(
                            color: ColorConstants.surfaceColor(context),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  CupertinoIcons.chevron_right,
                  color: ColorConstants.surfaceColor(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorConstants.surfaceColor(context).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    TextConstants.villagerBalance,
                    style: TextStyle(
                      color: ColorConstants.surfaceColor(context),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    villager.balanceInRs.toStringAsFixed(2),
                    style: TextStyle(
                      color: ColorConstants.surfaceColor(context),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
                    child: _buildLoggedInVillagerCard(
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
