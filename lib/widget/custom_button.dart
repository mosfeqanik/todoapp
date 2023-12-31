import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? accentColor;
  final Color? mainColor;
  final String? text;
  final void Function()? onpress;
  const CustomButton(
      {super.key, this.accentColor, this.text, this.mainColor, this.onpress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: accentColor!,
            ),
            color: mainColor,
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            text!.toUpperCase(),
            style: TextStyle(fontFamily: 'Poppins', color: accentColor),
          ),
        ),
      ),
    );
  }
}
