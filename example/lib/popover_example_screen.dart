import 'package:flutter/material.dart';

import 'basic_popover.dart';
import 'customized_popover.dart';
import 'popover_scroll_enabled.dart';
import 'popover_search_box.dart';
import 'popover_with_alignment.dart';
import 'popover_with_controller.dart';

class PopoverExampleScreen extends StatefulWidget {
  const PopoverExampleScreen({super.key});

  @override
  State<PopoverExampleScreen> createState() => _PopoverExampleScreenState();
}

class _PopoverExampleScreenState extends State<PopoverExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Popover Example'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0).copyWith(bottom: 500.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 1056,
              maxWidth: 1056,
            ),
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const spacing = 24.0;
                  final width = constraints.maxWidth;

                  return Flex(
                    direction: width < 900 ? Axis.vertical : Axis.horizontal,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width < 900 ? width : width * 0.5 - spacing * 2,
                        child: const Column(
                          children: [
                            BasicPopover(),
                            SizedBox(
                              height: spacing,
                              width: spacing,
                            ),
                            PopoverWithController(),
                            SizedBox(
                              height: spacing,
                              width: spacing,
                            ),
                            PopoverScrollEnabled(),
                            SizedBox(
                              height: spacing,
                              width: spacing,
                            ),
                            CustomizedPopover(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: spacing,
                        width: spacing,
                      ),
                      SizedBox(
                        width: width < 900 ? width : width * 0.5 - spacing * 2,
                        child: const Column(
                          children: [
                            PopoverWithAlignment(),
                            SizedBox(
                              height: spacing,
                              width: spacing,
                            ),
                            PopoverSearchBox(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
