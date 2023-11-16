import 'dart:async';
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
        Timer(const Duration(seconds: 5), () {
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
            : const Column(
                children: [
                  DefaultCustomText(
                    text: 'Copy This Number',
                  ),
                  SelectableText('4000056655665556'),
                ],
              ),
      ),
    );
  }
}
