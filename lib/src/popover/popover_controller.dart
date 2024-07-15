part of 'popover.dart';

class PopoverController extends ChangeNotifier {
  bool opened = false;
  VoidCallback? _open;
  VoidCallback? _close;

  set onOpen(VoidCallback onOpen) {
    _open = onOpen;
  }

  void open() {
    if (opened) return;
    _open?.call();
    opened = true;
    notifyListeners();
  }

  set onClose(VoidCallback onClose) {
    _close = onClose;
  }

  void close() {
    if (!opened) return;
    _close?.call();
    opened = false;
    notifyListeners();
  }

  void toggle() => opened ? close() : open();
}
