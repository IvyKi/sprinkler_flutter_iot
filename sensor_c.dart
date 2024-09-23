import 'package:flutter/material.dart';
import 'main.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  ThirdPageState createState() => ThirdPageState();
}

class ThirdPageState extends State<ThirdPage> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> data = [];

  Future<void> fetchData() async {
    final response = await supabase
        .from('sprinkler_get3')
        .select('day, time, temperature, humidity, trigger, id');

    setState(() {
      data = List<Map<String, dynamic>>.from(response as List).reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> _deleteItem(int index) async {
    try {
      // Supabase에서 해당 항목을 삭제
      final id = data[index]['id'];
      await supabase.from('sprinkler_get3').delete().eq('id', id);

      // UI에서도 삭제
      setState(() {
        data.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item deleted successfully')),
      );
    } catch (e) {
      // 오류 발생 시 에러 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete item')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        controller: _scrollController,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final isTriggered = data[index]['trigger'] == true;

          return Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isTriggered ? Colors.blueAccent[100]?.withOpacity(0.5) : Colors.white.withOpacity(1.0),
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
                    Text('Day: ${data[index]['day']}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Time: ${data[index]['time']}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Temp: ${data[index]['temperature']}°C',
                        style: const TextStyle(fontSize: 16)),
                    Text('Humidity: ${data[index]['humidity']}%',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.black),
                  onPressed: () => _deleteItem(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
