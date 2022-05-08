// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/model_task.dart';
import 'package:flutter_application_1/screens/add_new_task.dart';

class MyListTile extends StatefulWidget {
  MyListTile(this.task, this.index, {Key? key}) : super(key: key);
  Task task;
  int index;
  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue.shade50,
      ),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.task.title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddNewTask(
                              task: widget.task,
                            )));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: () {
                    widget.task.delete();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          ),
          Text(
            widget.task.note!,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
