import 'package:easy_popover/easy_popover.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class CustomizedPopover extends StatelessWidget {
  const CustomizedPopover({super.key});

  @override
  Widget build(BuildContext context) {
    return Block(
      title: 'Customized',
      child: Center(
        child: Column(
          children: [
            Popover(
              context,
              contentWidth: 280,
              backgroundColor: Colors.lightGreen,
              overlayColor: Colors.grey.withOpacity(.5),
              boxShadow: const [],
              action: const UnClickableButton(
                title: 'Custom Color',
              ),
              content: const PopoverContent(),
            ),
            const SizedBox(height: 20),
            Popover(
              context,
              hideArrow: true,
              action: const UnClickableButton(
                title: 'Hide Arrow',
              ),
              content: const PopoverContent(),
            ),
            const SizedBox(height: 20),
            Popover(
              context,
              applyActionWidth: true,
              spacing: 12,
              action: const UnClickableButton(
                title: 'Using Action Width + Spacing',
              ),
              content: const PopoverContent(),
            ),
          ],
        ),
      ),
    );
  }
}
