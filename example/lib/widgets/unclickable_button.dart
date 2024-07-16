import 'package:flutter/material.dart';

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
