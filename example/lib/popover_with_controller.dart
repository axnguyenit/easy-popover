import 'package:easy_popover/easy_popover.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class PopoverWithController extends StatefulWidget {
  const PopoverWithController({super.key});

  @override
  State<PopoverWithController> createState() => _PopoverWithControllerState();
}

class _PopoverWithControllerState extends State<PopoverWithController> {
  final _popoverController = PopoverController();

  @override
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Block(
      title: 'With Controller',
      child: Center(
        child: Popover(
          context,
          contentWidth: 280,
          controller: _popoverController,
          action: SizedBox(
            height: 40.0,
            width: double.infinity,
            child: FilledButton(
              onPressed: _popoverController.open,
              child: const Text('Open Popover'),
            ),
          ),
          content: Column(
            children: [
              const PopoverContent(),
              OutlinedButton(
                onPressed: _popoverController.close,
                child: const Text('Close Popover'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
