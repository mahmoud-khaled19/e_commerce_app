import 'package:flutter/material.dart';
import '../../app_constance/values_manager.dart';
import 'default_custom_text.dart';

class DefaultPopMenuWidget extends StatelessWidget {
  const DefaultPopMenuWidget({
    super.key,
    required this.itemOneFunction,
    required this.itemTwoFunction,
    required this.itemOneText,
    required this.itemTwoText,
  });

  final String itemOneText;
  final Function() itemOneFunction;
  final Function() itemTwoFunction;
  final String itemTwoText;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSize.s14,
      child: PopupMenuButton<int>(
        icon:  Icon(Icons.more_vert,color:Colors.red,size: AppSize.s14,),
        itemBuilder: (context) => [
          PopupMenuItem<int>(
            value: 0,
            child: GestureDetector(
              onTap: itemOneFunction,
              child: DefaultCustomText(
                text: itemOneText,
              ),
            ),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: GestureDetector(
              onTap: itemTwoFunction,
              child: DefaultCustomText(
                text: itemTwoText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
