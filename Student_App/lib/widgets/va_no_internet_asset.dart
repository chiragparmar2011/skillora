import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VANoInternetAsset extends StatelessWidget {
  const VANoInternetAsset({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/no_internet.json',
        width: 170,
        height: 120,
        fit: BoxFit.fill,
      ),
    );
  }
}
