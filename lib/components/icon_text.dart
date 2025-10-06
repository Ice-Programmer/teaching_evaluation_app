import 'package:flutter/material.dart';

class IconText extends StatefulWidget {
  final String text;
  final IconData iconData;
  final double fontSize;
  final double gap;

  const IconText({
    super.key,
    required this.text,
    required this.iconData,
    required this.fontSize,
    required this.gap,
  });

  @override
  State<IconText> createState() => _IconTextState();
}

class _IconTextState extends State<IconText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(widget.iconData, size: widget.fontSize),
        SizedBox(width: widget.gap),
        Text(widget.text),
      ],
    );
  }
}
