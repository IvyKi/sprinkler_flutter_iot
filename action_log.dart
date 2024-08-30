import 'package:flutter/material.dart';

class ActionLogPage extends StatelessWidget {
  const ActionLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Action Page'),
        backgroundColor: Colors.blueAccent[100],
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Action Log Page'),
      ),
    );
  }
}