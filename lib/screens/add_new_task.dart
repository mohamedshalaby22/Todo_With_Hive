// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/model_task.dart';
import 'package:flutter_application_1/screens/my_home.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddNewTask extends StatefulWidget {
  AddNewTask({this.task, Key? key}) : super(key: key);
  Task? task;
  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController _titleController = TextEditingController(
        text: widget.task == null ? null : widget.task!.title!);
    TextEditingController _noteController = TextEditingController(
        text: widget.task == null ? null : widget.task!.note!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
        title: Text(
          widget.task == null ? 'Add New Task' : 'Update Your Task',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Task Title',
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return '';
                  }
                  return null;
                },
                controller: _titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Colors.blue.shade50,
                  filled: true,
                  hintText: 'Your Task',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Your Task Note',
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return '';
                  }
                  return null;
                },
                controller: _noteController,
                keyboardType: TextInputType.text,
                maxLines: 4,
                decoration: InputDecoration(
                  fillColor: Colors.blue.shade50,
                  filled: true,
                  hintText: 'Write your Notes ',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              var newTask = Task(
                                  title: _titleController.text,
                                  note: _noteController.text,
                                  creation_date: DateTime.now(),
                                  done: false);
                              Box<Task> taskbox = Hive.box<Task>("tasks");
                              if (widget.task != null) {
                                widget.task!.title = newTask.title;
                                widget.task!.note = newTask.note;
                                widget.task!.save();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const MyHome()));
                              } else {
                                await taskbox.add(newTask);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const MyHome()));
                              }
                            }
                          },
                          child: Text(
                            widget.task == null
                                ? 'Add New Task'
                                : 'Update Task',
                            style: const TextStyle(fontSize: 17),
                          ))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
