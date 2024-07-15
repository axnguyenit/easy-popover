import 'package:flutter/material.dart';

import 'package:easy_popover/easy_popover.dart';

import 'popover_content.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PopoverAlignment _alignment = PopoverAlignment.values.first;
  final _popoverController = PopoverController();

  @override
  void dispose() {
    _popoverController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Easy Popover example'),
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        /// Basic Popover
                        Popover(
                          context,
                          contentWidth: 280,
                          action: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 120.0,
                              maxWidth: 120.0,
                              minHeight: 36.0,
                              maxHeight: 36.0,
                            ),
                            child: const Center(
                              child: Text('Open Popover'),
                            ),
                          ),
                          content: const PopoverContent(),
                        ),

                        /// Hover Popover - Not working with Mobile devices
                        const SizedBox(height: 40),
                        Popover(
                          context,
                          contentWidth: 280,
                          triggerType: PopoverTriggerType.hover,
                          action: const Text('Hover Popover'),
                          content: const PopoverContent(),
                        ),

                        /// Popover with controller
                        const SizedBox(height: 40),
                        Popover(
                          context,
                          controller: _popoverController,
                          contentWidth: 280,
                          action: FilledButton(
                            onPressed: _popoverController.open,
                            child: const Text('Open Popover'),
                          ),
                          content: const PopoverContent(),
                        ),

                        /// Popover with alignment
                        const SizedBox(height: 40),
                        Popover(
                          context,
                          contentWidth: 280,
                          alignment: _alignment,
                          action: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 140.0,
                              maxWidth: 140.0,
                              minHeight: 36.0,
                              maxHeight: 36.0,
                            ),
                            child: const Center(
                              child: Text('Open Customized'),
                            ),
                          ),
                          content: const PopoverContent(),
                        ),
                        const SizedBox(height: 24.0),
                        SizedBox(
                          width: 180.0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: PopoverAlignment.values.map((align) {
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
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
