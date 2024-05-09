import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kanban/data/data_model.dart';

class CustomTaskCard extends StatelessWidget {
  final Task task;
  final bool isCompletedCard;
  final VoidCallback onRemove;
  final VoidCallback actionButton;
  final VoidCallback? onEdit;
  final String actionButtonText;

  const CustomTaskCard({
    required this.task,
    required this.onRemove,
    required this.actionButton,
    this.isCompletedCard = false,
    this.actionButtonText = 'Complete',
    super.key,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    task.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const Spacer(),
                Text(
                  'Status: ${task.status.toString().split('.').last}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 88, 85, 85),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    task.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                if (!isCompletedCard) ...[
                  const Spacer(),
                  GestureDetector(
                    onTap: onEdit,
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ]
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onRemove,
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text('Remove',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 0,
                    ),
                  ),
                ),
                if (!isCompletedCard) ...[
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: actionButton,
                      icon: const Icon(Icons.arrow_right_outlined,
                          color: Colors.white),
                      label: Text(actionButtonText,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 13)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        elevation: 0,
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
