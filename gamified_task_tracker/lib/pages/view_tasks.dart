import 'package:flutter/material.dart';
import 'edit_account.dart';
import '../style.dart';

class Task {
  final String task_name;
  final String description;
  final String points;

  Task(this.task_name, this.description, this.points);
}

/* used for testing - generates a dummy list of tasks */
void main() {
  runApp(MaterialApp(
    title: 'Tasks Page',
    home: ViewTasksPage(
      // generate list
      tasks: List.generate(
        10,
        (i) => Task(
          'Task $i',
          'Task Description $i',
          'Points $i',
        ),
      ),
    ),
  ));
}
//*/

// Tasks screen
class ViewTasksPage extends StatelessWidget {
  final List<Task> tasks;

  const ViewTasksPage({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Tasks",
            style: TextStyle(
              color: textColorAgainstPrimary,
            )),
        centerTitle: true,
        leading: GestureDetector(
            child: const Icon(
          Icons.arrow_back,
          color: textColorAgainstPrimary,
        )),
        actions: [
          GestureDetector(
            child: const Icon(
              Icons.settings,
              color: textColorAgainstPrimary,
            ),
            onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditAccountPage()
                      )
                  ),
          )
        ],
        backgroundColor: primaryColor,
      ),
      // List builder
      body: ListView.separated(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].task_name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewTasksDetail(task: tasks[index]),
                ),
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}

// detail screen
class ViewTasksDetail extends StatelessWidget {
  final Task task;
  const ViewTasksDetail({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${task.task_name}: ${task.points}",
              style: const TextStyle(
                color: textColorAgainstPrimary,
              )),
          leading: GestureDetector(
              child: const Icon(
                Icons.arrow_back,
                color: textColorAgainstPrimary,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.all(edgeInsets),
              child: Text(task.description),
            )));
  }
}
