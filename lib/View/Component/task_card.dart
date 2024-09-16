import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todotask/View/Component/task_modal.dart';
import 'package:todotask/View/Screen/task_detail_screen.dart';

import '../../Model/task_data.dart';
import '../../ViewModel/task_viewModel.dart';

class TaskCard extends StatelessWidget {
  final TaskData data;
  final TaskViewModel viewModel;

  const TaskCard({
    super.key,
    required this.data,
    required this.viewModel
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailScreen(
              data: data,
              viewModel: viewModel,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title),
              Row(
                children: [
                  Text(
                    data.date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.create,
                      color: Colors.blue,
                      size: 25,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return TaskModal(task: data, viewModel: viewModel);
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 25,
                    ),
                    onPressed: () {
                      viewModel.deleteTask(data.id!);
                    },
                  )
                ],
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}