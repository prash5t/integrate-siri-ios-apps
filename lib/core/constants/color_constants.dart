import 'package:flutter/cupertino.dart';

class ColorConstants {
  static Color surfaceColor(BuildContext context) {
    return CupertinoTheme.of(context).brightness == Brightness.light
        ? CupertinoColors.systemBackground
        : CupertinoColors.systemBackground.darkColor;
  }

  static Color backgroundColor(BuildContext context) {
    return CupertinoTheme.of(context).brightness == Brightness.light
        ? CupertinoColors.systemGroupedBackground
        : CupertinoColors.systemGroupedBackground.darkColor;
  }

  static Color primaryColor(BuildContext context) {
    return CupertinoTheme.of(context).brightness == Brightness.light
        ? CupertinoColors.systemBlue
        : CupertinoColors.systemBlue.darkColor;
  }

  static Color textPrimary(BuildContext context) {
    return CupertinoTheme.of(context).brightness == Brightness.light
        ? CupertinoColors.label
        : CupertinoColors.label.darkColor;
  }

  static Color textSecondary(BuildContext context) {
    return CupertinoTheme.of(context).brightness == Brightness.light
        ? CupertinoColors.secondaryLabel
        : CupertinoColors.secondaryLabel.darkColor;
  }

  static Color textTertiary(BuildContext context) {
    return CupertinoTheme.of(context).brightness == Brightness.light
        ? CupertinoColors.tertiaryLabel
        : CupertinoColors.tertiaryLabel.darkColor;
  }

  static Color dividerColor(BuildContext context) {
    return CupertinoTheme.of(context).brightness == Brightness.light
        ? CupertinoColors.separator
        : CupertinoColors.separator.darkColor;
  }

  static Color cardColor(BuildContext context) {
    return CupertinoTheme.of(context).brightness == Brightness.light
        ? CupertinoColors.secondarySystemGroupedBackground
        : CupertinoColors.secondarySystemGroupedBackground.darkColor;
  }

  static Color success(BuildContext context) {
    return CupertinoTheme.of(context).brightness == Brightness.light
        ? CupertinoColors.systemGreen
        : CupertinoColors.systemGreen.darkColor;
  }

  static Color error(BuildContext context) {
    return CupertinoTheme.of(context).brightness == Brightness.light
        ? CupertinoColors.systemRed
        : CupertinoColors.systemRed.darkColor;
  }
}
