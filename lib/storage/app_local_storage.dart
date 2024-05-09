import 'dart:convert';

import 'package:kanban/data/board_data.dart';
import 'package:kanban/data/data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? localStorage;

class AppLocalStorage {
  static initializeLocalStorage() async {
    localStorage = await SharedPreferences.getInstance();
  }

  static const String pendingTasksKey = 'pending_tasks';
  static const String inProgressTasksKey = 'in_progress_tasks';
  static const String completedTasksKey = 'completed_tasks';

  static loadAllTasks() {
    loadPendingTasks();
    loadInProgressTasks();
    loadCompletedTasks();
  }

  // Save pending tasks
  static savePendingTasks(List<Task> tasks) async {
    var taskList = tasks.map((task) => task.toJson()).toList();
    await localStorage?.setString(pendingTasksKey, json.encode(taskList));
  }

  // Remove pending selected pending task
  static removePendingTask(int index) {
    loadPendingTasks();
    List<Task> tasks = pendingTasks;
    tasks.removeAt(index);
    savePendingTasks(tasks);
  }

  // Save in progress tasks
  static saveInProgressTasks(List<Task> tasks) async {
    var taskList = tasks.map((task) => task.toJson()).toList();
    await localStorage?.setString(inProgressTasksKey, json.encode(taskList));
  }

  // Remove selected task in in-progress task
  static removeInProgressTask(int index) {
    loadInProgressTasks();
    List<Task> tasks = inProgressTasks;
    tasks.removeAt(index);
    saveInProgressTasks(tasks);
  }

  // Save completed tasks
  static saveCompletedTasks(List<Task> tasks) async {
    var taskList = tasks.map((task) => task.toJson()).toList();
    await localStorage?.setString(completedTasksKey, json.encode(taskList));
  }

  // Remove selected task in completed task
  static removeCompletedTask(int index) {
    loadCompletedTasks();
    List<Task> tasks = completedTasks;
    tasks.removeAt(index);
    saveCompletedTasks(tasks);
  }

  static loadPendingTasks() {
    var tasks = localStorage?.getString(pendingTasksKey);
    if (tasks != null) {
      var taskList = json.decode(tasks) as List;
      pendingTasks = taskList.map((task) => Task.fromJson(task)).toList();
    }
  }

  static loadInProgressTasks() {
    var tasks = localStorage?.getString(inProgressTasksKey);
    if (tasks != null) {
      var taskList = json.decode(tasks) as List;
      inProgressTasks = taskList.map((task) => Task.fromJson(task)).toList();
    }
  }

  static loadCompletedTasks() {
    var tasks = localStorage?.getString(completedTasksKey);
    if (tasks != null) {
      var taskList = json.decode(tasks) as List;
      completedTasks = taskList.map((task) => Task.fromJson(task)).toList();
    }
  }

  updatePendingTask(int index, Task task) {
    loadPendingTasks();
    pendingTasks[index] = task;
    savePendingTasks(pendingTasks);
  }

  updateInProgressTask(int index, Task task) {
    loadInProgressTasks();
    inProgressTasks[index] = task;
    saveInProgressTasks(inProgressTasks);
  }

  updateCompletedTask(int index, Task task) {
    loadCompletedTasks();
    completedTasks[index] = task;
    saveCompletedTasks(completedTasks);
  }
}
