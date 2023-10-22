import 'package:flutter/material.dart';

import 'default_custom_text.dart';

class DefaultListTile extends StatelessWidget {
  const DefaultListTile(
      {Key? key,
      required this.title,
      this.subTitle,
      this.trailingWidget,
      required this.function,
       this.leadingWidget})
      : super(key: key);
  final String title;
  final Widget? subTitle;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: ListTile(
        selectedColor: Colors.yellow,
        title: DefaultCustomText(
            text: title,
          ),
        leading: leadingWidget,
        onTap: function,
        trailing: trailingWidget,
        subtitle: subTitle,
      ),
    );
  }
}
