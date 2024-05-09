import 'package:kanban/data/data_helper.dart';

class Task {
  final String title;
  final String description;
  TaskStatus status;

  Task({
    required this.title,
    required this.description,
    this.status = TaskStatus.pending,
  });

  // Method to convert Task object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'status': status.toString().split('.').last, // Convert enum to string
    };
  }

  // Static method to create a Task object from JSON
  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      status: TaskStatus.values.firstWhere((e) =>
          e.toString().split('.').last ==
          json['status']), // Convert string to enum
    );
  }
}
