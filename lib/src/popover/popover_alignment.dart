part of 'popover.dart';

/// Defines the alignment of the Popover relative to the action widget.
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

  /// Calculates the offset for the content based on the action widget size,
  /// content size, and spacing.
  ///
  /// - [actionSize]: The size of the action widget.
  /// - [contentSize]: The size of the content widget.
  /// - [spacing]: The spacing between the popover and the action widget.
  ///
  /// Returns the offset for positioning the content.
  Offset getContentOffset({
    required Size actionSize,
    required Size contentSize,
    required double spacing,
  }) {
    return switch (this) {
      leftTop => Offset(
          -contentSize.width - spacing,
          0,
        ),
      leftCenter => Offset(
          -contentSize.width - spacing,
          (actionSize.height / 2) - contentSize.height / 2,
        ),
      leftBottom => Offset(
          -contentSize.width - spacing,
          -contentSize.height + actionSize.height,
        ),
      topLeft => Offset(
          0,
          -contentSize.height - spacing,
        ),
      topCenter => Offset(
          (actionSize.width / 2) - contentSize.width / 2,
          -contentSize.height - spacing,
        ),
      topRight => Offset(
          actionSize.width - contentSize.width,
          -contentSize.height - spacing,
        ),
      rightTop => Offset(
          actionSize.width + spacing,
          0,
        ),
      rightCenter => Offset(
          actionSize.width + spacing,
          (actionSize.height / 2) - contentSize.height / 2,
        ),
      rightBottom => Offset(
          actionSize.width + spacing,
          -contentSize.height + actionSize.height,
        ),
      bottomLeft => Offset(
          0,
          actionSize.height + spacing,
        ),
      bottomCenter => Offset(
          (actionSize.width / 2) - contentSize.width / 2,
          actionSize.height + spacing,
        ),
      bottomRight => Offset(
          actionSize.width - contentSize.width,
          actionSize.height + spacing,
        ),
    };
  }

  /// Determines the best position for the Popover based on available space
  /// around action widget.
  ///
  /// - [contentSize]: The size of the content widget.
  /// - [leftSpacing]: The space available on the left side of widget action.
  /// - [topSpacing]: The space available on the top side of widget action.
  /// - [rightSpacing]: The space available on the right side of widget action.
  /// - [bottomSpacing]: The space available on the bottom side of widget action
  ///
  /// Returns the best [PopoverAlignment] for the Popover.
  PopoverAlignment findBestPopoverPosition({
    required Size contentSize,
    required double leftSpacing,
    required double topSpacing,
    required double rightSpacing,
    required double bottomSpacing,
  }) {
    final contentWidth = contentSize.width;
    final contentHeight = contentSize.height;
    final hasSpaceOnLeft = leftSpacing > contentWidth;
    final hasSpaceOnTop = topSpacing > contentHeight;
    final hasSpaceOnRight = rightSpacing > contentWidth;
    final hasSpaceOnBottom = bottomSpacing > contentHeight;

    switch (this) {
      case leftTop:
        if (!hasSpaceOnLeft && !hasSpaceOnRight) {
          return bottomCenter.findBestPopoverPosition(
            contentSize: contentSize,
            leftSpacing: leftSpacing,
            topSpacing: topSpacing,
            rightSpacing: rightSpacing,
            bottomSpacing: bottomSpacing,
          );
        }

        if (hasSpaceOnLeft) {
          if (hasSpaceOnBottom) return this;
          return leftBottom;
        }

        if (hasSpaceOnBottom) return rightTop;
        return rightBottom;
      case leftCenter:
        if (!hasSpaceOnLeft && !hasSpaceOnRight) {
          return bottomCenter.findBestPopoverPosition(
            contentSize: contentSize,
            leftSpacing: leftSpacing,
            topSpacing: topSpacing,
            rightSpacing: rightSpacing,
            bottomSpacing: bottomSpacing,
          );
        }

        if (hasSpaceOnLeft) return this;
        return rightCenter;
      case leftBottom:
        if (!hasSpaceOnLeft && !hasSpaceOnRight) {
          return bottomCenter.findBestPopoverPosition(
            contentSize: contentSize,
            leftSpacing: leftSpacing,
            topSpacing: topSpacing,
            rightSpacing: rightSpacing,
            bottomSpacing: bottomSpacing,
          );
        }

        if (hasSpaceOnLeft) {
          if (hasSpaceOnTop) return this;
          return leftTop;
        }

        if (hasSpaceOnTop) return rightBottom;
        return rightTop;
      case topLeft:
        if (hasSpaceOnTop) return this;
        return bottomLeft;
      case topCenter:
        if (hasSpaceOnTop) return this;
        return bottomCenter;
      case topRight:
        if (hasSpaceOnTop) return this;
        return bottomRight;
      case rightTop:
        if (!hasSpaceOnLeft && !hasSpaceOnRight) {
          return bottomCenter.findBestPopoverPosition(
            contentSize: contentSize,
            leftSpacing: leftSpacing,
            topSpacing: topSpacing,
            rightSpacing: rightSpacing,
            bottomSpacing: bottomSpacing,
          );
        }

        if (hasSpaceOnRight) {
          if (hasSpaceOnBottom) return this;
          return rightBottom;
        }

        if (hasSpaceOnBottom) return leftTop;
        return leftBottom;
      case rightCenter:
        if (!hasSpaceOnLeft && !hasSpaceOnRight) {
          return bottomCenter.findBestPopoverPosition(
            contentSize: contentSize,
            leftSpacing: leftSpacing,
            topSpacing: topSpacing,
            rightSpacing: rightSpacing,
            bottomSpacing: bottomSpacing,
          );
        }

        if (hasSpaceOnRight) return this;
        return leftCenter;
      case rightBottom:
        if (!hasSpaceOnLeft && !hasSpaceOnRight) {
          return bottomCenter.findBestPopoverPosition(
            contentSize: contentSize,
            leftSpacing: leftSpacing,
            topSpacing: topSpacing,
            rightSpacing: rightSpacing,
            bottomSpacing: bottomSpacing,
          );
        }

        if (hasSpaceOnRight) {
          if (hasSpaceOnTop) return this;
          return rightTop;
        }

        if (hasSpaceOnTop) return leftBottom;
        return leftTop;
      case bottomLeft:
        if (hasSpaceOnBottom) return this;
        return topLeft;
      case bottomCenter:
        if (hasSpaceOnBottom) return this;
        return topCenter;
      case bottomRight:
        if (hasSpaceOnBottom) return this;
        return topRight;
    }
  }

  /// Provides the alignment for scaling the content.
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

  /// Provides the alignment for scaling the arrow.
  Alignment get arrowScaleAlignment {
    return switch (this) {
      leftTop || leftCenter || leftBottom => Alignment.centerLeft,
      topLeft || topCenter || topRight => Alignment.topCenter,
      rightTop || rightCenter || rightBottom => Alignment.centerRight,
      bottomLeft || bottomCenter || bottomRight => Alignment.bottomCenter,
    };
  }

  /// Provides the angle for rotating the arrow.
  double get arrowAngle {
    return switch (this) {
      leftTop || leftCenter || leftBottom => 90.0,
      topLeft || topCenter || topRight => 180.0,
      rightTop || rightCenter || rightBottom => 270.0,
      bottomLeft || bottomCenter || bottomRight => 0.0,
    };
  }

  /// Calculates the offset for the arrow based on the action widget size,
  /// arrow size, and spacing.
  ///
  /// - [actionSize]: The size of the action widget.
  /// - [arrowSize]: The size of the arrow.
  /// - [spacing]: The spacing between the popover and the action widget.
  ///
  /// Returns the offset for positioning the arrow.
  Offset getArrowOffset({
    required Size actionSize,
    required double arrowSize,
    required double spacing,
  }) {
    final actionWidth = actionSize.width;
    final actionHeight = actionSize.height;
    final arrowTriangleHeight = arrowSize * cos(45);
    final actionCenteredDx = actionWidth / 2;
    final actionCenteredDy = actionHeight / 2;

    return switch (this) {
      leftTop || leftCenter || leftBottom => Offset(
          -arrowTriangleHeight - spacing,
          actionCenteredDy - arrowTriangleHeight,
        ),
      topLeft => Offset(
          arrowSize,
          -arrowTriangleHeight - spacing,
        ),
      topCenter => Offset(
          actionCenteredDx - arrowTriangleHeight,
          -arrowTriangleHeight - spacing,
        ),
      topRight => Offset(
          actionWidth - arrowSize * 2,
          -arrowTriangleHeight - spacing,
        ),
      rightTop || rightCenter || rightBottom => Offset(
          actionWidth - arrowTriangleHeight + spacing,
          actionCenteredDy - arrowTriangleHeight,
        ),
      bottomLeft => Offset(
          arrowSize,
          actionHeight - arrowTriangleHeight + spacing,
        ),
      bottomCenter => Offset(
          actionCenteredDx - arrowTriangleHeight,
          actionHeight - arrowTriangleHeight + spacing,
        ),
      bottomRight => Offset(
          actionWidth - arrowSize * 2,
          actionHeight - arrowTriangleHeight + spacing,
        ),
    };
  }
}
