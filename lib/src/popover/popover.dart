import 'dart:math';

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
  final bool applyActionWidth;
  final bool scrollEnabled;
  final double arrowSize;
  final double arrowRadius;
  final bool showArrow;

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
    this.applyActionWidth = false,
    this.scrollEnabled = false,
    this.arrowSize = 20.0,
    this.arrowRadius = 2.0,
    this.showArrow = true,
  });

  @override
  State<Popover> createState() => _PopoverState();
}

class _PopoverState extends State<Popover> with SingleTickerProviderStateMixin {
  final _layerLink = LayerLink();
  PopoverController? _popoverController;
  Size _actionSize = Size.zero;
  late final OverlayEntry _popoverOverlayEntry;
  final _contentSizeListener = ValueNotifier<Size>(Size.zero);
  final _actionKey = LabeledGlobalKey('easy_popover_action_key');
  late final Animation<double> _animation;
  late final AnimationController _animationController;
  PopoverAlignment _popoverAlignment = PopoverAlignment.bottomCenter;

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
    _initializeAnimation();
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
    _animationController.dispose();
    super.dispose();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 150),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      _animationController,
    );
  }

  PopoverController get _controller => widget.controller ?? _popoverController!;

  double get _contentWidth =>
      widget.applyActionWidth ? _actionSize.width : widget.contentWidth;

  void _configureConstraints() {
    final renderBox =
        _actionKey.currentContext!.findRenderObject() as RenderBox;
    _actionSize = renderBox.size;
    final actionOffset = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.sizeOf(widget.context);
    final leftSpacing = actionOffset.dx;
    final topSpacing = actionOffset.dy;
    final rightSpacing = size.width - leftSpacing - _actionSize.width;
    final bottomSpacing = size.height - topSpacing - _actionSize.height;
    _popoverAlignment = widget.alignment.findBestPopoverPosition(
      contentSize: _contentSizeListener.value,
      leftSpacing: leftSpacing,
      topSpacing: topSpacing,
      rightSpacing: rightSpacing,
      bottomSpacing: bottomSpacing,
    );
  }

  OverlayEntry _buildContentOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            if (widget.triggerType.clicked && !widget.scrollEnabled) ...[
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
                  width: _contentWidth,
                  child: CompositedTransformFollower(
                    link: _layerLink,
                    showWhenUnlinked: false,
                    offset: _popoverAlignment.getContentOffset(
                      actionSize: _actionSize,
                      contentSize: Size(
                        _contentWidth,
                        _contentSizeListener.value.height,
                      ),
                    ),
                    child: ScaleTransition(
                      scale: _animation,
                      alignment: _popoverAlignment.scaleAlignment,
                      child: Opacity(
                        opacity: _animation.value,
                        child: child!,
                      ),
                    ),
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
            if (widget.showArrow) ...[
              Positioned(
                width: widget.arrowSize,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: _popoverAlignment.getArrowOffset(
                    actionSize: _actionSize,
                    arrowSize: widget.arrowSize,
                  ),
                  child: ScaleTransition(
                    scale: _animation,
                    alignment: _popoverAlignment.arrowScaleAlignment,
                    child: Opacity(
                      opacity: _animation.value,
                      child: Transform.rotate(
                        angle: _popoverAlignment.arrowAngle * pi / 180,
                        child: CustomPaint(
                          size: Size(widget.arrowSize, widget.arrowSize),
                          painter: RoundedTrianglePainter(
                            radius: widget.arrowRadius,
                            color: widget.backgroundColor ??
                                Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  void _openPopover() {
    _configureConstraints();

    /// Should use Global Context
    final overlayState = Overlay.of(widget.context);
    _animationController.addListener(() {
      overlayState.setState(() {});
    });
    overlayState.insert(_popoverOverlayEntry);
    _animationController.forward();
  }

  void _closePopover() {
    _animationController.reverse().whenComplete(_popoverOverlayEntry.remove);
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
          child: CompositedTransformTarget(
            link: _layerLink,
            child: widget.action,
          ),
        ),
      ),
    );
  }
}

// isosceles right triangle
class RoundedTrianglePainter extends CustomPainter {
  final double radius;
  final Color color;

  RoundedTrianglePainter({
    this.radius = 2.0,
    required this.color,
  });

  ///           A
  ///           △
  ///          /▽\
  ///         / ⎪ \
  ///        /  ⎪  \
  ///       /   ⎪   \
  ///      /    ⎪    \
  ///     /     ⎪     \
  ///    /     ◻︎⎪◻︎     \
  ///  B ‾‾‾‾‾‾‾‾‾‾‾‾‾‾ C
  ///       hypotenuse
  ///
  @override
  void paint(Canvas canvas, Size size) {
    final hypotenuse = size.width;
    final height = hypotenuse * cos(45);
    final acuteAngles = atan(2 * height / hypotenuse);
    final S = radius / cos(acuteAngles);
    final L = radius * tan(acuteAngles);
    final h = L * sin(acuteAngles);
    final b = 2 * L * cos(acuteAngles);

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    final basePath = Path()
      ..moveTo(hypotenuse / 2, height)
      ..relativeLineTo(-hypotenuse / 2, 0)
      ..relativeLineTo(hypotenuse - (hypotenuse / 2 + b / 2), -height + h)
      ..relativeLineTo(b, 0)
      ..lineTo(hypotenuse, height)
      ..close;

    final arcRect = Rect.fromCenter(
      center: Offset(hypotenuse / 2, S),
      width: 2 * radius,
      height: 2 * radius,
    );

    final arcPath = Path()
      ..addArc(arcRect, pi + acuteAngles, 2 * acuteAngles)
      ..close;

    final completePath = Path.combine(PathOperation.union, basePath, arcPath);

    canvas.drawPath(completePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
