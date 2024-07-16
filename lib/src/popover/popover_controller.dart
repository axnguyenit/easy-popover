part of 'popover.dart';

/// The [PopoverController] class manages the state and behavior of a popover.
/// It extends [ChangeNotifier] to notify listeners about changes
/// in the popover's state.
class PopoverController extends ChangeNotifier {
  /// Indicates whether the popover is currently opened.
  bool opened = false;

  /// Callback to be executed when the popover is opened.
  VoidCallback? _open;

  /// Callback to be executed when the popover is closed.
  VoidCallback? _close;

  /// Sets the callback to be executed when the popover is opened.
  ///
  /// - [onOpen]: The callback function to be executed on popover open.
  set onOpen(VoidCallback onOpen) {
    _open = onOpen;
  }

  /// Opens the popover if it is not already opened and notifies listeners.
  void open() {
    if (opened) return;
    _open?.call();
    opened = true;
    notifyListeners();
  }

  /// Sets the callback to be executed when the popover is closed.
  ///
  /// - [onClose]: The callback function to be executed on popover close.
  set onClose(VoidCallback onClose) {
    _close = onClose;
  }

  /// Closes the popover if it is not already closed and notifies listeners.
  void close() {
    if (!opened) return;
    _close?.call();
    opened = false;
    notifyListeners();
  }

  /// Toggles the state of the popover between opened and closed.
  void toggle() => opened ? close() : open();
}
