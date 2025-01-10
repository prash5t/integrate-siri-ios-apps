import 'package:village_pay/exports.dart';

extension WidgetExtensions on Widget {
  hideKeyboardonTapOrScroll() {
    return Listener(
      onPointerDown: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onPointerUp: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GestureDetector(
        onTap: () {
          //  FocusManager.instance.primaryFocus?.unfocus()
        },
        child: this,
      ),
    );
  }
}
