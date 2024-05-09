import 'package:flutter/material.dart';
import 'package:kanban/data/board_data.dart';
import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:kanban/data/data_model.dart';
import 'package:kanban/services/kanban_board_service.dart';
import 'package:kanban/widgets/custom_dialog.dart';
import 'package:kanban/widgets/custom_task_card.dart';

class PendingView extends StatefulWidget {
  const PendingView({super.key});

  @override
  State<PendingView> createState() => _PendingViewState();
}

class _PendingViewState extends State<PendingView> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),

        // Pending Tasks
        pendingTasks.isEmpty
            ? const Expanded(
                child: Center(
                  child: Text(
                    'No Pending Tasks',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : Expanded(
                child: AnimatedReorderableListView(
                  items: pendingTasks,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomTaskCard(
                      actionButtonText: "In Progress",
                      key: ValueKey(pendingTasks[index]),
                      task: pendingTasks[index],
                      onRemove: () {
                        KanbanBoardService.removePendingTask(index);
                        setState(() {});
                      },
                      actionButton: () {
                        KanbanBoardService.pendingToInProgress(index);
                        setState(() {});
                      },
                      onEdit: () {
                        taskNameController.text = pendingTasks[index].title;
                        taskDescriptionController.text =
                            pendingTasks[index].description;
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog(
                                  taskNameController: taskNameController,
                                  taskDescriptionController:
                                      taskDescriptionController,
                                  title: "Update Task",
                                  onAction: () async {
                                    KanbanBoardService.updatePendingTask(
                                      index,
                                      Task(
                                        title: taskNameController.text,
                                        description:
                                            taskDescriptionController.text,
                                      ),
                                    );
                                    Navigator.pop(context);
                                    taskNameController.clear();
                                    taskDescriptionController.clear();
                                    setState(() {});
                                  });
                            });
                      },
                    );
                  },
                  enterTransition: [FlipInX(), ScaleIn()],
                  exitTransition: [SlideInLeft()],
                  insertDuration: const Duration(milliseconds: 5),
                  removeDuration: const Duration(milliseconds: 5),
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      final Task user = pendingTasks.removeAt(oldIndex);
                      pendingTasks.insert(newIndex, user);
                    });
                  },
                ),
              ),

        // Add Task Button
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                          taskNameController: taskNameController,
                          taskDescriptionController: taskDescriptionController,
                          title: "Add Task",
                          onAction: () async {
                            await KanbanBoardService.addTaskToPending(
                              Task(
                                title: taskNameController.text,
                                description: taskDescriptionController.text,
                              ),
                            );
                            Navigator.pop(context);
                            taskNameController.clear();
                            taskDescriptionController.clear();
                            setState(() {});
                          },
                        );
                      },
                    );
                    await Future.delayed(const Duration(milliseconds: 500));
                    setState(() {});
                  },
                  child: const Text(
                    'Add Task',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
