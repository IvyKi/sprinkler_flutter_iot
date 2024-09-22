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
/*
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



class ActionPage extends StatefulWidget {
  const ActionPage({super.key});

  @override
  ActionPageState createState() => ActionPageState();
}

class ActionPageState extends State<ActionPage> {
  List<Map<String, dynamic>> logs = [];
  List<Map<String, dynamic>> data = [];



  void _showToast(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SensorSelectionDialog();
      },
    );

    if (result != null) {
      DateTime originalTime = result['time'];
      String formattedTime = '${originalTime.year}-${originalTime.month.toString().padLeft(2, '0')}-${originalTime.day.toString().padLeft(2, '0')} '
          '${originalTime.hour.toString().padLeft(2, '0')}:${originalTime.minute.toString().padLeft(2, '0')}:${originalTime.second.toString().padLeft(2, '0')}';

      setState(() {
        logs.insert(0, result); // Add the new log to the top of the list
      });

      try {
        final supabase = Supabase.instance.client;
        final response = await supabase.from('action').insert({
          'sensor_a': result['A'] ?? false,
          'sensor_b': result['B'] ?? false,
          'sensor_c': result['C'] ?? false,
          'time': formattedTime.toString(),
        });

        // Check if there was an error in the response
        if (response.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response.error!.message}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data sent successfully to Supabase!')),
          );
        }
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Error: $e')),
        // );
      }
    }
  }

  Future<void> fetchData() async {
    final response = await Supabase.instance.client
        .from('action')
        .select('sensor_a, sensor_b, sensor_c, time');

    setState(() {
      data = List<Map<String, dynamic>>.from(response as List).reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
                color: Colors.redAccent,
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
              itemCount: data.length,
              itemBuilder: (context, index) {

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
                            'A: ${data[index]['sensor_a']} | B: ${data[index]['sensor_b']} | C: ${data[index]['sensor_c']} | Time: ${data[index]['time']}',
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
                                  setState(() {
                                    data.removeAt(index);
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
  DateTime _time = DateTime.now();

  void _toggleSelectAll(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      _sensorA = _selectAll;
      _sensorB = _selectAll;
      _sensorC = _selectAll;
      _time = _time;
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
              'time': _time,
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
  List<Map<String, dynamic>> logs = [];
  List<Map<String, dynamic>> data = [];

  void _showToast(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SensorSelectionDialog();
      },
    );

    if (result != null) {
      DateTime originalTime = result['time'];
      String formattedTime =
          '${originalTime.year}-${originalTime.month.toString().padLeft(2, '0')}-${originalTime.day.toString().padLeft(2, '0')} '
          '${originalTime.hour.toString().padLeft(2, '0')}:${originalTime.minute.toString().padLeft(2, '0')}:${originalTime.second.toString().padLeft(2, '0')}';

      setState(() {
        logs.insert(0, result); // Add the new log to the top of the list
      });

      try {
        final supabase = Supabase.instance.client;
        final response = await supabase.from('action').insert({
          'sensor_a': result['A'] ?? false,
          'sensor_b': result['B'] ?? false,
          'sensor_c': result['C'] ?? false,
          'time': formattedTime.toString(),

        }).select();

        // Check if there was an error in the response
        if (response != null && response.isNotEmpty) {
          await fetchData();  // 데이터 삽입 후 새로 가져오기

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data sent successfully to Supabase!')),
          );
        }
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Error: $e')),
        // );
      }
    }
  }

  Future<void> fetchData() async {
    try {
      final response = await Supabase.instance.client
          .from('action')
          .select('sensor_a, sensor_b, sensor_c, time, id'); // 반드시 'id'를 포함

      setState(() {
        data = List<Map<String, dynamic>>.from(response as List).reversed.toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> _deleteItem(int index) async {
    try {
      // 선택된 항목의 id 확인

      final id = data[index]['id'];
      await Supabase.instance.client.from('action').delete().eq('id', id);

      setState(() {
        data.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete item: $e')),
      );
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
                color: Colors.redAccent,
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
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
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
                            'A: ${data[index]['sensor_a']} | B: ${data[index]['sensor_b']} | C: ${data[index]['sensor_c']} | Time: ${data[index]['time']}',
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
                                onPressed: () => _deleteItem(index),

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
  DateTime _time = DateTime.now();



  void _toggleSelectAll(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      _sensorA = _selectAll;
      _sensorB = _selectAll;
      _sensorC = _selectAll;
      _time = _time;

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
              'time': _time,

            });
          },
          child: const Text('RUN'),
        ),
      ],
    );
  }
}
