import 'package:flutter/material.dart';
import '../Model/task_data.dart';
import '../Model/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _repository;

  TaskViewModel(this._repository) {
    _init();
  }

  List<TaskData> _tasks = [];
  String? _errorMessage;
  bool _isLoading = false;

  List<TaskData> get tasks => _tasks;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> _init() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _repository.getTasks().first;
    } catch (e) {
      _errorMessage = 'タスクの取得エラー: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(TaskData task) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.addTask(task);
      _tasks.add(task);
    } catch (e) {
      _errorMessage = 'タスクの追加エラー: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTask(TaskData task) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.updateTask(task);
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
      }
    } catch (e) {
      _errorMessage = 'タスクの更新エラー: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.deleteTask(taskId);
      _tasks.removeWhere((t) => t.id == taskId);
    } catch (e) {
      _errorMessage = 'タスクの削除エラー: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}