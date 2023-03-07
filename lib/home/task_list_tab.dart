import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase_utils/firebase_utils.dart';
import 'package:to_do_app/home/task_item.dart';
import '../model/task.dart';
import '../my_theme.dart';
import '../provider/list_provider.dart';

class TaskListTab extends StatefulWidget {
  const TaskListTab({Key? key}) : super(key: key);

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    listProvider.getTaskFromFireStore();
    return Column(
      children: [
        CalendarTimeline(
          initialDate: listProvider.selectedDate,
          firstDate: DateTime.now().subtract(
            const Duration(days: 360),
          ),
          lastDate: DateTime.now().add(
            const Duration(days: 360),
          ),
          onDateSelected: (date) {
            listProvider.changeSelectedDate(date);
          },
          leftMargin: 20,
          monthColor: MyThemeData.primaryblue,
          dayColor: MyThemeData.blackColor,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: MyThemeData.primaryblue,
          dotsColor: const Color(0xFF333A47),
          locale: 'en_ISO',
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: listProvider.taskList.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  task: listProvider.taskList[index],
                );
              }),
        ),
      ],
    );
  }
}
