/*
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({super.key});

  @override
  ActionPageState createState() => ActionPageState();
}

class ActionPageState extends State<ActionPage> {
  List<Map<String, bool>> logs = [];

  void _showToast(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SensorSelectionDialog();
      },
    );

    if (result != null) {
      setState(() {
        logs.insert(0, result);  // 새 로그는 리스트의 맨 위에 추가
      });

      final supabase = Supabase.instance.client;
      await supabase.from('action').insert({
        'sensor_a': result['A'] ?? false,
        'sensor_b': result['B'] ?? false,
        'sensor_c': result['C'] ?? false,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Action Page'),
        backgroundColor: Colors.greenAccent[200],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          GestureDetector(
            onTap: () => _showToast(context),
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'RUN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12,),
          const Divider(height: 40, thickness: 2),
          Expanded(
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                return ListTile(
                  title: Text(
                      'Sensor A: ${log['A']} | Sensor B: ${log['B']} | Sensor C: ${log['C']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SensorSelectionDialog extends StatefulWidget {
  const SensorSelectionDialog({super.key});

  @override
  SensorSelectionDialogState createState() => SensorSelectionDialogState();
}

class SensorSelectionDialogState extends State<SensorSelectionDialog> {
  bool _sensorA = false;
  bool _sensorB = false;
  bool _sensorC = false;
  bool _selectAll = false;

  void _toggleSelectAll(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      _sensorA = _selectAll;
      _sensorB = _selectAll;
      _sensorC = _selectAll;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Sensors'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: const Text('A'),
            value: _sensorA,
            onChanged: (bool? value) {
              setState(() {
                _sensorA = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('B'),
            value: _sensorB,
            onChanged: (bool? value) {
              setState(() {
                _sensorB = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('C'),
            value: _sensorC,
            onChanged: (bool? value) {
              setState(() {
                _sensorC = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('ALL'),
            value: _selectAll,
            onChanged: _toggleSelectAll,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop({
              'A': _sensorA,
              'B': _sensorB,
              'C': _sensorC,
            });
          },
          child: const Text('RUN'),
        ),
      ],
    );
  }
}
 */
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({super.key});

  @override
  ActionPageState createState() => ActionPageState();
}

class ActionPageState extends State<ActionPage> {
  List<Map<String, bool>> logs = [];

  void _showToast(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SensorSelectionDialog();
      },
    );

    if (result != null) {
      setState(() {
        logs.insert(0, result); // 새 로그는 리스트의 맨 위에 추가
      });
      DateTime now = DateTime.now();

      final supabase = Supabase.instance.client;
      await supabase.from('action').insert({

        'sensor_a': result['A'] ?? false,
        'sensor_b': result['B'] ?? false,
        'sensor_c': result['C'] ?? false,
        'time' : now
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Action Page'),
        backgroundColor: Colors.greenAccent[200],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          GestureDetector(
            onTap: () => _showToast(context),
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'RUN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 40, thickness: 2),
          Expanded(
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sensor A: ${log['A']} | Sensor B: ${log['B']} | Sensor C: ${log['C']} | Time: ${DateTime.now()}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {

                                  final supabase = Supabase.instance.client;
                                      // Remove from Supabase
                                  await supabase
                                    .from('action')
                                      .delete();

                                  setState(() {
                                    logs.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SensorSelectionDialog extends StatefulWidget {
  const SensorSelectionDialog({super.key});

  @override
  SensorSelectionDialogState createState() => SensorSelectionDialogState();
}

class SensorSelectionDialogState extends State<SensorSelectionDialog> {
  bool _sensorA = false;
  bool _sensorB = false;
  bool _sensorC = false;
  bool _selectAll = false;

  void _toggleSelectAll(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      _sensorA = _selectAll;
      _sensorB = _selectAll;
      _sensorC = _selectAll;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Sensors'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: const Text('A'),
            value: _sensorA,
            onChanged: (bool? value) {
              setState(() {
                _sensorA = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('B'),
            value: _sensorB,
            onChanged: (bool? value) {
              setState(() {
                _sensorB = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('C'),
            value: _sensorC,
            onChanged: (bool? value) {
              setState(() {
                _sensorC = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('ALL'),
            value: _selectAll,
            onChanged: _toggleSelectAll,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop({
              'A': _sensorA,
              'B': _sensorB,
              'C': _sensorC,
            });
          },
          child: const Text('RUN'),
        ),
      ],
    );
  }
}

