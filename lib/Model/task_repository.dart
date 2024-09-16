import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todotask/Model/task_data.dart';

class TaskRepository {
  final CollectionReference _tasksCollection =
  FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(TaskData task) async {
    try {
      final docRef = await _tasksCollection.add(task.toMap());
      await docRef.update({'id': docRef.id});
    } catch (e) {
      print('タスクの追加エラー: $e');
    }
  }

  Future<void> updateTask(TaskData task) async {
    try {
      await _tasksCollection.doc(task.id).update(task.toMap());
    } catch (e) {
      print('タスクの更新エラー: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksCollection.doc(taskId).delete();
    } catch (e) {
      print('タスクの削除エラー: $e');
    }
  }

  Stream<List<TaskData>> getTasks() {
    return _tasksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TaskData.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}