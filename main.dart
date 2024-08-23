import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://yscyyvxduwdfjldjnwus.supabase.co',  // API URL 수정
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
        '.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlzY3l5dnhkdXdkZmpsZGpud3VzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjIwNjYxMTQsImV4cCI6MjAzNzY0MjExNH0.22vV2RlrW9TU92Y79SzuOQKX8v8IISBcaHePht-43Q4',  // anonKey 수정
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Supabase Flutter',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // 각 페이지를 나타내는 위젯들
  static List<Widget> _widgetOptions = <Widget>[
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(),
    const ActionLogPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sprinkler App'),
        backgroundColor: Colors.blueAccent[100],
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            label: '1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: '2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            label: '3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Log',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

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

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await supabase
        .from('sprinkler_get2')
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

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await supabase
        .from('sprinkler_get3')
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

class ActionLogPage extends StatelessWidget {
  const ActionLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Action Log Page'),
    );
  }
}

