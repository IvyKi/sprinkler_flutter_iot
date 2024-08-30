import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'InitialScreen.dart';
import 'sensorA.dart';
import 'sensorB.dart';
import 'sensorC.dart';
import 'actionLog.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Supabase Flutter',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: InitialScreen(), // InitialScreen Widget(Stateless)
    );
  }
}

class LogPages extends StatefulWidget {
  const LogPages({super.key});

  @override
  _LogPagesState createState() => _LogPagesState();
}

class _LogPagesState extends State<LogPages> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    FirstPage(),
    SecondPage(),
    ThirdPage(),
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
        title: const Text('Log Page'),
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}


