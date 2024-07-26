import 'package:flutter/material.dart';

class PopoverOverlay extends StatelessWidget {
  final WidgetBuilder builder;
  final bool opaque;
  final bool maintainState;
  final bool canSizeOverlay;

  const PopoverOverlay({
    super.key,
    required this.builder,
    this.opaque = false,
    this.maintainState = false,
    this.canSizeOverlay = false,
  });

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: builder,
          opaque: opaque,
          maintainState: maintainState,
          canSizeOverlay: canSizeOverlay,
        ),
      ],
    );
  }
}
