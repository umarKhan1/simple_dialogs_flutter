import 'package:flutter/material.dart';

/// The vertical alignment of the overlay components on the screen.
enum OverlayPosition {
  /// Aligns the component to the top of the screen.
  top,

  /// Aligns the component to the bottom of the screen.
  bottom,
}

/// The visual type of toast to display, determining its default icon and color palette.
enum ToastType {
  /// Successful operation indicator (Green).
  success,

  /// Error or failure indicator (Red).
  error,

  /// Informational message indicator (Blue).
  info,

  /// Warning or caution indicator (Orange).
  warning,
}

/// A configuration object that defines the visual style of the Glassmorphism effect.
class GlassStyle {
  /// The intensity of the backdrop blur effect.
  final double blur;

  /// The opacity of the outer border.
  final double borderOpacity;

  /// The opacity of the inner background layer.
  final double backgroundOpacity;

  /// The corner radius of the glass container.
  final double borderRadius;

  /// Creates a [GlassStyle] with customizable glassmorphism properties.
  const GlassStyle({
    this.blur = 15.0,
    this.borderOpacity = 0.2,
    this.backgroundOpacity = 0.1,
    this.borderRadius = 50.0,
  });
}

/// Configuration model for displaying toasts with specific behaviors and styles.
class ToastConfig {
  /// The primary message text to display in the toast.
  final String message;

  /// The type of toast, which determines the default icon and color.
  final ToastType type;

  /// The total duration the toast remains visible before auto-dismissing.
  final Duration duration;

  /// An optional custom icon to override the default type-based icon.
  final IconData? customIcon;

  /// An optional custom color to override the default type-based color.
  final Color? customColor;

  /// The screen alignment where the toast should appear.
  final OverlayPosition position;

  /// Whether the toast can be dismissed manually by the user (e.g., swipe).
  final bool isDismissible;

  /// Whether to show a visual progress bar indicating the remaining duration.
  final bool showProgressBar;

  /// The glassmorphism styling parameters for the toast container.
  final GlassStyle style;

  /// Creates a [ToastConfig] with the specified message and optional configurations.
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

  /// Resolves the effective [IconData] to use for the toast.
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

  /// Resolves the effective [Color] to use for the toast's primary visual elements.
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

/// Configuration model for displaying interactive glass-styled dialogs.
class DialogConfig {
  /// The primary title text of the dialog.
  final String title;

  /// An optional secondary description text for the dialog.
  final String? description;

  /// An optional custom [Widget] to display as the dialog's content.
  final Widget? content;

  /// The text label for the primary action button.
  final String primaryActionLabel;

  /// The callback to execute when the primary action button is pressed.
  final VoidCallback? onPrimaryAction;

  /// The optional text label for the secondary action button.
  final String? secondaryActionLabel;

  /// The optional callback to execute when the secondary action button is pressed.
  final VoidCallback? onSecondaryAction;

  /// Whether the dialog can be dismissed by tapping on the background barrier.
  final bool barrierDismissible;

  /// The glassmorphism styling parameters for the dialog container.
  final GlassStyle style;

  /// Creates a [DialogConfig] with the specified title and optional configurations.
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
