import 'package:easy_popover/easy_popover.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class PopoverScrollEnabled extends StatelessWidget {
  const PopoverScrollEnabled({super.key});

  @override
  Widget build(BuildContext context) {
    return Block(
      title: 'Scroll Enabled',
      child: Center(
        child: Popover(
          context,
          contentWidth: 280,
          scrollEnabled: true,
          action: const UnClickableButton(
            title: 'Open Popover',
          ),
          content: const PopoverContent(),
        ),
      ),
    );
  }
}
