part of 'popover.dart';

enum PopoverAlignment {
  leftTop,
  leftCenter,
  leftBottom,
  topLeft,
  topCenter,
  topRight,
  rightTop,
  rightCenter,
  rightBottom,
  bottomLeft,
  bottomCenter,
  bottomRight;

  Offset getContentOffset({
    required Offset actionOffset,
    required Size actionSize,
    required Size contentSize,
  }) {
    return switch (this) {
      leftTop => Offset(
          actionOffset.dx - contentSize.width,
          actionOffset.dy,
        ),
      leftCenter => Offset(
          actionOffset.dx - contentSize.width,
          (actionOffset.dy + actionSize.height / 2) - contentSize.height / 2,
        ),
      leftBottom => Offset(
          actionOffset.dx - contentSize.width,
          actionOffset.dy - contentSize.height + actionSize.height,
        ),
      topLeft => Offset(
          actionOffset.dx,
          actionOffset.dy - contentSize.height,
        ),
      topCenter => Offset(
          (actionOffset.dx + actionSize.width / 2) - contentSize.width / 2,
          actionOffset.dy - contentSize.height,
        ),
      topRight => Offset(
          actionOffset.dx + actionSize.width - contentSize.width,
          actionOffset.dy - contentSize.height,
        ),
      bottomLeft => Offset(
          actionOffset.dx,
          actionOffset.dy + actionSize.height,
        ),
      bottomCenter => Offset(
          (actionOffset.dx + actionSize.width / 2) - contentSize.width / 2,
          actionOffset.dy + actionSize.height,
        ),
      bottomRight => Offset(
          actionOffset.dx + actionSize.width - contentSize.width,
          actionOffset.dy + actionSize.height,
        ),
      rightTop => Offset(
          actionOffset.dx + actionSize.width,
          actionOffset.dy,
        ),
      rightCenter => Offset(
          actionOffset.dx + actionSize.width,
          (actionOffset.dy + actionSize.height / 2) - contentSize.height / 2,
        ),
      rightBottom => Offset(
          actionOffset.dx + actionSize.width,
          actionOffset.dy - contentSize.height + actionSize.height,
        ),
    };
  }

  PopoverAlignment findBestPopoverPosition({
    required Size contentSize,
    required double leftSpacing,
    required double topSpacing,
    required double rightSpacing,
    required double bottomSpacing,
  }) {
    final contentWidth = contentSize.width;
    final contentHeight = contentSize.height;
    switch (this) {
      case leftTop:
        if (leftSpacing > contentWidth) {
          if (bottomSpacing > contentHeight) return this;
          return leftBottom;
        }

        if (bottomSpacing > contentHeight) return rightTop;
        return rightBottom;
      case leftCenter:
        if (leftSpacing > contentWidth || rightSpacing < contentWidth) {
          return this;
        }
        return rightCenter;
      case leftBottom:
        if (leftSpacing > contentWidth) {
          if (topSpacing > contentHeight) return this;
          return leftTop;
        }

        if (topSpacing > contentHeight) return rightBottom;
        return rightTop;
      case topLeft:
        if (topSpacing > contentHeight) return this;
        return bottomLeft;
      case topCenter:
        if (topSpacing > contentHeight) return this;
        return bottomCenter;
      case topRight:
        if (topSpacing > contentHeight) return this;
        return bottomRight;
      case rightTop:
        if (rightSpacing > contentWidth) {
          if (bottomSpacing > contentHeight) return this;
          return rightBottom;
        }

        if (bottomSpacing > contentHeight) return leftTop;
        return leftBottom;
      case rightCenter:
        if (rightSpacing > contentWidth || leftSpacing < contentWidth) {
          return this;
        }
        return leftCenter;
      case rightBottom:
        if (rightSpacing > contentWidth) {
          if (topSpacing > contentHeight) return this;
          return rightTop;
        }

        if (topSpacing > contentHeight) return leftBottom;
        return leftTop;
      case bottomLeft:
        if (bottomSpacing > contentHeight) return this;
        return topLeft;
      case bottomCenter:
        if (bottomSpacing > contentHeight) return this;
        return topCenter;
      case bottomRight:
        if (bottomSpacing > contentHeight) return this;
        return topRight;
    }
  }

  Alignment get scaleAlignment {
    return switch (this) {
      leftTop => Alignment.topRight,
      leftCenter => Alignment.centerRight,
      leftBottom => Alignment.bottomRight,
      topLeft => Alignment.bottomLeft,
      topCenter => Alignment.bottomCenter,
      topRight => Alignment.bottomRight,
      rightTop => Alignment.topLeft,
      rightCenter => Alignment.centerLeft,
      rightBottom => Alignment.bottomLeft,
      bottomLeft => Alignment.topLeft,
      bottomCenter => Alignment.topCenter,
      bottomRight => Alignment.topRight,
    };
  }
}
