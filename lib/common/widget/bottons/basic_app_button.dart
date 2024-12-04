import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  const BasicAppButton(
      {super.key, required this.onPressed, required this.content, this.height});
  final VoidCallback onPressed;
  final Widget content;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: content,
      style:
          ElevatedButton.styleFrom(minimumSize: Size.fromHeight(height ?? 55)),
    );
  }
}
