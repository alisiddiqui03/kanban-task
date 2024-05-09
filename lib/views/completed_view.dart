import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:kanban/data/board_data.dart';
import 'package:kanban/data/data_model.dart';
import 'package:kanban/services/kanban_board_service.dart';
import 'package:kanban/widgets/custom_task_card.dart';

class CompletedView extends StatefulWidget {
  const CompletedView({super.key});

  @override
  State<CompletedView> createState() => _CompletedViewState();
}

class _CompletedViewState extends State<CompletedView> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return completedTasks.isEmpty
        ? const Center(
            child: Text(
              'No Completed Tasks',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : AnimatedReorderableListView(
            items: completedTasks,
            itemBuilder: (BuildContext context, int index) {
              return CustomTaskCard(
                isCompletedCard: true,
                key: ValueKey(completedTasks[index]),
                task: completedTasks[index],
                onRemove: () {
                  KanbanBoardService.removeCompletedTask(index);
                  setState(() {});
                },
                actionButton: () {
                  KanbanBoardService.pendingToInProgress(index);
                  setState(() {});
                },
              );
            },
            enterTransition: [FlipInX(), ScaleIn()],
            exitTransition: [SlideInLeft()],
            insertDuration: const Duration(milliseconds: 5),
            removeDuration: const Duration(milliseconds: 5),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                final Task user = completedTasks.removeAt(oldIndex);
                completedTasks.insert(newIndex, user);
              });
            },
          );
  }
}
