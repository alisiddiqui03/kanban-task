import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final TextEditingController taskNameController;
  final TextEditingController taskDescriptionController;
  final VoidCallback onAction;

  const CustomDialog({
    super.key,
    required this.taskNameController,
    required this.taskDescriptionController,
    required this.title,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: taskNameController,
            decoration: const InputDecoration(hintText: 'Task Name'),
          ),
          TextField(
            controller: taskDescriptionController,
            decoration: const InputDecoration(hintText: 'Task Description'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onAction,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
