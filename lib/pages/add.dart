import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/todo_provider.dart';

class AddTodo extends ConsumerWidget {
  const AddTodo({super.key});

  void _addTodo(WidgetRef ref, TextEditingController titleController,
      TextEditingController contentController, BuildContext context) {
    if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
      ref
          .read(todoProvider.notifier)
          .addTodo(titleController.text, contentController.text);
      titleController.clear();
      contentController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill in the title and content"),
      ));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController titleController = new TextEditingController();
    TextEditingController contentController = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _addTodo(ref, titleController, contentController, context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: contentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  _addTodo(ref, titleController, contentController, context);
                  Navigator.pop(context);
                },
                child: Text("Add Todo"))
          ],
        ),
      ),
    );
  }
}
