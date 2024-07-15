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
    required Size actionSize,
    required Size contentSize,
  }) {
    return switch (this) {
      leftTop => Offset(
          -contentSize.width,
          0,
        ),
      leftCenter => Offset(
          -contentSize.width,
          (actionSize.height / 2) - contentSize.height / 2,
        ),
      leftBottom => Offset(
          -contentSize.width,
          -contentSize.height + actionSize.height,
        ),
      topLeft => Offset(
          0,
          -contentSize.height,
        ),
      topCenter => Offset(
          (actionSize.width / 2) - contentSize.width / 2,
          -contentSize.height,
        ),
      topRight => Offset(
          actionSize.width - contentSize.width,
          -contentSize.height,
        ),
      bottomLeft => Offset(
          0,
          actionSize.height,
        ),
      bottomCenter => Offset(
          (actionSize.width / 2) - contentSize.width / 2,
          actionSize.height,
        ),
      bottomRight => Offset(
          actionSize.width - contentSize.width,
          actionSize.height,
        ),
      rightTop => Offset(
          actionSize.width,
          0,
        ),
      rightCenter => Offset(
          actionSize.width,
          (actionSize.height / 2) - contentSize.height / 2,
        ),
      rightBottom => Offset(
          actionSize.width,
          -contentSize.height + actionSize.height,
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

  Alignment get arrowScaleAlignment {
    return switch (this) {
      leftTop || leftCenter || leftBottom => Alignment.centerLeft,
      topLeft || topCenter || topRight => Alignment.topCenter,
      rightTop || rightCenter || rightBottom => Alignment.centerRight,
      bottomLeft || bottomCenter || bottomRight => Alignment.bottomCenter,
    };
  }

  double get arrowAngle {
    return switch (this) {
      leftTop || leftCenter || leftBottom => 90.0,
      topLeft || topCenter || topRight => 180.0,
      rightTop || rightCenter || rightBottom => 270.0,
      bottomLeft || bottomCenter || bottomRight => 0.0,
    };
  }

  Offset getArrowOffset({
    required Size actionSize,
    required double arrowSize,
  }) {
    final actionWidth = actionSize.width;
    final actionHeight = actionSize.height;
    final arrowTriangleHeight = arrowSize * cos(45);
    final actionCenteredDx = actionWidth / 2;
    final actionCenteredDy = actionHeight / 2;

    return switch (this) {
      leftTop || leftCenter || leftBottom => Offset(
          -arrowTriangleHeight,
          actionCenteredDy - arrowTriangleHeight,
        ),
      topLeft => Offset(
          arrowSize,
          -arrowTriangleHeight,
        ),
      topCenter => Offset(
          actionCenteredDx - arrowTriangleHeight,
          -arrowTriangleHeight,
        ),
      topRight => Offset(
          actionWidth - arrowSize * 2,
          -arrowTriangleHeight,
        ),
      rightTop || rightCenter || rightBottom => Offset(
          actionWidth - arrowTriangleHeight,
          actionCenteredDy - arrowTriangleHeight,
        ),
      bottomLeft => Offset(
          arrowSize,
          actionHeight - arrowTriangleHeight,
        ),
      bottomCenter => Offset(
          actionCenteredDx - arrowTriangleHeight,
          actionHeight - arrowTriangleHeight,
        ),
      bottomRight => Offset(
          actionWidth - arrowSize * 2,
          actionHeight - arrowTriangleHeight,
        ),
    };
  }
}
