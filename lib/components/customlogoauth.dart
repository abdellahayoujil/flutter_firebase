import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLogoAuth extends StatelessWidget {
  const CustomLogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          alignment: Alignment.center,
          width: 120,
          height: 120,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(70)),
          child: Lottie.asset(
            "images/notelottie.json",
            width: 100,
          )),
    );
  }
}
