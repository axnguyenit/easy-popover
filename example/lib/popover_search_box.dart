import 'package:easy_popover/easy_popover.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

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
