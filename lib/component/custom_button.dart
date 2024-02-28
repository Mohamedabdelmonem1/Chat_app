import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text, required this.ontap});

  final String text;
  Function() ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            )),
        height: 50,
        width: double.infinity,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
            color: Color(0xff284461),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
