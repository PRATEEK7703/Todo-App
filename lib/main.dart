import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Todo(),
    theme: ThemeData(
      primaryColor: Colors.deepPurple, // Floating action button color
      scaffoldBackgroundColor: Colors.grey[200],
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: Colors.deepOrange), // Background color
    ),
  ));
}

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

List<String> todoList = [];

class _TodoState extends State<Todo> {
  final TextEditingController textControl = TextEditingController();
  String newTask = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My TODO APP')),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
        child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, index) {
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                tileColor: Colors.white,
                leading: const Icon(Icons.book),
                title: Text(
                  todoList[index],
                  style: const TextStyle(fontSize: 20),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      todoList.removeAt(index);
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: textControl,
                      decoration: const InputDecoration(
                        hintText: 'Enter a new task',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          newTask = textControl.text;
                          todoList.add(newTask);
                          textControl.clear();
                          Navigator.pop(context); // Close the dialog
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
