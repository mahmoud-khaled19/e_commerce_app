import 'package:flutter/material.dart';

import '../../app_constance/values_manager.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
    this.hint,
    required this.controller,
    this.validate,
    this.onTap,
    this.onSubmitted,
    this.suffixIcon,
    this.suffixFunction,
    this.isSecure = false,
    this.enabled = true,
    this.textType = TextInputType.emailAddress,
    this.keyboardAction = TextInputAction.next,
  });

  final TextEditingController controller;
  final String? Function(String? val)? validate;
  final IconData? suffixIcon;
  final Function()? suffixFunction;
  final Function()? onTap;
  final Function()? onSubmitted;
  final bool isSecure, enabled;
  final TextInputType textType;
  final String? hint;
  final TextInputAction? keyboardAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppSize.s10,
        ),
        GestureDetector(
          onTap: onTap,
          child: TextFormField(
            enabled: enabled,
            textInputAction: keyboardAction,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onEditingComplete: onSubmitted,
            style: Theme.of(context).textTheme.titleMedium,
            obscureText: isSecure,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: textType,
            controller: controller,
            validator: validate,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: suffixFunction,
                  child: Icon(
                    suffixIcon,
                  )),
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.titleSmall,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).splashColor),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
