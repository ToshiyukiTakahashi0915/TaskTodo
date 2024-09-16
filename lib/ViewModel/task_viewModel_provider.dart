import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todotask/ViewModel/task_viewModel.dart';
import '../Model/task_repository.dart';

// TaskViewModelのプロバイダー
final taskViewModelProvider = ChangeNotifierProvider<TaskViewModel>((ref) {
  return TaskViewModel(TaskRepository());
});