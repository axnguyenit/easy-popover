import 'package:easy_popover/easy_popover.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PopoverExampleApp());
}

class PopoverExampleApp extends StatefulWidget {
  const PopoverExampleApp({super.key});

  @override
  State<PopoverExampleApp> createState() => _PopoverExampleAppState();
}

class _PopoverExampleAppState extends State<PopoverExampleApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy Popover Example',
      home: PopoverOverlay(
        builder: (context) => const PopoverExampleScreen(),
      ),
    );
  }
}

// ════════════════════════════════════════════
// PopoverExampleScreen
// ════════════════════════════════════════════
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
        padding: const EdgeInsets.all(16.0).copyWith(top: 100.0, bottom: 500.0),
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

// ════════════════════════════════════════════
// BasicPopover
// ════════════════════════════════════════════
class BasicPopover extends StatelessWidget {
  const BasicPopover({super.key});

  @override
  Widget build(BuildContext context) {
    return Block(
      title: 'Basic',
      child: Center(
        child: Popover(
          context,
          contentWidth: 1000,
          action: const UnClickableButton(
            title: 'Open Popover',
          ),
          content: const PopoverContent(),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════
// PopoverWithController
// ════════════════════════════════════════════
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

// ════════════════════════════════════════════
// PopoverScrollEnabled
// ════════════════════════════════════════════
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

// ════════════════════════════════════════════
// CustomizedPopover
// ════════════════════════════════════════════
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

// ════════════════════════════════════════════
// PopoverWithAlignment
// ════════════════════════════════════════════
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

// ════════════════════════════════════════════

class User {
  final String name;

  User({
    required this.name,
  });
}

final List<User> _users = [
  User(name: 'Kha'),
  User(name: 'Alex'),
  User(name: 'John'),
  User(name: 'Grace'),
  User(name: 'Miracle'),
];

// ════════════════════════════════════════════
// PopoverSearchBox
// ════════════════════════════════════════════
class PopoverSearchBox extends StatefulWidget {
  const PopoverSearchBox({super.key});

  @override
  State<PopoverSearchBox> createState() => _PopoverSearchBoxState();
}

class _PopoverSearchBoxState extends State<PopoverSearchBox> {
  late final FocusNode _focusNode;
  final _popoverController = PopoverController();
  final _textController = TextEditingController();
  List<User> _filteredUsers = _users;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(_focusListener);
    super.initState();
  }

  void _focusListener() {
    if (_focusNode.hasFocus) {
      _popoverController.open();
    }
  }

  @override
  void dispose() {
    _popoverController.dispose();
    _textController.dispose();
    _focusNode.removeListener(_focusListener);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Block(
      title: 'Search Box',
      child: Center(
        child: Popover(
          context,
          controller: _popoverController,
          applyActionWidth: true,
          scrollEnabled: true,
          hideArrow: true,
          action: SizedBox(
            height: 40.0,
            width: double.infinity,
            child: TextField(
              focusNode: _focusNode,
              controller: _textController,
              onChanged: (value) {
                setState(() {
                  _filteredUsers = _users
                      .where(
                        (user) => user.name
                            .toLowerCase()
                            .contains(value.toLowerCase()),
                      )
                      .toList();
                });
              },
            ),
          ),
          content: Material(
            child: _filteredUsers.isEmpty
                ? const SizedBox(
                    height: 140,
                    child: Center(
                      child: Text('No data'),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredUsers[index].name),
                        onTap: () {
                          _textController.text = _filteredUsers[index].name;
                          _focusNode.unfocus();
                          _popoverController.close();
                        },
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════
// Widgets
// ════════════════════════════════════════════
class Block extends StatelessWidget {
  final Widget child;
  final String title;

  const Block({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(width: 1.0, color: Colors.grey.withOpacity(.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24.0),
            child,
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════

class PopoverContent extends StatelessWidget {
  const PopoverContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is Lorem Ipsum?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s''',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: const Color(0xFF637381)),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════

class UnClickableButton extends StatelessWidget {
  final String title;
  final double? width;

  const UnClickableButton({
    super.key,
    required this.title,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(100.0),
      ),
      constraints: BoxConstraints(
        minWidth: width ?? 0.0,
        maxWidth: width ?? double.infinity,
        minHeight: 40.0,
        maxHeight: 40.0,
      ),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
