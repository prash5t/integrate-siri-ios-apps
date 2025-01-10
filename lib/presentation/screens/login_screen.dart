import 'package:village_pay/exports.dart';
import 'package:uuid/uuid.dart';

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
              title: const Text('Error'),
              content: Text(state.errorMessage),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
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
            navigationBar: const CupertinoNavigationBar(
              middle: Text(TextConstants.login),
            ),
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    CupertinoFormSection.insetGrouped(
                      header: const Text(TextConstants.enterYourDetails),
                      children: [
                        CupertinoTextFormFieldRow(
                          controller: _nameController,
                          prefix: const Text(TextConstants.nameLabel),
                          placeholder: TextConstants.nameHint,
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
                          prefix: const Text(TextConstants.balanceLabel),
                          placeholder: TextConstants.balanceHint,
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
                      CupertinoButton.filled(
                        onPressed: _handleLogin,
                        child: const Text(TextConstants.khuljaSimSim),
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
