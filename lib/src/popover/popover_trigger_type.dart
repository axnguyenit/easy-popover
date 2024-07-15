part of 'popover.dart';

enum PopoverTriggerType {
  click,
  hover;

  bool get clicked => this == click;

  bool get hovered => this == hover;
}
