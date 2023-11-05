import 'package:flutter/material.dart';
import '../../app_constance/values_manager.dart';
import 'default_custom_text.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.text,
    required this.function,
    required this.context,
    this.width,
    this.color,
  });
  final Function() function;
  final String text;
  final double? width;
  final Color? color;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? AppSize.s120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s10),
        color: color ?? Theme.of(context).splashColor,
      ),
      child: TextButton(
        onPressed: function,
        child: DefaultCustomText(
          alignment: Alignment.center,
          text: text,
          color: Colors.white,
          fontSize: AppSize.s16,
        ),
      ),
    );
  }
}
