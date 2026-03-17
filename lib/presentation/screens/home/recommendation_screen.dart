import 'package:flutter/material.dart';

class GenerateScreen extends StatelessWidget {
  const GenerateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          "Generate Outfit Screen",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}