import 'package:flutter/material.dart';

import '../measure_size/measure_size.dart';

part 'popover_alignment.dart';
part 'popover_controller.dart';
part 'popover_trigger_type.dart';

class Popover extends StatefulWidget {
  /// Should provide Global Context
  final BuildContext context;

  final PopoverController? controller;
  final Widget action;
  final Widget content;
  final double contentWidth;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final BorderRadius borderRadius;
  final PopoverAlignment alignment;
  final PopoverTriggerType triggerType;

  const Popover(
    this.context, {
    super.key,
    this.controller,
    required this.action,
    required this.content,
    this.contentWidth = 200.0,
    this.backgroundColor,
    this.boxShadow,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.alignment = PopoverAlignment.bottomCenter,
    this.triggerType = PopoverTriggerType.click,
  });

  @override
  State<Popover> createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {
  PopoverController? _popoverController;
  Size _actionSize = Size.zero;
  Offset _actionOffset = Offset.zero;
  Offset _contentOffset = Offset.zero;
  late final OverlayEntry _popoverOverlayEntry;
  final _contentSizeListener = ValueNotifier<Size>(Size.zero);
  final _actionKey = LabeledGlobalKey('easy_popover_action_key');

  @override
  void initState() {
    _popoverOverlayEntry = _buildContentOverlayEntry();
    if (widget.controller == null) {
      _popoverController = PopoverController()
        ..onOpen = _openPopover
        ..onClose = _closePopover;
    } else {
      widget.controller!
        ..onOpen = _openPopover
        ..onClose = _closePopover;
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_controller.opened) {
      _popoverOverlayEntry.remove();
    }
    _popoverOverlayEntry.dispose();
    _contentSizeListener.dispose();
    _popoverController?.dispose();
    super.dispose();
  }

  PopoverController get _controller => widget.controller ?? _popoverController!;

  void _configureConstraints() {
    final renderBox =
        _actionKey.currentContext!.findRenderObject() as RenderBox;
    _actionSize = renderBox.size;
    _actionOffset = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.sizeOf(widget.context);
    final leftSpacing = _actionOffset.dx;
    final topSpacing = _actionOffset.dy;
    final rightSpacing = size.width - leftSpacing - _actionSize.width;
    final bottomSpacing = size.height - topSpacing - _actionSize.height;

    _contentOffset = widget.alignment
        .findBestPopoverPosition(
          contentSize: _contentSizeListener.value,
          leftSpacing: leftSpacing,
          topSpacing: topSpacing,
          rightSpacing: rightSpacing,
          bottomSpacing: bottomSpacing,
        )
        .getContentOffset(
          actionOffset: _actionOffset,
          actionSize: _actionSize,
          contentSize: Size(
            widget.contentWidth,
            _contentSizeListener.value.height,
          ),
        );
  }

  OverlayEntry _buildContentOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            if (widget.triggerType.clicked) ...[
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashFactory: NoSplash.splashFactory,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    overlayColor: const WidgetStatePropertyAll(
                      Colors.transparent,
                    ),
                    onTap: _controller.toggle,
                    child: SizedBox(
                      width: MediaQuery.of(widget.context).size.width,
                      height: MediaQuery.of(widget.context).size.height,
                    ),
                  ),
                ),
              ),
            ],
            ListenableBuilder(
              listenable: _contentSizeListener,
              builder: (context, child) {
                return Positioned(
                  left: _contentOffset.dx,
                  top: _contentOffset.dy,
                  width: widget.contentWidth,
                  child: Opacity(
                    opacity:
                        _contentSizeListener.value.height == 0.0 ? 0.0 : 1.0,
                    child: child!,
                  ),
                );
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? Theme.of(context).cardColor,
                  borderRadius: widget.borderRadius,
                  boxShadow: widget.boxShadow ??
                      [
                        BoxShadow(
                          offset: const Offset(-8, 8),
                          blurRadius: 32,
                          spreadRadius: 16,
                          color:
                              Theme.of(context).shadowColor.withOpacity(0.24),
                        ),
                      ],
                ),
                child: ClipRRect(
                  borderRadius: widget.borderRadius,
                  child: MeasureSize(
                    onChange: (size) {
                      _contentSizeListener.value = size;
                      _configureConstraints();
                    },
                    child: widget.content,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _openPopover() {
    _configureConstraints();

    /// Should use Global Context
    Overlay.of(widget.context).insert(_popoverOverlayEntry);
  }

  void _closePopover() {
    _popoverOverlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        if (_controller.opened) {
          _controller.close();
        }
      },
      child: Material(
        borderRadius: widget.borderRadius,
        elevation: 0.0,
        color: Colors.transparent,
        child: InkWell(
          key: _actionKey,
          onTap: widget.triggerType.clicked ? _controller.toggle : () {},
          onHover:
              widget.triggerType.hovered ? (_) => _controller.toggle() : null,
          borderRadius: widget.borderRadius,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          child: widget.action,
        ),
      ),
    );
  }
}
