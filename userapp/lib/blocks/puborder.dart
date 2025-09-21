import 'package:flutter/material.dart';

class Puborder extends StatelessWidget {
  const Puborder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Public Order")),
      body: const Center(
        child: Text(
          "This is the Public Order Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}