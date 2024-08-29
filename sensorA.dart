import "package:flutter/material.dart";
import 'main.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await supabase
        .from('sprinkler_get')
        .select('day, time, temperature, humidity');


    return List<Map<String, dynamic>>.from(response as List);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Data Found'));
        } else {
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Day: ${data[index]['day']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Time: ${data[index]['time']}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Temp: ${data[index]['temperature']}°C', style: const TextStyle(fontSize: 16)),
                        Text('Humidity: ${data[index]['humidity']}%', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}