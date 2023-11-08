import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'default_custom_text.dart';

class SwitchButtonVisaNumber extends StatefulWidget {
  const SwitchButtonVisaNumber({super.key});

  @override
  State<SwitchButtonVisaNumber> createState() => _SwitchButtonVisaNumberState();
}

class _SwitchButtonVisaNumberState extends State<SwitchButtonVisaNumber> {
  bool isShowVisa = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isShowVisa = !isShowVisa;
        });
        Timer.periodic(const Duration(seconds: 5), (timer) {
          setState(() {
            isShowVisa = !isShowVisa;
          });
        });
      },
      child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: isShowVisa
              ? const DefaultCustomText(
                  text: 'Tab Here & Try Test Visa',
                )
              : const SelectableText('4000056655665556 ')),
    );
  }
}
