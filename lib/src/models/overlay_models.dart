import 'package:flutter/material.dart';

/// The vertical alignment of the overlay.
enum OverlayPosition {
  top,
  bottom,
}

/// The type of toast to display.
enum ToastType {
  success,
  error,
  info,
  warning,
}

/// Unified styling configuration for glassmorphism.
class GlassStyle {
  final double blur;
  final double borderOpacity;
  final double backgroundOpacity;
  final double borderRadius;

  const GlassStyle({
    this.blur = 15.0,
    this.borderOpacity = 0.2,
    this.backgroundOpacity = 0.1,
    this.borderRadius = 50.0,
  });
}

/// Configuration for the premium toast.
class ToastConfig {
  final String message;
  final ToastType type;
  final Duration duration;
  final IconData? customIcon;
  final Color? customColor;
  final OverlayPosition position;
  final bool isDismissible;
  final bool showProgressBar;
  final GlassStyle style;

  const ToastConfig({
    required this.message,
    this.type = ToastType.info,
    this.duration = const Duration(seconds: 3),
    this.customIcon,
    this.customColor,
    this.position = OverlayPosition.bottom,
    this.isDismissible = true,
    this.showProgressBar = true,
    this.style = const GlassStyle(),
  });

  /// The icon to display based on the type.
  IconData get icon {
    if (customIcon != null) return customIcon!;
    switch (type) {
      case ToastType.success:
        return Icons.check_circle_outline_rounded;
      case ToastType.error:
        return Icons.error_outline_rounded;
      case ToastType.warning:
        return Icons.warning_amber_rounded;
      case ToastType.info:
        return Icons.info_outline_rounded;
    }
  }

  /// The color to display based on the type.
  Color get color {
    if (customColor != null) return customColor!;
    switch (type) {
      case ToastType.success:
        return Colors.greenAccent;
      case ToastType.error:
        return Colors.redAccent;
      case ToastType.warning:
        return Colors.orangeAccent;
      case ToastType.info:
        return Colors.blueAccent;
    }
  }
}

/// Configuration for the glass dialog.
class DialogConfig {
  final String title;
  final String? description;
  final Widget? content;
  final String primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final bool barrierDismissible;
  final GlassStyle style;

  const DialogConfig({
    required this.title,
    this.description,
    this.content,
    this.primaryActionLabel = 'Dismiss',
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.barrierDismissible = true,
    this.style = const GlassStyle(borderRadius: 24.0),
  });
}
