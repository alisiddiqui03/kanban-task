import 'package:kanban/data/board_data.dart';
import 'package:kanban/data/data_helper.dart';
import 'package:kanban/data/data_model.dart';
import 'package:kanban/storage/app_local_storage.dart';

class KanbanBoardService {
  // Add task to pending
  static addTaskToPending(Task task) async {
    if (task.title.isNotEmpty && task.description.isNotEmpty) {
      // Save task to pending
      pendingTasks.add(task);
      await AppLocalStorage.savePendingTasks(pendingTasks);
    }
  }

  // Move task from pending to in progress
  static pendingToInProgress(int index) {
    // Change task status to in progress
    pendingTasks[index].status = TaskStatus.inProgress;
    inProgressTasks.add(pendingTasks[index]);
    AppLocalStorage.saveInProgressTasks(inProgressTasks);

    // Remove task from pending
    pendingTasks.removeAt(index);
    AppLocalStorage.removePendingTask(index);
  }

  // Move task from in progress to completed
  static inProgressToCompleted(int index) {
    // Change task status to completed
    inProgressTasks[index].status = TaskStatus.completed;
    completedTasks.add(inProgressTasks[index]);
    AppLocalStorage.saveCompletedTasks(completedTasks);

    // Remove task from in progress
    inProgressTasks.removeAt(index);
    AppLocalStorage.removeInProgressTask(index);
  }

  // Remove task from pending
  static removePendingTask(int index) {
    // Remove task from pending
    pendingTasks.removeAt(index);
    AppLocalStorage.removePendingTask(index);
  }

  // Remove task from in progress
  static removeInProgressTask(int index) {
    // Remove task from in progress
    inProgressTasks.removeAt(index);
    AppLocalStorage.removeInProgressTask(index);
  }

  // Remove task from completed
  static removeCompletedTask(int index) {
    // Remove task from completed
    completedTasks.removeAt(index);
    AppLocalStorage.removeCompletedTask(index);
  }

  // Update pending task
  static updatePendingTask(int index, Task task) {
    pendingTasks[index] = task;
    AppLocalStorage.savePendingTasks(pendingTasks);
  }

  // Update in progress task
  static updateInProgressTask(int index, Task task) {
    inProgressTasks[index] = task;
    AppLocalStorage.saveInProgressTasks(inProgressTasks);
  }

  // Update completed task
  static updateCompletedTask(int index, Task task) {
    completedTasks[index] = task;
    AppLocalStorage.saveCompletedTasks(completedTasks);
  }
}
