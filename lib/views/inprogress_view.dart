import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:kanban/data/board_data.dart';
import 'package:kanban/data/data_model.dart';
import 'package:kanban/services/kanban_board_service.dart';
import 'package:kanban/widgets/custom_dialog.dart';
import 'package:kanban/widgets/custom_task_card.dart';

class InProgressView extends StatefulWidget {
  const InProgressView({super.key});

  @override
  State<InProgressView> createState() => _InProgressViewState();
}

class _InProgressViewState extends State<InProgressView> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return inProgressTasks.isEmpty
        ? const Center(
            child: Text(
              'No In-Progress Tasks',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : AnimatedReorderableListView(
            items: inProgressTasks,
            itemBuilder: (BuildContext context, int index) {
              return CustomTaskCard(
                  key: ValueKey(inProgressTasks[index]),
                  task: inProgressTasks[index],
                  onRemove: () {
                    KanbanBoardService.inProgressToCompleted(index);
                    setState(() {});
                  },
                  actionButton: () {
                    KanbanBoardService.inProgressToCompleted(index);
                    setState(() {});
                  },
                  onEdit: () {
                    taskNameController.text = inProgressTasks[index].title;
                    taskDescriptionController.text =
                        inProgressTasks[index].description;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                              taskNameController: taskNameController,
                              taskDescriptionController:
                                  taskDescriptionController,
                              title: "Update Task",
                              onAction: () async {
                                KanbanBoardService.updateInProgressTask(
                                  index,
                                  Task(
                                    title: taskNameController.text,
                                    description: taskDescriptionController.text,
                                  ),
                                );
                                Navigator.pop(context);
                                taskNameController.clear();
                                taskDescriptionController.clear();
                                setState(() {});
                              });
                        });
                  });
            },
            enterTransition: [FlipInX(), ScaleIn()],
            exitTransition: [SlideInLeft()],
            insertDuration: const Duration(milliseconds: 5),
            removeDuration: const Duration(milliseconds: 5),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                final Task user = inProgressTasks.removeAt(oldIndex);
                inProgressTasks.insert(newIndex, user);
              });
            },
          );
  }
}
