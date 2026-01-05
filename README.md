# Simple Dialogs Flutter (Liquid Glass Edition)

[![Pub Version](https://img.shields.io/pub/v/simple_dialogs_flutter?color=blue&logo=dart)](https://pub.dev/packages/simple_dialogs_flutter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Simple Dialogs Flutter is a professional context-less overlay system for Flutter applications. It provides a sophisticated Liquid Glass aesthetic (glassmorphism) powered by physics-based animations and a clean, layered architecture.

![Demo](https://raw.githubusercontent.com/umarKhan1/simple_dialogs_flutter/main/assets/demo.gif)

## Core Features

### Context-less API
The package utilizes a GlobalKey-based Navigator state to manage overlays. This allows developers to trigger dialogs, toasts, and loading indicators from anywhere in the application—including repositories, services, or business logic—without the need to pass a BuildContext through every layer.

### Liquid Glass Design System
The UI is built on a custom glassmorphism implementation that combines BackdropFilter, procedural blurs, and vibrant opacity-based tinting. This creates a depth-aware interface that adapts to the background content of your application while maintaining high legibility.

### Physics-Based Animations
Transitions are driven by custom AnimationControllers using Curves.elasticOut and spring-simulated curves. This ensures that every entry and exit feels fluid and responsive, avoiding the static feel of traditional modal transitions.

### Positional Toast System
Toasts support dynamic alignment to the top or bottom of the viewport. The system automatically calculates safe area offsets and reverses sliding directions based on the chosen position to maintain visual consistency.

### Advanced Customization
Every component is highly configurable through the GlassStyle and Config models, allowing for granular control over aesthetics and behavioral logic.

---

## Technical Integration

### 1. Installation

Add the following to your pubspec.yaml:

```yaml
dependencies:
  simple_dialogs_flutter: ^2.2.1
```

### 2. Initialization

Configure the GlobalKey in your MaterialApp to enable context-less operations:

```dart
import 'package:simple_dialogs_flutter/simple_dialogs_flutter.dart';

void main() {
  runApp(MaterialApp(
    navigatorKey: SimpleDialogs.navigatorKey,
    // ...
  ));
}
```

---

## Detailed Usage Guide

### Premium Dialogs
The dialog system supports complex interactive flows with primary and secondary actions.

```dart
SimpleDialogs.show(
  title: 'Delete Confirmation',
  description: 'This operation is permanent. Are you sure you wish to proceed?',
  primaryActionLabel: 'Confirm Delete',
  secondaryActionLabel: 'Cancel',
  onPrimaryAction: () => _handleDelete(),
  onSecondaryAction: () => _handleCancel(),
  barrierDismissible: false, // Prevent closing by tapping outside
  style: GlassStyle(blur: 20.0, borderRadius: 24.0),
);
```

### Advanced Toasts
Toasts are pill-shaped overlays with built-in status icons and optional visual progress timers.

```dart
SimpleDialogs.toast(
  message: 'Operation was successful',
  type: ToastType.success,
  position: OverlayPosition.top,
  showProgressBar: true,
  duration: Duration(seconds: 4),
  style: GlassStyle(
    backgroundOpacity: 0.15,
    borderOpacity: 0.25,
  ),
);
```

### Global Loaders
A non-dismissible glass-styled loading indicator for blocking UI operations during async tasks.

```dart
// Start loader
SimpleDialogs.loading(message: 'Processing Data...');

// Dismiss when task is complete
SimpleDialogs.dismiss();
```

---

## Customization Logic

### The GlassStyle Specification
The `GlassStyle` model allows developers to define a consistent design language across all overlays:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `blur` | double | 15.0 | The intensity of the BackdropFilter blur effect. |
| `backgroundOpacity` | double | 0.1 | The alpha value of the container background. |
| `borderOpacity` | double | 0.2 | The alpha value of the surrounding border. |
| `borderRadius` | double | 50.0 | The corner radius (use higher values for pill shapes). |

---

## Architectural Philosophy
Simple Dialogs Flutter is built on a decoupled architecture located in `lib/src/`:
- **Core Manager**: Handles the OverlayEntry lifecycle and queue management.
- **Models**: Immutable configuration objects ensuring predictable state.
- **Widgets**: Pure UI components that consume configuration models without internal business logic.

This separation of concerns makes the package highly extensible and easy to maintain within large-scale production environments.

---

## 👨‍💻 Author

Developed by **Muhammad Omar**. Passionate about creating premium UI experiences for the Flutter community.

[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/umarKhan1)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/muhammad-omar-0335/)

---

## 🌟 Support & Contribution

If you find this package helpful, please consider giving it a **Star** on [GitHub](https://github.com/umarKhan1/simple_dialogs_flutter)! Contributions, issues, and feature requests are always welcome.

## License
Licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
