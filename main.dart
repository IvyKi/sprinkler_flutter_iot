import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: '[https://yscyyvxduwdfjldjnwus.supabase.co]',
    anonKey: '[eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
        '.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlzY3l5dnhkdXdkZmpsZGpud3VzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjIwNjYxMTQsImV4cCI6MjAzNzY0MjExNH0.22vV2RlrW9TU92Y79SzuOQKX8v8IISBcaHePht-43Q4]',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sprinkler Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
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
    FirstPage(),
    SecondPage(),
    ThirdPage(),
    ActionLogPage(),
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

// FirstPage에 리스트 추가
class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  // 더미 데이터 생성
  final List<Map<String, String>> data = const [
    {
      'day': 'Monday',
      'time': '08:00 AM',
      'temperature': '20°C',
      'humidity': '60%'
    },
    {
      'day': 'Tuesday',
      'time': '09:00 AM',
      'temperature': '22°C',
      'humidity': '65%'
    },
    {
      'day': 'Wednesday',
      'time': '10:00 AM',
      'temperature': '23°C',
      'humidity': '55%'
    },
    {
      'day': 'Thursday',
      'time': '11:00 AM',
      'temperature': '24°C',
      'humidity': '50%'
    },
    {
      'day': 'Friday',
      'time': '12:00 PM',
      'temperature': '25°C',
      'humidity': '45%'
    },
    {
      'day': 'Friday',
      'time': '12:00 PM',
      'temperature': '25°C',
      'humidity': '45%'
    },
    {
      'day': 'Friday',
      'time': '12:00 PM',
      'temperature': '25°C',
      'humidity': '45%'
    },
    {
      'day': 'Saturday',
      'time': '08:00 AM',
      'temperature': '20°C',
      'humidity': '60%'
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                offset: const Offset(0, 3), // changes position of shadow
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
                  Text('Temp: ${data[index]['temperature']}', style: const TextStyle(fontSize: 16)),
                  Text('Humidity: ${data[index]['humidity']}', style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Second Page'),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Third Page'),
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

