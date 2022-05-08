import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/model_task.dart';
import 'package:flutter_application_1/screens/add_new_task.dart';
import 'package:flutter_application_1/screens/my_list_tile.dart';
import 'package:hive_flutter/adapters.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNewTask()));
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>("tasks").listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ToDay Tasks',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue),
                  child: Text(
                    box.length.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                if (box.values.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.note_alt_outlined,
                            size: 150,
                            color: Colors.grey.shade400,
                          ),
                          Text(
                            'No Notes',
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                      child: ListView.builder(
                          itemCount: box.values.length,
                          itemBuilder: (context, index) {
                            Task currentTask = box.getAt(index)!;
                            return MyListTile(currentTask, index);
                          }))
              ],
            ),
          );
        },
      ),
    );
  }
}
