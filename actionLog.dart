import 'package:flutter/material.dart';
import 'main.dart';

class ActionLogPage extends StatelessWidget {
  const ActionLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('액션 로그 페이지'),
        backgroundColor: Colors.blueAccent[100],
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Action Log Page'),
      ),
    );
  }
}