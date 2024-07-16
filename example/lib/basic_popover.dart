import 'package:easy_popover/easy_popover.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class BasicPopover extends StatelessWidget {
  const BasicPopover({super.key});

  @override
  Widget build(BuildContext context) {
    return Block(
      title: 'Basic',
      child: Center(
        child: Popover(
          context,
          contentWidth: 280,
          action: const UnClickableButton(
            title: 'Open Popover',
          ),
          content: const PopoverContent(),
        ),
      ),
    );
  }
}
