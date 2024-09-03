import 'package:flutter/material.dart';
import 'main.dart';
import 'action.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sprinkler App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              const Text(
                'Collaborator. 기나혜, 김하연, 최태훈\n',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),
              const Text(
                'Project.',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12),
              const Text(
                '\t 스프링쿨러 로봇시스템 제어 및 관찰용 어플리케이션 \n'
                    '\t The Application for controlling and observing the Sprinkler Robot System'
                    '\n\n\n\t 2024 임베디드시스템 경진대회 본선 출품작',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 24),
              const Divider(color: Colors.white, thickness: 2),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LogPages()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(32),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'LOG',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ActionPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(32),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'ACTION',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}