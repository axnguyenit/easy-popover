# easy_popover

<p align="center">
  <a href="https://github.com/axnguyenit/easy-popover">
    <img align="center" src="https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20Android%20%7C%20Linux%20%7C%20Windows%20%7C%20Web-green.svg" alt="Supported platforms" />
  </a>
  <a href="https://github.com/axnguyenit/easy-popover/blob/master/LICENSE">
    <img align="center" src="https://img.shields.io/badge/License-MIT-green" alt="MIT License">
  </a>
  <a href="https://github.com/axnguyenit/easy-popover/stargazers">
    <img align="center" src="https://img.shields.io/github/stars/axnguyenit/easy-popover?style=flat&logo=github&colorB=green&label=stars" alt="stars">
  </a>
  <a href="https://pub.dev/packages/easy_popover">
    <img align="center" src="https://img.shields.io/pub/v/easy_popover.svg?" alt="pub version">
  </a>
  <a href="https://codecov.io/gh/axnguyenit/easy-popover" >
    <img align="center" src="https://codecov.io/gh/axnguyenit/easy-popover/graph/badge.svg?token=1PYNNZDL89"/>
  </a>
</p>

The Popover package provides a customizable popover widget for Flutter applications. It allows developers to display contextual content tied to a specific widget, with various alignment options, animations, and styles.

<div>
  <img align="center" src="https://res.cloudinary.com/doh079rou/image/upload/v1721206660/easy-popover/popover-example.png" alt="easy_popover" />
</div>

## Demo

https://github.com/user-attachments/assets/a2f0e849-bf3e-4f37-9fde-192eec692236

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [API Reference](#api-reference)
- [Examples](#examples)
- [Contributing](#contributing)
- [Issue Tracker](#issue-tracker)
- [License](#license)

## Features

- [x] Customizable alignment for the popover relative to the action widget.
- [x] Optional arrow pointing to the action widget.
- [x] Configurable dimensions, border radius, box shadow, and background color.
- [x] Animation for showing and hiding the popover.
- [x] Overlay support for capturing taps outside the popover to close it.
- [x] Allow full-screen scrolling capability when opening the popover.

## Installation

```bash
flutter pub add easy_popover
```

## API Reference

- [Popover](https://github.com/axnguyenit/easy-popover/blob/master/lib/src/popover/popover.dart) - The main widget to display a popover.
- [PopoverController](https://github.com/axnguyenit/easy-popover/blob/master/lib/src/popover/popover_controller.dart) - Controller to manage the state of the popover.
- [PopoverAlignment](https://github.com/axnguyenit/easy-popover/blob/master/lib/src/popover/popover_alignment.dart) - Defines the alignment of the popover relative to the action widget.

## Examples

**Note: Wrapping Your App with Overlay for `Popover` Widget**
- To utilize the `Popover` widget in your Flutter application, it is essential to wrap your app with an `PopoverOverlay`. The `PopoverOverlay` widget allows the `Popover` widget to be inserted and displayed correctly on top of other widgets. Below is an example of how to wrap your app with an `PopoverOverlay`:
```dart
@override
Widget build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Easy Popover Example',
    home: PopoverOverlay(
      child: PopoverExampleScreen(),
    ),
  );
}
```

- See [Example](https://pub.dev/packages/easy_popover/example) for details
- Or run the example app included with this package:

1. Clone the repository from GitHub:

```bash
git clone https://github.com/axnguyenit/easy-popover.git
```

2. Navigate to the example directory:

```bash
cd example
```

3. Ensure dependencies are installed:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

This will launch the example app demonstrating various uses of the `Popover` widget.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes. Ensure that your code follows the existing style and includes tests for new features or bug fixes.

## Issue Tracker

If you encounter any issues or have suggestions for improvements, please feel free to [open an issue](https://github.com/axnguyenit/easy-popover/issues) on GitHub.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/axnguyenit/easy-popover/blob/master/LICENSE) file for details.
