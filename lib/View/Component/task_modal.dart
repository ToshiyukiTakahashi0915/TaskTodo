import 'package:flutter/material.dart';

import '../../Model/task_data.dart';
import '../../ViewModel/task_viewModel.dart';

class TaskModal extends StatefulWidget {
  final TaskViewModel viewModel;
  final TaskData? task;

  const TaskModal({Key? key, this.task, required this.viewModel}) : super(key: key);

  @override
  State<TaskModal> createState() => _TaskModalState();
}

class _TaskModalState extends State<TaskModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title);
    _dateController = TextEditingController(text: widget.task?.date);
    _bodyController = TextEditingController(text: widget.task?.body);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? '新規タスク' : 'タスク編集'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'タイトル'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'タイトルを入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: '日付'),
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _dateController.text =
                          "${pickedDate.year}/${pickedDate.month}/${pickedDate.day}";
                        });
                      }
                    }
                ),
              SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: InputDecoration(labelText: '内容'),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newTask = TaskData(
                id: widget.task?.id,
                title: _titleController.text,
                date: _dateController.text,
                body: _bodyController.text,
              );
              widget.viewModel.addTask(newTask);
              Navigator.pop(context);
            }
          },
          child: Text('保存'),
        ),
      ],
    );
  }
}