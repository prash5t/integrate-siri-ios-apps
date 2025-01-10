import 'package:village_pay/exports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      final villager = VillagerModel(
        id: const Uuid().v4(),
        joinedAt: DateTime.now(),
        name: _nameController.text.trim(),
        balanceInRs: double.parse(_balanceController.text.trim()),
      );

      context.read<LoginCubit>().login(villager);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.villagersScreen,
            (route) => false,
          );
        } else if (state is LoginFailure) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(TextConstants.error),
              content: Text(state.errorMessage),
              actions: [
                CupertinoDialogAction(
                  child: Text(TextConstants.ok),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return CupertinoPageScaffold(
            backgroundColor: ColorConstants.backgroundColor(context),
            navigationBar: CupertinoNavigationBar(
              middle: Text(
                TextConstants.login,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              backgroundColor:
                  ColorConstants.surfaceColor(context).withOpacity(0.8),
            ),
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    CupertinoFormSection.insetGrouped(
                      backgroundColor: ColorConstants.cardColor(context),
                      header: Text(
                        TextConstants.enterYourDetails,
                        style: TextStyle(
                          color: ColorConstants.textSecondary(context),
                          fontSize: 13,
                        ),
                      ),
                      children: [
                        CupertinoTextFormFieldRow(
                          controller: _nameController,
                          prefix: Text(
                            TextConstants.nameLabel,
                            style: TextStyle(
                              color: ColorConstants.textPrimary(context),
                            ),
                          ),
                          placeholder: TextConstants.nameHint,
                          placeholderStyle: TextStyle(
                            color: ColorConstants.textTertiary(context),
                          ),
                          style: TextStyle(
                            color: ColorConstants.textPrimary(context),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return TextConstants.nameRequired;
                            }
                            if (value!.length < 3) {
                              return TextConstants.nameMinLength;
                            }
                            return null;
                          },
                        ),
                        CupertinoTextFormFieldRow(
                          controller: _balanceController,
                          prefix: Text(
                            TextConstants.balanceLabel,
                            style: TextStyle(
                              color: ColorConstants.textPrimary(context),
                            ),
                          ),
                          placeholder: TextConstants.balanceHint,
                          placeholderStyle: TextStyle(
                            color: ColorConstants.textTertiary(context),
                          ),
                          style: TextStyle(
                            color: ColorConstants.textPrimary(context),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return TextConstants.balanceRequired;
                            }
                            final balance = double.tryParse(value!);
                            if (balance == null) {
                              return TextConstants.invalidNumber;
                            }
                            if (balance < 0) {
                              return TextConstants.negativeBalance;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    if (state is LoginLoading)
                      const Center(child: CupertinoActivityIndicator())
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CupertinoButton.filled(
                          onPressed: _handleLogin,
                          child: const Text(TextConstants.khuljaSimSim),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ).hideKeyboardonTapOrScroll();
        },
      ),
    );
  }
}
