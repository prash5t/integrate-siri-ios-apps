abstract class BalanceOperationsState {}

class BalanceOperationsInitial extends BalanceOperationsState {}

class BalanceOperationsLoading extends BalanceOperationsState {}

class BalanceOperationsSuccess extends BalanceOperationsState {}

class BalanceOperationsFailure extends BalanceOperationsState {
  final String error;
  BalanceOperationsFailure(this.error);
}
