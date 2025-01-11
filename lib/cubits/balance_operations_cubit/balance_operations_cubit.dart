import 'package:village_pay/exports.dart';

class BalanceOperationsCubit extends Cubit<BalanceOperationsState> {
  BalanceOperationsCubit() : super(BalanceOperationsInitial());

  Future<void> loadBalance(double amount, String villagerId) async {
    emit(BalanceOperationsLoading());
    try {
      // Get existing transactions
      List<String>? transactionsJson = locator<SharedPreferences>()
          .getStringList(SharedPrefsConstants.transactionsList);
      List<TransactionModel> transactions = [];

      if (transactionsJson != null) {
        transactions = transactionsJson
            .map((e) => TransactionModel.fromJson(jsonDecode(e)))
            .toList();
      }

      // Create balance load model
      final balanceLoad = BalanceLoadModel(
        id: const Uuid().v4(),
        villagerId: villagerId,
        balanceInRs: amount,
        txnTimeStamp: DateTime.now(),
      );

      // Create transaction model
      final transaction = TransactionModel(
        id: const Uuid().v4(),
        transactionType: TransactionType.balanceLoad,
        balanceLoadModel: balanceLoad,
        balanceTransferModel: null,
      );

      // Add to transactions list
      transactions.add(transaction);
      await locator<SharedPreferences>().setStringList(
        SharedPrefsConstants.transactionsList,
        transactions.map((e) => jsonEncode(e.toJson())).toList(),
      );

      // Update villager balance
      List<String>? villagersJson = locator<SharedPreferences>()
          .getStringList(SharedPrefsConstants.villagersList);

      if (villagersJson != null) {
        List<VillagerModel> villagers = villagersJson
            .map((e) => VillagerModel.fromJson(jsonDecode(e)))
            .toList();

        int index = villagers.indexWhere((v) => v.id == villagerId);
        if (index != -1) {
          VillagerModel updatedVillager = VillagerModel(
            id: villagers[index].id,
            name: villagers[index].name,
            balanceInRs: villagers[index].balanceInRs + amount,
            joinedAt: villagers[index].joinedAt,
          );
          villagers[index] = updatedVillager;

          await locator<SharedPreferences>().setStringList(
            SharedPrefsConstants.villagersList,
            villagers.map((e) => jsonEncode(e.toJson())).toList(),
          );
        }
      }

      emit(BalanceOperationsSuccess());
    } catch (e) {
      emit(BalanceOperationsFailure(e.toString()));
    }
  }

  Future<void> transferBalance(
    double amount,
    String fromId,
    String toId,
  ) async {
    emit(BalanceOperationsLoading());
    try {
      // Get existing transactions
      List<String>? transactionsJson = locator<SharedPreferences>()
          .getStringList(SharedPrefsConstants.transactionsList);
      List<TransactionModel> transactions = [];

      if (transactionsJson != null) {
        transactions = transactionsJson
            .map((e) => TransactionModel.fromJson(jsonDecode(e)))
            .toList();
      }

      // Create balance transfer model
      final balanceTransfer = BalanceTransferModel(
        id: const Uuid().v4(),
        fromId: fromId,
        toId: toId,
        amount: amount,
        txnTimeStamp: DateTime.now(),
      );

      // Create transaction model
      final transaction = TransactionModel(
        id: const Uuid().v4(),
        transactionType: TransactionType.balanceTransfer,
        balanceLoadModel: null,
        balanceTransferModel: balanceTransfer,
      );

      // Add to transactions list
      transactions.add(transaction);
      await locator<SharedPreferences>().setStringList(
        SharedPrefsConstants.transactionsList,
        transactions.map((e) => jsonEncode(e.toJson())).toList(),
      );

      // Update villagers' balances
      List<String>? villagersJson = locator<SharedPreferences>()
          .getStringList(SharedPrefsConstants.villagersList);

      if (villagersJson != null) {
        List<VillagerModel> villagers = villagersJson
            .map((e) => VillagerModel.fromJson(jsonDecode(e)))
            .toList();

        // Update sender's balance
        int senderIndex = villagers.indexWhere((v) => v.id == fromId);
        if (senderIndex != -1) {
          if (villagers[senderIndex].balanceInRs < amount) {
            throw TextConstants.insufficientBalance;
          }
          VillagerModel updatedSender = VillagerModel(
            id: villagers[senderIndex].id,
            name: villagers[senderIndex].name,
            balanceInRs: villagers[senderIndex].balanceInRs - amount,
            joinedAt: villagers[senderIndex].joinedAt,
          );
          villagers[senderIndex] = updatedSender;
        }

        // Update receiver's balance
        int receiverIndex = villagers.indexWhere((v) => v.id == toId);
        if (receiverIndex != -1) {
          VillagerModel updatedReceiver = VillagerModel(
            id: villagers[receiverIndex].id,
            name: villagers[receiverIndex].name,
            balanceInRs: villagers[receiverIndex].balanceInRs + amount,
            joinedAt: villagers[receiverIndex].joinedAt,
          );
          villagers[receiverIndex] = updatedReceiver;
        }

        await locator<SharedPreferences>().setStringList(
          SharedPrefsConstants.villagersList,
          villagers.map((e) => jsonEncode(e.toJson())).toList(),
        );
      }

      emit(BalanceOperationsSuccess());
    } catch (e) {
      emit(BalanceOperationsFailure(e.toString()));
    }
  }
}
