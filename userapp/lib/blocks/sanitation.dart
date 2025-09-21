import 'package:flutter/material.dart';

class Sanitation extends StatelessWidget {
  const Sanitation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sanitation")),
      body: const Center(
        child: Text(
          "This is the Sanitation Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}