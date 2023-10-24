import 'package:flutter/material.dart';
import 'default_custom_text.dart';

class DefaultListTile extends StatelessWidget {
  const DefaultListTile(
      {super.key,
      required this.title,
      this.subTitle,
      this.icon,
      required this.function,
      this.leadingWidget});

  final String title;
  final Widget? subTitle;
  final Widget? leadingWidget;
  final IconData? icon;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: ListTile(
        style: ListTileStyle.list,
        selectedColor: Colors.yellow,
        title: DefaultCustomText(
          alignment: Alignment.centerLeft,
          text: title,
        ),
        leading: leadingWidget,
        onTap: function,
        trailing: Icon(
          icon,
          color: Theme.of(context).splashColor,
        ),
        subtitle: subTitle,
      ),
    );
  }
}
