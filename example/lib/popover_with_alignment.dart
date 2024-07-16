import 'package:easy_popover/easy_popover.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class PopoverWithAlignment extends StatefulWidget {
  const PopoverWithAlignment({super.key});

  @override
  State<PopoverWithAlignment> createState() => _PopoverWithAlignmentState();
}

class _PopoverWithAlignmentState extends State<PopoverWithAlignment> {
  final _popoverController = PopoverController();
  PopoverAlignment _alignment = PopoverAlignment.values.first;

  @override
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Block(
      title: 'With Alignment',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Popover(
              context,
              contentWidth: 280,
              alignment: _alignment,
              action: const UnClickableButton(
                title: 'Open Popover',
              ),
              content: const PopoverContent(),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: 240.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: PopoverAlignment.values.map(
                  (align) {
                    return ListTile(
                      dense: true,
                      horizontalTitleGap: 8.0,
                      leading: Radio<PopoverAlignment>(
                        groupValue: _alignment,
                        value: align,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _alignment = value;
                          });
                        },
                      ),
                      title: Text(align.name),
                      onTap: () {
                        if (_alignment == align) return;
                        setState(() {
                          _alignment = align;
                        });
                      },
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
