import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Task {
  String description;
  bool isCompleted;
  DateTime dateAdded;

  Task(this.description, this.isCompleted, this.dateAdded);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Checkbox(
                          value: _tasks[index].isCompleted,
                          onChanged: (newValue) {
                            setState(() {
                              _tasks[index].isCompleted = newValue!;
                            });
                          },
                        ),
                        title: Text(
                          _tasks[index].description,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            decoration: _tasks[index].isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(
                          'Added on: ${_tasks[index].dateAdded.toString().split(' ')[0]}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _tasks.removeAt(index);
                            });
                          },
                        ),
                      ),
                      Divider(
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    hintText: 'Enter task',
                  ),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      String newTask = _taskController.text;
                      if (newTask.isNotEmpty) {
                        _tasks.add(Task(newTask, false, DateTime.now()));
                        _taskController.clear();
                      }
                    });
                  },
                  child: Text(
                    'Add Task',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                    textStyle: TextStyle(fontSize: 20.0),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}
