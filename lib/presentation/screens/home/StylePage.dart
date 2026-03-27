import 'package:flutter/material.dart';

class StylePage extends StatelessWidget {
  const StylePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: const Center(
        child: Text(
          "Style Screen",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}