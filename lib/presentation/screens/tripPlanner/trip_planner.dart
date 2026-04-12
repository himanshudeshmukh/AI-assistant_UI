import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TripPlanner extends StatefulWidget {
  const TripPlanner({super.key});

  @override
  State<TripPlanner> createState() => _TripPlannerState();
}

class _TripPlannerState extends State<TripPlanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Text("Trip Planner"),
      ),
    );
  }
}
