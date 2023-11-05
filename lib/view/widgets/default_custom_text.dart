import 'package:flutter/material.dart';

class DefaultCustomText extends StatelessWidget {
  const DefaultCustomText({
    super.key,
    required this.text,
    this.maxLines,
    this.fontSize,
    this.alignment,
    this.color,
    this.fontWeight,
    this.style,
  });
  final String text;
  final int? maxLines;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Alignment? alignment;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: alignment ?? Alignment.center,
        child: Text(
          text,
          style: style ??
              Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color, fontSize: fontSize, fontWeight: fontWeight),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
