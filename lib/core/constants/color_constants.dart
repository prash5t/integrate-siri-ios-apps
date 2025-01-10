import 'package:flutter/cupertino.dart';

class ColorConstants {
  // Primary Colors
  static const Color primaryColor = Color(0xFF147AFC); // iOS-style blue
  static const Color secondaryColor = Color(0xFF34C759); // Success green

  // Background Colors
  static const Color backgroundColor =
      Color(0xFFF2F2F7); // Light gray background
  static const Color surfaceColor = Color(0xFFFFFFFF); // White surface
  static const Color secondaryBackground =
      Color(0xFFE5E5EA); // Secondary background

  // Text Colors
  static const Color textPrimary = Color(0xFF000000); // Black text
  static const Color textSecondary = Color(0xFF6C6C70); // Secondary text
  static const Color textTertiary = Color(0xFF8E8E93); // Tertiary text

  // Status Colors
  static const Color success = Color(0xFF34C759); // Success/Confirmed
  static const Color error = Color(0xFFFF3B30); // Error/Failed
  static const Color warning = Color(0xFFFF9500); // Warning/Pending
  static const Color info = Color(0xFF5856D6); // Information

  // Interactive Elements
  static const Color linkColor = Color(0xFF147AFC); // Links and buttons
  static const Color destructiveColor =
      Color(0xFFFF3B30); // Delete/Cancel actions
  static const Color disabledColor = Color(0xFFE5E5EA); // Disabled state

  // Dividers and Borders
  static const Color dividerColor = Color(0xFFC6C6C8); // List dividers
  static const Color borderColor = Color(0xFFD1D1D6); // Borders

  // Semantic Colors
  static const Color moneyReceived = Color(0xFF34C759); // Incoming payments
  static const Color moneySent = Color(0xFFFF3B30); // Outgoing payments
  static const Color pendingTransaction = Color(0xFFFF9500); // Pending status

  // Gradients
  static const List<Color> primaryGradient = [
    Color(0xFF147AFC),
    Color(0xFF0E5FCA),
  ];

  // Overlay Colors
  static const Color overlayDark = Color(0x80000000); // 50% black overlay
  static const Color overlayLight = Color(0x80FFFFFF); // 50% white overlay
}
