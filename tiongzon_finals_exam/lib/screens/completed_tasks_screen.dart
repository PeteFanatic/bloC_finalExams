import 'package:bloc_finals_exam/bloc/blocExports.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/tasks_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.completedTasks;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text('${tasksList.length} Tasks'),
                ),
              ),
              const SizedBox(height: 10),
              TasksList(tasksList: tasksList),
            ],
          ),
        );
      },
    );
  }
}
