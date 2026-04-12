import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Silhouette extends StatefulWidget {
  const Silhouette({super.key});

  @override
  State<Silhouette> createState() => _SilhouetteState();
}

class _SilhouetteState extends State<Silhouette> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
          Text(
              "Define your Silhouette"
          )
      ),
    );
  }
}
