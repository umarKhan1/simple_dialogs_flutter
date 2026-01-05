import 'package:flutter/material.dart';
import '../models/overlay_models.dart';
import '../widgets/glass_dialog.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/glass_toast.dart';

/// The central access point for displaying context-less overlays.
///
/// Ensure that [navigatorKey] is assigned to your [MaterialApp.navigatorKey]
/// during application initialization.
class SimpleDialogs {
  /// The global navigator key used to interact with the [Overlay] without a [BuildContext].
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final List<OverlayEntry> _activeOverlays = [];

  /// Displays a premium Liquid Glass dialog on the screen.
  ///
  /// Provide a [title] and optional [description] or [content].
  /// Supports dual actions via [primaryActionLabel] and [secondaryActionLabel].
  static void show({
    required String title,
    String? description,
    Widget? content,
    String primaryActionLabel = 'Dismiss',
    VoidCallback? onPrimaryAction,
    String? secondaryActionLabel,
    VoidCallback? onSecondaryAction,
    bool barrierDismissible = true,
    GlassStyle style = const GlassStyle(borderRadius: 24.0),
  }) {
    final config = DialogConfig(
      title: title,
      description: description,
      content: content,
      primaryActionLabel: primaryActionLabel,
      onPrimaryAction: onPrimaryAction,
      secondaryActionLabel: secondaryActionLabel,
      onSecondaryAction: onSecondaryAction,
      barrierDismissible: barrierDismissible,
      style: style,
    );

    final entry = OverlayEntry(
      builder: (context) => GlassDialog(
        config: config,
        onDismiss: () => dismiss(),
      ),
    );
    _showOverlay(entry);
  }

  /// Displays a non-dismissible glass-styled loading overlay.
  ///
  /// Use this to indicate background processing. Call [dismiss] to remove it.
  static void loading({String message = 'Loading...'}) {
    final entry = OverlayEntry(
      builder: (context) => LoadingOverlay(message: message),
    );
    _showOverlay(entry);
  }

  /// Displays a premium pill-shaped glass toast.
  ///
  /// Toasts appear at the top or bottom of the screen and auto-dismiss after [duration].
  /// Supports visual progress bars via [showProgressBar].
  static void toast({
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    OverlayPosition position = OverlayPosition.bottom,
    bool showProgressBar = true,
    bool isDismissible = true,
    GlassStyle style = const GlassStyle(),
    IconData? customIcon,
    Color? customColor,
  }) {
    final config = ToastConfig(
      message: message,
      type: type,
      duration: duration,
      position: position,
      showProgressBar: showProgressBar,
      isDismissible: isDismissible,
      style: style,
      customIcon: customIcon,
      customColor: customColor,
    );

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => GlassToast(
        config: config,
        onDismiss: () => dismissEntry(entry),
      ),
    );

    _showOverlay(entry);

    Future.delayed(duration, () {
      dismissEntry(entry);
    });
  }

  static void _showOverlay(OverlayEntry entry) {
    navigatorKey.currentState?.overlay?.insert(entry);
    _activeOverlays.add(entry);
  }

  /// Dismisses all currently active overlays managed by [SimpleDialogs].
  static void dismiss() {
    for (final entry in _activeOverlays) {
      entry.remove();
    }
    _activeOverlays.clear();
  }

  /// Dismisses a specific [OverlayEntry] if it is currently active.
  static void dismissEntry(OverlayEntry entry) {
    if (_activeOverlays.contains(entry)) {
      entry.remove();
      _activeOverlays.remove(entry);
    }
  }
}
