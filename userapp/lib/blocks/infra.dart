import 'package:flutter/material.dart ';

class Infra extends StatelessWidget {
  const Infra({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Infrastructure")),
      body: const Center(
        child: Text(
          "This is the Infrastructure Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}