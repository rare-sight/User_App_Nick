import 'package:flutter/material.dart';

class RoadPage extends StatelessWidget {
  const RoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Road & Transport")),
      body: const Center(
        child: Text(
          "This is the Road & Transport Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
